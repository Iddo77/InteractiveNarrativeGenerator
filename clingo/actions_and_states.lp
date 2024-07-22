#include "entities.lp".

% ------------------------------------------------
% ACTIONS
% ------------------------------------------------

% person interactions
action(talk_to, P) :- person(P).
action(admire, P) :- person(P), P != protagonist.
action(intimidate, P) :- person(P), P != protagonist.
action(heal, P) :- person(P).

% item actions
action(break, I) :- item(I).
action(repair, I) :- item(I).
action(take, I) :- item(I).
action(request, I) :- item(I).
action(buy, I) :- item(I).

% actions for thieves
action(steal, I) :- item(I).
action(unlock, C) :- chest(C).

% aggressive actions
action(attack, P) :- person(P), P != protagonist.

% ------------------------------------------------
% STATES
% ------------------------------------------------

% state types
state_type(owns; relation; health; condition; lock).
health_state(healthy; injured; dead).
relation_state(hates; dislikes; neutral; likes; loves).
condition_state(intact; broken; destroyed).
lock(locked; unlocked).

% states of entities
state(owns, E, P) :- item(E), person(P).
state(owns, E, C) :- item(E), chest(C).
state(relation, E, S) :- person(E), E != protagonist, relation_state(S).
state(health, E, S) :- person(E), health_state(S).
state(condition, E, S) :- item(E), condition_state(S).
state(lock, C, S) :- chest(C), lock(S).

#show action/2.
#show state/3.
