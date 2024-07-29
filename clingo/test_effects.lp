% The name 'effect' is chose instead of 'postcondition' because not all of them must hold, but only one.
% All actions have effect, so unlike preconditions, haseffect is not needed

action_at(11, 9, unlock, old_chest).

state_at(11, condition, lockpick, intact).
state_at(11, lock, old_chest, unlocked).

effect(unlock, condition, lockpick, broken; destroyed).
effect(unlock, lock, old_chest, unlocked).

{ effect_at(V, A, T, E, S) : effect(A, T, E, S)  } = 1 :- action_at(U, V, A, _).
% entity affected could be different than anticipicated: not at which the action is aimed

#show effect_at/5.
