#include "actions_and_states.lp".

{ start_state(owns, I, P) : person(P); start_state(owns, I, C) : chest(C) } = 1 :- item(I).
% achieved: in the start state every item is owned by 1 person or 1 chest.

1 { start_state(owns, I, P) : item(I) } 3 :- person(P).
% achieved: in the start state every person owns 1 to 3 items

{ start_state(owns, I, C) : precious_item(I) } = 1 :- chest(C).
:- start_state(owns, I, C), chest(C), not precious_item(I).
% achieved: in the start state the chest 1 precious item

0 { start_state(owns, I, P) : weapon(I) } 1 :- person(P).
{ start_state(owns, I, fighter) : weapon(I) } = 1.
% achieved: in the start state every person owns at most 1 weapon. The fighter must have a weapon.

start_state(owns, lockpick, thief).
% achieved: the thief owns the lockpick

{ start_state(owns, I, bard) : key(I) } = 1.
% achieved: the bard owns a key

{ start_state(owns, I, mage) : healing_item(I) } = 1.
% achieved: the mage owns a healing item

start_state(owns, gold_coins, protagonist).
% achieved: the protagonist owns money

:- start_state(owns, I, protagonist), precious_item(I).
:- start_state(owns, I, protagonist), key(I).
:- start_state(owns, I, thief), key(I), I != lockpick.  % the thief already has a lockpick
:- start_state(owns, I, C), key(I), chest(C).
% achieved: some restrictions for the start state

{ start_state(relation, P, R) : relation_state(R) } = 1 :- person(P), P != protagonist.
% achieved: in the start state every person has 1 relation to the protagonist

1 { start_state(relation, P, loves) : person(P), P != protagonist }.
1 { start_state(relation, P, hates) : person(P), P != protagonist }.
% achieved: in the start state at least 1 person hates and at least 1 person loves the protagonist

{ start_state(health, P, E) : health_state(E) } = 1 :- person(P).
:- start_state(health, _, dead).
:- #count{1, P: start_state(health, P, injured)} > 2.
% achieved: in the start state every person has 1 health state; no one is dead and at most 2 are injured.

1 { start_state(condition, I, E) : condition_state(E) } 1 :- item(I).
:- start_state(condition, _, destroyed).
:- #count{1, I: start_state(condition, I, broken)} > 4.
% achieved: in the start state every person has 1 health state; no items are destroyed and at most 4 are broken.

start_state(lock, C, locked) :- chest(C).
% achieved: all chests are locked in the start state

#show start_state/3.
