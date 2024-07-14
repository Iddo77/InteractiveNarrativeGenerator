from collections import defaultdict

from generate_single_answer_set_clingo_file import run_clingo_file


def validate_state_graph():
    atoms = run_clingo_file('state_graph.lp', 1)
    state_changes = [a for a in atoms if a.name == 'state_change']
    state_ats = [a for a in atoms if a.name == 'state_at']
    state_at_dict = defaultdict(list)
    for state_at in state_ats:
        state_at_str = ', '.join(str(a) for a in state_at.arguments[1:])
        state_at_dict[state_at.arguments[0]].append(state_at_str)

    for state_change in state_changes:
        args = state_change.arguments
        state_before_str = ', '.join(str(a) for a in args[2:5])
        state_after_str = ', '.join(str(a) for a in (args[2], args[3], args[5]))
        vertex_before = state_change.arguments[0]
        vertex_after = state_change.arguments[1]
        before_states = state_at_dict[vertex_before]
        after_states = state_at_dict[vertex_after]
        # compare before to after
        diff = list(set(before_states).difference(set(after_states)))
        assert len(diff) == 1, "There is not a single state change between 2 vertices"
        assert diff[0] == state_before_str, "Unexpected state change from before to after"
        # compare after to before
        diff = list(set(after_states).difference(set(before_states)))
        assert len(diff) == 1, "There is not a single state change between 2 vertices"
        assert diff[0] == state_after_str, "Unexpected state change from after to before"

    print("There is only a single state change between all connected vertices.")


if __name__ == '__main__':
    validate_state_graph()
