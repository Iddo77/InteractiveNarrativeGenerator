% material success
state_at(end(1), health, protagonist, healthy).
start_state(end(1), health, thief, dead).
state_at(end(1), owns, book_of_secrets, protagonist).
state_at(end(1), owns, ancient_amulet, protagonist).

% relational success
state_at(end(2), health, protagonist, healthy).
state_at(end(2), relation, bard, loves).
state_at(end(2), relation, fighter, loves).
state_at(end(2), relation, mage, likes).

% mixed results
state_at(end(3), health, protagonist, injured).
start_state(end(3), health, thief, injured).
state_at(end(3), relation, bard, loves).
state_at(end(3), owns, ancient_amulet, protagonist).

% multiple dead
state_at(end(4), health, protagonist, dead).
start_state(end(4), health, thief, dead).
start_state(end(4), health, mage, dead).
start_state(end(4), owns, rusty_sword, protagonist).

% greed kills
state_at(end(5), health, protagonist, dead).
start_state(end(5), health, thief, healthy).
state_at(end(5), relation, mage, hates).
state_at(end(5), owns, old_map, protagonist).
