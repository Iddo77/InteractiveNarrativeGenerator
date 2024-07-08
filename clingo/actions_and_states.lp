#include "vertices_and_edges.lp".

% ------------------------------------------------
% PERSON AND ITEM DEFINITIONS
% ------------------------------------------------

% persons, items and chests are defined
person(protagonist; fighter; thief; bard; mage; cleric).
chest(old_chest; sturdy_chest).
item(rusty_key; shiny_key; lockpick; gold_ring; shimmering_ring; tome; book_of_secrets; map).
item(diamond; gold_coins; copper_coins; rusty_sword; pristine_sword; dagger; staff; shield; flute).
item(amulet; ancient_scroll; magic_potion).
precious_item(gold_ring; shimmering_ring; tome; book_of_secrets; map; diamond; gold_coins; amulet; ancient_scroll).
key(rusty_key; shiny_key).

entity(X) :- person(X).
entity(X) :- item(X).
entity(X) :- chest(X).

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

% ------------------------------------------------
% START STATES
% ------------------------------------------------

{ start_state(owns, I, P) : person(P); start_state(owns, I, C) : chest(C) } = 1 :- item(I).
% achieved: in the start state every item is owned by 1 person or 1 chest.

1 { start_state(owns, I, C) : precious_item(I) } 3 :- chest(C).
1 { start_state(owns, I, P) : item(I) } 3 :- person(P).
% achieved: in the start state every person or chest owns 1 to 3 items

start_state(owns, pristine_sword, fighter).
start_state(owns, shield, fighter).
start_state(owns, lockpick, thief).
start_state(owns, flute, bard).
start_state(owns, staff, mage).
start_state(owns, magic_potion, cleric).
start_state(owns, rusty_sword, protagonist).
:- start_state(owns, I, protagonist), precious_item(I).
:- start_state(owns, I, protagonist), key(I).
:- start_state(owns, I, thief), key(I).  % the thief already has a lockpick
:- start_state(owns, I, C), key(I), chest(C).
:- start_state(owns, K1, P), start_state(owns, K2, P), key(K1), key(K2), K1 != K2.
% achieved: some restrictions for the start state

{ start_state(emotion, P, E) : emotion_state(E) } = 1 :- person(P).
{ start_state(emotion, P, happy) : person(P) } = 4.
start_state(emotion, protagonist, happy).
% achieved: in the start state every person has 1 emotion; 4 of them are happy, including the protagonist.

{ start_state(relation, P, R) : relation_state(R) } = 1 :- person(P), P != protagonist.
% achieved: in the start state every person has 1 relation to the protagonist

{ start_state(health, P, E) : health_state(E) } = 1 :- person(P).
:- start_state(health, _, dead).
:- #count{1, P: start_state(health, P, injured)} > 2.
% achieved: in the start state every person has 1 health state; no one is dead and at most 2 are injured.

1 { start_state(item_property, I, E) : item_state(E) } 1 :- item(I).
:- start_state(item_property, _, destroyed).
:- #count{1, I: start_state(item_property, I, broken)} > 4.
% achieved: in the start state every person has 1 health state; no items are destroyed and at most 4 are broken.

start_state(chest_property, C, locked) :- chest(C).
% achieved: all chests are locked in the start state

#show entity/1.
#show action/2.
#show start_state/3.
