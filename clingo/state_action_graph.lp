#include "vertices_and_edges.lp".
#include "actions_and_states.lp".
#include "static_start_states.lp".
#include "preconditions.lp".
#include "effects.lp".

% ------------------------------------------------
% ASSIGN START-STATES
% ------------------------------------------------

state_at(start, T, E, S) :- start_state(T, E, S).
% achieved: the start_states are used as states at the start vertex

% ------------------------------------------------
% ASSIGN 1 ACTION TO EACH EDGE
% ------------------------------------------------

{ action_at(U, V, A, E) : action(A, E) } = 1 :- edge(U, V).
% achieved: a single action is assigned to each edge

action_name(A) :- action(A, _).
:- action_name(A), not 1 { action_at(U, V, A, E) : edge(U, V) }.
% achieved: every action is used at least once

:- entity(E), not 1 { action_at(U, V, A, E) : edge(U, V) }.
% achieved: every entity is used at least once

V1 = V2:- action_at(U, V1, A, E), action_at(U, V2, A, E).
% achieved: every action-entity combination is unique for each vertex
:- vertex(U), action_name(A), #count { V, E : action_at(U, V, A, E) } > 2.
:- vertex(U), entity(E), #count { V, A : action_at(U, V, A, E) } > 2.
% achieved: every action or entity can occur at most 2 times for each vertex

% ------------------------------------------------
% ASSIGN STATES TO EACH VERTEX
% ------------------------------------------------

1 { effect_at(V, A, T, E, S) : possible_effect_at(V, A, T, E, S)  } 2 :- action_at(U, V, A, _).
% achieved: choose 1 or 2 effects out of all possible effects for an action-at

S1 = S2 :- effect_at(V, A, T, E, S1), effect_at(V, A, T, E, S2).
% achieved: effects cannot only differ in state-value

S1 = S2 :- state_at(V, T, E, S1), state_at(V, T, E, S2).
% achieved: states cannot only differ in state-value

state_at(V, T, E, S) :- effect_at(V, A, T, E, S).
% achieved: effects change the state

state_type_entity_combo(T, E) :- state(T, E, S).
% achieved: get all allowed combinations of state-type and entity

affected_entity(V, T, E) :- effect_at(V, A, T, E, S).
% achieved: collect all entities affected by an action

unaffected_entity(V, T, E) :- edge(U, V), not affected_entity(V, T, E),  state_type_entity_combo(T, E).
% achieved: collect all entities not affected by an action

unaffected_state(V, T, E, S) :- state_at(U, T, E, S),  edge(U, V), unaffected_entity(V, T, E).
% achieved: get all possible states for unaffected entities

unaffected_state_count(V, T, E, S, N) :- unaffected_state(V, T, E, S),
    N = #count { U : state_at(U, T, E, S), edge(U, V) }.

most_common_unaffected_state(V, T, E, S) :- unaffected_state_count(V, T, E, S, N),
    N = #max { N1 : unaffected_state_count(V, T, E, _, N1) }.
% achieve: collect the unaffected states that are the most common (occur the most)

{ state_at(V, T, E, S) : most_common_unaffected_state(V, T, E, S) } = 1 :- edge(_, V),
    most_common_unaffected_state(V, T, E, _).
% achieved: select 1 state for each unaffected entity

% ------------------------------------------------
% STATE CHANGES
% ------------------------------------------------

state_change(U, V, T, E, S1, S2) :-
    state_at(U, T, E, S1),
    state_at(V, T, E, S2),
    edge(U, V),
    S1 != S2.
% achieved: define a state change between two connected vertices

#show action_at/4.
#show state_at/4.
#show state_change/6.
#show possible_effect_at/5.
#show effect_at/5.
#show affected_entity/3.
#show unaffected_entity/3.
#show unaffected_state/4.
#show unaffected_state_count/5.
#show most_common_unaffected_state/4.
