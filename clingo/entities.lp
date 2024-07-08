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

#show entity/1.
