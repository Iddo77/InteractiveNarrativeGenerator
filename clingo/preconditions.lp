% ------------------------------------------------
% GENERAL PRECONDITIONS
% ------------------------------------------------

:- action_at(U, V, A, E) , state_at(U, health, protagonist, dead).
% achieved: general precondition for actions: protagonist is not dead

:- action_at(U, V, A, P) , state_at(U, health, P, dead).
% achieved: general precondition for actions: person is not dead

:- action_at(U, V, A, I) , state_at(U, condition, I, destroyed).
% achieved: general precondition for actions: item is not destroyed

% ------------------------------------------------
% SIMPLE STATE PRECONDITIONS
% ------------------------------------------------

has_precondition(admire, relation).
precondition(admire, relation, likes).

has_precondition(intimidate, relation).
precondition(intimidate, relation, neutral; dislikes).

has_precondition(befriend, relation).
precondition(befriend, relation, dislikes; neutral).

has_precondition(antagonize, relation).
precondition(antagonize, relation, likes; neutral).

has_precondition(heal, health).
precondition(heal, health, injured).

has_precondition(break, condition).
precondition(break, condition, intact).

has_precondition(repair, condition).
precondition(repair, condition, broken).

has_precondition(sell, owns).
precondition(sell, owns, protagonist).

has_precondition(attack, relation).
precondition(attack, relation, neutral; dislikes; hates).

has_precondition(kill, relation).
precondition(kill, relation, dislikes; hates).

has_precondition(kill, health).
precondition(kill, health, injured).

:- action_at(U, V, A, E), state_at(U, T, E, S), has_precondition(A, T), not precondition(A, T, S).
% achieved: if an action has a precondition, then this precondition must hold

% ------------------------------------------------
% COMPLEX PRECONDITIONS
% ------------------------------------------------

:- action_at(U, V, take, I), state_at(U, owns, I, E), not chest(E), not state_at(U, health, E, dead).
% achieved: you can only take items from chests or dead persons

:- action_at(U, V, request, I), state_at(U, owns, I, P), not state_at(U, relation, P, loves).
% achieved: you can only request items from person that love you

:- action_at(U, V, buy, I), state_at(U, owns, I, protagonist).
:- action_at(U, V, buy, I), state_at(U, owns, I, C), chest(C).
:- action_at(U, V, buy, I), state_at(U, owns, I, P), state_at(U, health, P, dead).
:- action_at(U, V, buy, I), state_at(U, owns, I, P), state_at(U, relation, P, hates).
:- action_at(U, V, buy, I), not state_at(U, owns, M, protagonist), money(M).
% achieved: you can only buy items from other persons that are not dead and don't hate you. Also you need money.

:- action_at(U, V, steal, I), state_at(U, owns, I, protagonist).
:- action_at(U, V, steal, I), state_at(U, owns, I, C), chest(C).
:- action_at(U, V, steal, I), state_at(U, owns, I, P), state_at(U, health, P, dead).
:- action_at(U, V, steal, I), state_at(U, owns, I, P), state_at(U, relation, P, loves).
% achieved: you can only steal items from other persons that are not dead and don't love you. (honor among thieves)

:- action_at(U, V, unlock, C), not state_at(U, owns, K, protagonist), key(K).
% achieved: you can only unlock chests if you own a key.

:- action_at(U, V, attack, P), not state_at(U, owns, W, protagonist), weapon(W).
% achieved: you can only attack persons if you own a weapon

:- action_at(U, V, kill, P), not state_at(U, owns, W, protagonist), weapon(W).
% achieved: you can only kill persons if you own a weapon

:- action_at(U, V, heal, P), not state_at(U, owns, H, protagonist), healing_item(H).
% achieved: you can only heal persons if you own a healing item


#show has_precondition/2.
#show precondition/3.
