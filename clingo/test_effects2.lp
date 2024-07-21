% The name 'effect' is chosen instead of 'postcondition' because not all of them must hold, but only one.
% All actions have effect, so unlike preconditions, haseffect is not needed


action_at(11, 9, steal, gold_coins).

state_at(11, owns, gold_coins, bard).
state_at(11, relation, bard, likes).
% state_at(11, relation, bard, dislikes).

state_at(11, health, protagonist, healthy).

possible_effect_at(V, steal, relation, Owner, dislikes) :- action_at(U, V, steal, I),
    state_at(U, owns, I, Owner),
    state_at(U, relation, Owner, S),
    S != hates, S != dislikes.
% possible effect of stealing: owner will dislike the protagonist

possible_effect_at(V, steal, relation, Owner, hates) :- action_at(U, V, steal, I),
    state_at(U, owns, I, Owner),
    state_at(U, relation, Owner, dislikes).
% possible effect of stealing: owner will hate the protagonist if he disliked already

possible_effect_at(V, steal, health, protagonist, injured) :- action_at(U, V, steal, _),
    state_at(U, health, protagonist, S),
    S != injured, S != dead.
% possible effect of stealing: protagonist will be injured

possible_effect_at(V, steal, health, protagonist, dead) :- action_at(U, V, steal, _),
    state_at(U, health, protagonist, S),
    S != dead.
% possible effect of stealing: protagonist will be killed

possible_effect_at(V, steal, owns, I, protagonist) :- action_at(U, V, steal, I).
% possible effect of stealing: protagonist becomes the new owner


{ effect_at(V, A, T, E, S) : possible_effect_at(V, A, T, E, S)  } = 1 :- action_at(U, V, A, _).


% instead of picking 1, you should be able to pick multiple ones, but ONLY possible ones
% so no effects that are inconsistent should occur
% and the number of effects should be minimized, but at least 1


#show possible_effect_at/5.
#show effect_at/5.

