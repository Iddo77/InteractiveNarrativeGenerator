#include "vertices_and_edges.lp".
#include "actions_and_states.lp".
#include "static_start_states.lp".

% ------------------------------------------------
% ASSIGN STATES TO EACH VERTEX
% ------------------------------------------------

state_at(start, T, E, S) :- start_state(T, E, S).
% achieved: the start_states are used as states at the start vertex

state_type_entity_combo(T, E) :- state(T, E, _).
{ state_at(U, T, E, S) : state(T, E, S) } = 1 :- vertex(U), state_type_entity_combo(T, E).
% achieved: for every state-type/entity combination, a state is assigned to each vertex

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

#show action_name/1.
#show action_at/4.
#show state_at/4.
