#include "actions_and_states.lp".

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

#show start_state/3.
