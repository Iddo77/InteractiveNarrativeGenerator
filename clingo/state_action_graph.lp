#include "vertices_and_edges.lp".
#include "actions_and_states.lp".
#include "static_start_states.lp".
#include "preconditions.lp".

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

affected_entity(U, T, E) :- action_at(U, _, _, E), state_at(U, T, E, _).
% achieved: an entity is directly affected by an action
affected_entity(U, T, O) :- action_at(U, _, _, I), item(I), state_at(U, owns, I, O), state_at(U, T, O, _), person(O).
% achieved: the owner of an item is affected by action on the item
state_at(V, T, E, S) :-  state_at(U, T, E, S), not affected_entity(U, T, E), edge(U, V).
% achieved: copy states unaffected by an action

state_type_entity_combo(T, E) :- state(T, E, _).
{ state_at(U, T, E, S) : state(T, E, S) } = 1 :- vertex(U), state_type_entity_combo(T, E).
% achieved: for every state-type/entity combination, a state is assigned to each vertex

% ------------------------------------------------
% STATE CHANGES
% ------------------------------------------------

state_change(U, V, T, E, S1, S2) :-
    state_at(U, T, E, S1),
    state_at(V, T, E, S2),
    edge(U, V),
    S1 != S2.
% achieved: define a state change between two connected vertices

#show action_name/1.
#show action_at/4.
#show state_at/4.
#show state_change/6.
#show affected_entity/3.
