% TALK TO

possible_effect_at(V, talk_to, relation, P, likes) :- action_at(U, V, talk_to, P),
     state_at(U, relation, P, S),
     P != protagonist,
     S != likes, S != hates.
possible_effect_at(V, talk_to, relation, P, dislikes) :- action_at(U, V, talk_to, P),
     state_at(U, relation, P, S),
     P != protagonist,
     S != dislikes, S != loves.
% possible effect of talk to: relationship can change

causal_effect(talk_to, relation, likes).
causal_effect(talk_to, relation, dislikes).

% ADMIRE

possible_effect_at(V, admire, relation, P, neutral) :- action_at(U, V, admire, P),
    state_at(U, relation, P, dislikes), P != protagonist.
possible_effect_at(V, admire, relation, P, likes) :- action_at(U, V, admire, P),
    state_at(U, relation, P, neutral), P != protagonist.
possible_effect_at(V, admire, relation, P, loves) :- action_at(U, V, admire, P),
    state_at(U, relation, P, likes), P != protagonist.
% possible effect of admire: the relation with the person improves

causal_effect(admire, relation, neutral).
causal_effect(admire, relation, likes).
causal_effect(admire, relation, loves).

% INTIMIDATE

possible_effect_at(V, intimidate, relation, P, hates) :- action_at(U, V, intimidate, P),
    state_at(U, relation, P, dislikes), P != protagonist.
possible_effect_at(V, intimidate, relation, P, dislikes) :- action_at(U, V, intimidate, P),
    state_at(U, relation, P, neutral), P != protagonist.
possible_effect_at(V, intimidate, relation, P, neutral) :- action_at(U, V, intimidate, P),
    state_at(U, relation, P, likes), P != protagonist.
possible_effect_at(V, intimidate, relation, P, likes) :- action_at(U, V, intimidate, P),
    state_at(U, relation, P, loves), P != protagonist.
% possible effect of intimidate: the relation with the person deteriorates

causal_effect(intimidate, relation, neutral).
causal_effect(intimidate, relation, dislikes).
causal_effect(intimidate, relation, hates).

% HEAL

possible_effect_at(V, heal, health, P, healthy) :- action_at(U, V, heal, P).
% possible effect of heal: the person is healed

possible_effect_at(V, heal, relation, P, neutral) :- action_at(U, V, heal, P),
    state_at(U, relation, P, dislikes), P != protagonist.
possible_effect_at(V, heal, relation, P, likes) :- action_at(U, V, heal, P),
    state_at(U, relation, P, neutral), P != protagonist.
possible_effect_at(V, heal, relation, P, loves) :- action_at(U, V, heal, P),
    state_at(U, relation, P, likes), P != protagonist.
% possible effect of heal: the relation with the injured person is improved

causal_effect(heal, health, healthy).
causal_effect(heal, relation, neutral).
causal_effect(heal, relation, likes).
causal_effect(heal, relation, loves).

% BREAK

possible_effect_at(V, break, condition, I, broken) :- action_at(U, V, break, I),
    state_at(U, condition, I, intact), not money(I).
% possible effect of break: the item is broken

possible_effect_at(V, break, condition, I, destroyed) :- action_at(U, V, break, I),
    state_at(U, condition, I, broken), not money(I).
% possible effect of break: the item is broken

possible_effect_at(V, break, relation, Owner, dislikes) :- action_at(U, V, break, I),
    state_at(U, owns, I, Owner), Owner != protagonist,
    state_at(U, relation, Owner, S), S != dislikes, S != hates.
possible_effect_at(V, break, relation, Owner, hates) :- action_at(U, V, break, I),
    state_at(U, owns, I, Owner), Owner != protagonist,
    state_at(U, relation, Owner, dislikes).
% possible effect of break: the relation with the owner deteriorates

causal_effect(break, condition, broken).
causal_effect(break, condition, destroyed).
causal_effect(break, dislikes).
causal_effect(break, hates).

% REPAIR

possible_effect_at(V, repair, condition, I, intact) :- action_at(U, V, repair, I),
    state_at(U, condition, I, broken).
% possible effect of repair: the item is repaired

causal_effect(repair, condition, intact).

% TAKE

possible_effect_at(V, take, owns, I, protagonist) :- action_at(U, V, take, I),
    state_at(U, owns, I, P), P != protagonist.
% possible effect of request: protagonist gets the item

causal_effect(take, owns, protagonist).

% REQUEST

possible_effect_at(V, request, owns, I, protagonist) :- action_at(U, V, request, I),
    state_at(U, owns, I, P), P != protagonist.
% possible effect of request: protagonist gets the item

possible_effect_at(V, request, relation, P, likes) :- action_at(U, V, request, I),
    state_at(U, relation, P, loves).
% possible effect of request: relation with owner deteriorates

causal_effect(request, owns, protagonist).
causal_effect(request, relation, likes).

% BUY

possible_effect_at(V, buy, owns, I, protagonist) :- action_at(U, V, buy, I).
% possible effect of buy: protagonist become the owner

% buy is only partly modeled: the protagonist keeps the money.

% possible_effect_at(V, buy, owns, M, Owner) :- action_at(U, V, buy, I),
%    state_at(U, owns, I, Owner),
%    state_at(U, owns, M, protagonist), money(M),
%    state_at(U, relation, Owner, S).
% possible effect of buy: money will go to the owner

causal_effect(buy, owns, protagonist).

% STEAL

possible_effect_at(V, steal, relation, Owner, dislikes) :- action_at(U, V, steal, I),
    state_at(U, owns, I, Owner),
    state_at(U, relation, Owner, S),
    S != hates, S != dislikes.
% possible effect of steal: owner will dislike the protagonist

possible_effect_at(V, steal, relation, Owner, hates) :- action_at(U, V, steal, I),
    state_at(U, owns, I, Owner),
    state_at(U, relation, Owner, dislikes).
% possible effect of steal: owner will hate the protagonist if he disliked already

possible_effect_at(V, steal, health, protagonist, injured) :- action_at(U, V, steal, _),
    state_at(U, health, protagonist, S),
    S != injured.
% possible effect of steal: protagonist will be injured

possible_effect_at(V, steal, health, protagonist, dead) :- action_at(U, V, steal, I),
    state_at(U, owns, I, Owner),
    state_at(U, relation, Owner, hates).
% possible effect of steal: protagonist will be killed if tries to steal from a hater

possible_effect_at(V, steal, owns, I, protagonist) :- action_at(U, V, steal, I).
% possible effect of steal: protagonist becomes the new owner

causal_effect(steal, relation, dislikes).
causal_effect(steal, relation, hates).
causal_effect(steal, health, injured).
causal_effect(steal, health, dead).
causal_effect(steal, owns, protagonist).

% UNLOCK

possible_effect_at(V, unlock, condition, K, destroyed) :- action_at(U, V, unlock, C),
    state_at(U, owns, K, protagonist), key(K),
    state_at(U, condition, K, broken).
% possible effect of unlock: the key is destroyed if it was broken

possible_effect_at(V, unlock, condition, K, broken) :- action_at(U, V, unlock, C),
    state_at(U, owns, K, protagonist), key(K),
    state_at(U, condition, K, intact).
% possible effect of unlock: the key breaks

possible_effect_at(V, unlock, lock, C, unlocked) :- action_at(U, V, unlock, C).
% possible effect of unlock: the chest becomes unlocked

causal_effect(unlock, condition, broken).
causal_effect(unlock, condition, destroyed).
causal_effect(unlock, lock, unlocked).

% ATTACK

possible_effect_at(V, attack, relation, P, hates) :- action_at(U, V, attack, P),
    state_at(U, relation, P, S), S != hates.
% possible effect of attack: victim hates the protagonist

possible_effect_at(V, attack, health, P, dead) :- action_at(U, V, attack, P),
    state_at(U, health, P, injured).
possible_effect_at(V, attack, health, P, injured) :- action_at(U, V, attack, P),
    state_at(U, health, P, healthy).
% possible effect of attack: victim is injured or dead

possible_effect_at(V, attack, health, protagonist, dead) :- action_at(U, V, attack, P),
    state_at(U, health, protagonist, injured).
possible_effect_at(V, attack, health, protagonist, injured) :- action_at(U, V, attack, P),
    state_at(U, health, protagonist, healthy).
% possible effect of attack: protagonist is injured or dead

causal_effect(attack, relation, hates).
causal_effect(attack, health, injured).
causal_effect(attack, health, dead).

side_effect(U, V, T, S1, S2) :- action_at(U, V, A, _),
    state_at(U, T, E, S1), state_at(V, T, E, S2), S1 != S2,
    not causal_effect(A, T, S2).
% achieved: side effects are effects that are not causal, so they cannot be explained by the action taken

:- side_effect(U, V, health, S1, S2).
% achieved: side effects relating to health changes are not allowed

:- side_effect(U, V, owns, protagonist, S2).
:- side_effect(U, V, owns, S1, protagonist).
% achieved: side effects relating to ownership by the protagonist are not allowed

:- side_effect(U, V, condition, broken, intact).
% achieved: items don't get fixed without an action

:- side_effect(U, V, relation, loves, S2).
:- side_effect(U, V, relation, S1, loves).
:- side_effect(U, V, relation, hates, S2).
:- side_effect(U, V, relation, S1, hates).
