% persons, items and chests are defined
person(protagonist; fighter; thief; bard; mage).
chest(old_chest).
weapon(staff; dagger; rusty_sword;).
precious_item(book_of_secrets; old_map; ancient_amulet).
key(rusty_key).
healing_item(magic_potion).
money(gold_coins).
tool(lockpick).

item(X) :- weapon(X).
item(X) :- precious_item(X).
item(X) :- key(X).
item(X) :- healing_item(X).
item(X) :- money(X).
item(X) :- tool(X).

entity(X) :- person(X).
entity(X) :- item(X).
entity(X) :- chest(X).

#show entity/1.
