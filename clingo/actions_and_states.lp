#include "entities.lp".

% ------------------------------------------------
% ACTIONS
% ------------------------------------------------

% person interactions
action(talk_to, P) :- person(P).
action(admire, P) :- person(P), P != protagonist.
action(intimidate, P) :- person(P), P != protagonist.
action(befriend, P) :- person(P), P != protagonist.
action(antagonize, P) :- person(P), P != protagonist.
action(heal, P) :- person(P).
action(help, P) :- person(P), P != protagonist.

% item actions
action(break, I) :- item(I).
action(repair, I) :- item(I).
action(destroy, I) :- item(I).
action(give, I) :- item(I).
action(take, I) :- item(I).
action(request, I) :- item(I).
action(sell, I) :- item(I).
action(buy, I) :- item(I).
action(use, I) :- item(I).

% actions for thieves
action(steal, I) :- item(I).
action(steal_from, P) :- person(P), P != protagonist.
action(unlock, C) :- chest(C).
action(lockpick, C) :- chest(C).

% aggressive actions
action(attack, P) :- person(P), P != protagonist.
action(defend, P) :- person(P), P != protagonist.
action(kill, P) :- person(P), P != protagonist.

% ------------------------------------------------
% STATES
% ------------------------------------------------

% state types
state_type(owns; emotion; relation; health; item_property).
health_state(healthy; injured; dead).
emotion_state(happy; angry; sad; scared; surprised).
relation_state(unknown; hates; dislikes; neutral; likes; loves).
item_state(intact; broken; destroyed).
chest_state(locked; unlocked).

% states of entities
state(owns, E, P) :- item(E), person(P).
state(owns, E, C) :- item(E), chest(C).
state(emotion, E, S) :- person(E), emotion_state(S).
state(relation, E, S) :- person(E), E != protagonist, relation_state(S).
state(health, E, S) :- person(E), health_state(S).
state(item_property, E, S) :- item(E), item_state(S).
state(chest_property, C, S) :- chest(C), chest_state(S).

#show action/2.
#show state/3.
