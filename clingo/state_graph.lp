#include "vertices_and_edges.lp".
#include "actions_and_states.lp".
#include "static_start_states.lp".

state_at(start, T, E, S) :- start_state(T, E, S).
% achieved: the start_states are used as states at the start vertex

S1 = S2 :- state_at(V, T, E, S1), state_at(V, T, E, S2).
% achieved: a vertex contains only 1 state per entity

:- state_at(U, T, E, _), not state_at(V, T, E, _), edge(U, V).
% achieved: connected vertices have the same entities in their states

state_change(U, V, T, E, S1, S2) :-
    state_at(U, T, E, S1),
    state_at(V, T, E, S2),
    edge(U, V),
    S1 != S2.
% achieved: define a state change between two connected vertices

{ state_change(U, V, T, E, S1, S2) : state(T, E, S1), state(T, E, S2), S1 != S2 } = 1 :- edge(U, V).
% achieved: ensure a single state change between every two connected vertices

state_at(V, T, E, S) :- state_at(U, T, E, S), edge(U, V), not state_change(U, V, T, E, S, _).
state_at(U, T, E, S) :- state_change(U, V, T, E, S, _), edge(U, V).
state_at(V, T, E, S) :- state_change(U, V, T, E, _, S), edge(U, V).
% achieved: ensure the states at vertex V are derived from the states at vertex U with the state change

{ action_at(U, V, A, E) : action(A, E) } :- state_change(U, V, _, E, _, _).
{ action_at(U, V, A, E) : action(A, E) } :- state_change(U, V, _, protagonist, _, _).
% achieved: define an action at an edge that matches the state_change for that edge

:- state_change(U, V, _, E, _, _), #count { A : action_at(U, V, A, E) } != 1.
% achieved: there is only 1 action_at for each state change

#show state_at/4.
#show state_change/6.
#show action_at/4.
