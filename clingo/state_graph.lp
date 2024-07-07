% input:
% - vertices: vertex/1
% - edges: edge/2
% - persons (e.g. gandalf; tom): person/1
% - items (e.g. sword; pen): item/1
% - states (e.g. broken; angry; dead): state/1
% - actions (e.g. strike; talk_to): action/1
% - forbidden state changes (e.g. dead -> alive): forbidden_state_change/2
% - allowed action usage  (e.g. (strike, sword)): allowed_action_use/2
% - allowed action targets (e.g. (strike, gandalf): allowed_action_target/2
% - a set of emotional statuses of persons: emotion_status/1
% - a set of relational statuses persons in relation to the protagonist: relation_status/1
% - a set of health statuses of a person: health_status/1
% - a set of item property statuses: item_property_status/1

#const num_states_per_vertex = 10.

entity(X) :- person(X).
entity(X) :- item(X).
% achieved: define entity as person or item

person(protagonist).
% achieved: every story needs a protagonist, which is a person

state(owns, E, P) :- item(E), person(P).
state(emotion, E, S) :- person(E), emotion_status(S).
state(relation, E, S) :- person(E), E != protagonist, relation_status(S).
state(health, E, S) :- person(E), health_status(S).
state(item_property, E, S) :- item(E), item_property_status(S).
% achieved: state definitions created with different status types

state_at(T, E, S, V) :- state(T, E, S), vertex(V).
% achieved: the state of an entity at a vertex is defined. Each has a type, an entity and a state.

{ state_at(T, E, S, V) : state(T, E, S) } = num_states_per_vertex :- vertex(V).
% achieved: ensure a fixed number of states per vertex

state_change(T, E, S1, S2, U, V) :-
    state_at(T, E, S1, U),
    state_at(T, E, S2, V),
    edge(U, V),
    S1 != S2,
    not forbidden_state_change(S1, S2),
    T != owns.
state_change(owns, I, P1, P2, U, V) :-
    state_at(owns, I, P1, U),
    state_at(T, I, P2, V),
    edge(U, V),
    P1 != P2.
% achieved: define a state change between two connected vertices

{ state_change(T, E, S1, S2, U, V) : state(T, E, S1), state(T, E, S2) } = 1 :- edge(U, V).
% achieved: ensure a single state change between every two connected vertices

state_at(T, E, S, V) :- state_at(T, E, S, U), edge(U, V), not state_change(T, E, S, _, U, V).
state_at(T, E, S2, V) :- state_change(T, E, _, S2, U, V), edge(U, V).
% achieved: ensure the states at vertex V are derived from the states at vertex U with the state change

action_at(A, U, V, EntityUsed, TargetEntity) :-
    action(A),
    entity(EntityUsed),
    entity(TargetEntity),
    allowed_action_use(A, EntityUsed),
    allowed_action_target(A, TargetEntity),
    state_change(_, EntityUsed;TargetEntity, _, _, U, V).
% achieved: define an action at an edge, ensuring it is allowed with specified entities

#show action_at/5.
#show state_at/4.
