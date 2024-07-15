from collections import defaultdict

from generate_single_answer_set_clingo_file import run_clingo_file


class StateDict:
    def __init__(self):
        self.data = defaultdict(lambda: defaultdict(lambda: defaultdict(dict)))

    def add(self, vertex, state_type, entity, state_value):
        self.data[vertex][entity][state_type] = state_value

    def __getitem__(self, key):
        return self.data[key]

    def __iter__(self):
        return iter(self.data)

    def __repr__(self):
        return str(self.data)


class ActionDict:
    def __init__(self):
        self.data = defaultdict(lambda: defaultdict(lambda: defaultdict(dict)))
        self.action_vertex_map = dict()

    def add(self, start_vertex, end_vertex, action, entity):
        self.data[action][start_vertex][entity] = end_vertex

    def __getitem__(self, key):
        return self.data[key]

    def __iter__(self):
        return iter(self.data)

    def __repr__(self):
        return str(self.data)


class PreconditionDict:
    def __init__(self):
        self.data = defaultdict(lambda: defaultdict(list))

    def add(self, action, state_type, state):
        self.data[action][state_type].append(state)

    def __getitem__(self, key):
        return self.data[key]

    def __iter__(self):
        return iter(self.data)

    def __repr__(self):
        return str(self.data)


def validate_preconditions():
    atoms = run_clingo_file('state_action_graph.lp', 1)

    state_dict = StateDict()
    state_ats = [a for a in atoms if a.name == 'state_at']
    for state_at in state_ats:
        state_dict.add(*[str(x) for x in state_at.arguments])

    action_dict = ActionDict()
    action_ats = [a for a in atoms if a.name == 'action_at']
    for action_at in action_ats:
        action_dict.add(*[str(x) for x in action_at.arguments])

    precondition_dict = PreconditionDict()
    preconditions = [a for a in atoms if a.name == 'precondition']
    for pre in preconditions:
        # for example: precondition(kill, health, injured).
        precondition_dict.add(*[str(x) for x in pre.arguments])

    # validate simple preconditions
    for action in precondition_dict:
        action_precondition_map = precondition_dict[action]
        action_start_vertex_map = action_dict[action]
        for start_vertex in action_start_vertex_map:
            for entity in action_start_vertex_map[start_vertex]:
                for state_type in action_precondition_map:
                    allowed_state_values = action_precondition_map[state_type]
                    actual_state_value = state_dict[start_vertex][entity][state_type]
                    if actual_state_value not in allowed_state_values:
                        raise ValueError(f"Precondition failed for: {action}, {state_type}")

    print('All simple preconditions are met')

    ownership_dict = defaultdict(list)
    for vertex in state_dict:
        for item in state_dict[vertex]:
            if 'owns' in state_dict[vertex][item]:
                owner = state_dict[vertex][item]['owns']
                ownership_dict[(vertex, owner)].append(item)

    # validate complex preconditions

    # :- action_at(U, V, take, I), state_at(U, owns, I, E), not chest(E), not state_at(U, health, E, dead).
    action_start_vertex_map = action_dict['take']
    for start_vertex in action_start_vertex_map:
        for item in action_start_vertex_map[start_vertex]:
            owner = state_dict[start_vertex][item]['owns']
            is_chest = 'chest' in owner
            if is_chest:
                continue  # valid
            if state_dict[start_vertex][owner]['health'] != 'dead':
                raise ValueError("Precondition failed for: take")

    # :- action_at(U, V, request, I), state_at(U, owns, I, P), not state_at(U, relation, P, loves).
    action_start_vertex_map = action_dict['request']
    for start_vertex in action_start_vertex_map:
        for item in action_start_vertex_map[start_vertex]:
            owner = state_dict[start_vertex][item]['owns']
            if state_dict[start_vertex][owner]['relation'] != 'loves':
                raise ValueError("Precondition failed for: request")

    # :- action_at(U, V, buy, I), state_at(U, owns, I, protagonist).
    # :- action_at(U, V, buy, I), state_at(U, owns, I, C), chest(C).
    # :- action_at(U, V, buy, I), state_at(U, owns, I, P), state_at(U, health, P, dead).
    # :- action_at(U, V, buy, I), state_at(U, owns, I, P), state_at(U, relation, P, hates).
    # :- action_at(U, V, buy, I), not state_at(U, owns, M, protagonist), money(M).
    action_start_vertex_map = action_dict['buy']
    for start_vertex in action_start_vertex_map:
        for item in action_start_vertex_map[start_vertex]:
            owner = state_dict[start_vertex][item]['owns']
            if 'chest' in owner or owner == 'protagonist':
                raise ValueError("Precondition failed for: buy")
            elif state_dict[start_vertex][owner]['health'] == 'dead':
                raise ValueError("Precondition failed for: buy")
            elif state_dict[start_vertex][owner]['relation'] == 'hates':
                raise ValueError("Precondition failed for: buy")
            elif 'gold_coins' not in ownership_dict[(start_vertex, 'protagonist')]:
                raise ValueError("Precondition failed for: buy")

    # :- action_at(U, V, steal, I), state_at(U, owns, I, protagonist).
    # :- action_at(U, V, steal, I), state_at(U, owns, I, C), chest(C).
    # :- action_at(U, V, steal, I), state_at(U, owns, I, P), state_at(U, health, P, dead).
    # :- action_at(U, V, steal, I), state_at(U, owns, I, P), state_at(U, relation, P, loves).
    action_start_vertex_map = action_dict['steal']
    for start_vertex in action_start_vertex_map:
        for item in action_start_vertex_map[start_vertex]:
            owner = state_dict[start_vertex][item]['owns']
            if 'chest' in owner or owner == 'protagonist':
                raise ValueError("Precondition failed for: steal")
            elif state_dict[start_vertex][owner]['health'] == 'dead':
                raise ValueError("Precondition failed for: buy")
            elif state_dict[start_vertex][owner]['relation'] == 'loves':
                raise ValueError("Precondition failed for: buy")

    # :- action_at(U, V, unlock, C), not state_at(U, owns, K, protagonist), key(K).
    action_start_vertex_map = action_dict['unlock']
    for start_vertex in action_start_vertex_map:
        if 'rusty_key' not in ownership_dict[(start_vertex, 'protagonist')]:
            raise ValueError("Precondition failed for: unlock")

    # :- action_at(U, V, lockpick, C), not state_at(U, owns, lockpick, protagonist).
    action_start_vertex_map = action_dict['lockpick']
    for start_vertex in action_start_vertex_map:
        if 'lockpick' not in ownership_dict[(start_vertex, 'protagonist')]:
            raise ValueError("Precondition failed for: lockpick")

    # :- action_at(U, V, attack, P), not state_at(U, owns, W, protagonist), weapon(W).
    action_start_vertex_map = action_dict['attack']
    for start_vertex in action_start_vertex_map:
        if not any(is_weapon(item) for item in ownership_dict[(start_vertex, 'protagonist')]):
            raise ValueError("Precondition failed for: attack")

    # :- action_at(U, V, kill, P), not state_at(U, owns, W, protagonist), weapon(W).
    action_start_vertex_map = action_dict['kill']
    for start_vertex in action_start_vertex_map:
        if not any(is_weapon(item) for item in ownership_dict[(start_vertex, 'protagonist')]):
            raise ValueError("Precondition failed for: kill")

    # :- action_at(U, V, heal, P), not state_at(U, owns, H, protagonist), healing_item(H).
    action_start_vertex_map = action_dict['heal']
    for start_vertex in action_start_vertex_map:
        if 'magic_potion' not in ownership_dict[(start_vertex, 'protagonist')]:
            raise ValueError("Precondition failed for: heal")

    print('All complex preconditions are met')


def is_weapon(item) -> bool:
    return item in {'staff', 'dagger', 'rusty_sword'}


if __name__ == '__main__':
    validate_preconditions()
