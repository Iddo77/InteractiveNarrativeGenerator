% Define nuanced traits for persons
trait(wise; brave; cunning; loyal; ambitious; kind; ruthless; mysterious; empathetic; resourceful).
trait(adventurous; compassionate; determined; enigmatic; generous; humble; perceptive; resilient; skeptical; tactful).
trait(analytical; charismatic; diligent; inventive; intuitive; patient; pragmatic; quick_witted; tenacious; visionary).

% Define nuanced types for items
type(weapon; armor; potion; artifact; scroll; tool; food; gem; clothing; map).
type(relic; tome; trinket; amulet; charm; elixir; staff; orb; ring; key).
type(ingredient; talisman; book; crystal; shield; lantern; helm; boots; gauntlets; wand).

% Define general actions for any person
allowed_action_use(P, talk_to; attack; defend; help; travel; investigate; rest; hide; search; negotiate) :- person(P).
allowed_action_target(P, talk_to; attack; defend; help; travel_with; investigate; rest_with; hide_from; search_for; negotiate_with) :- person(P).

% Allowed actions for Set 1 traits
allowed_action_use(P, read; meditate; advise) :- person_trait(P, wise).
allowed_action_target(P, learn; consult; seek_advice) :- person_trait(P, wise).

allowed_action_use(P, fight; protect; inspire) :- person_trait(P, brave).
allowed_action_target(P, lead; defend; challenge) :- person_trait(P, brave).

allowed_action_use(P, plan; deceive; manipulate) :- person_trait(P, cunning).
allowed_action_target(P, trick; outwit; spy_on) :- person_trait(P, cunning).

allowed_action_use(P, help; follow; trust) :- person_trait(P, loyal).
allowed_action_target(P, support; accompany; depend_on) :- person_trait(P, loyal).

allowed_action_use(P, plan; strive; compete) :- person_trait(P, ambitious).
allowed_action_target(P, rival; challenge; collaborate) :- person_trait(P, ambitious).

allowed_action_use(P, comfort; heal; support) :- person_trait(P, kind).
allowed_action_target(P, help; care_for; console) :- person_trait(P, kind).

allowed_action_use(P, intimidate; conquer; dominate) :- person_trait(P, ruthless).
allowed_action_target(P, subdue; control; confront) :- person_trait(P, ruthless).

allowed_action_use(P, investigate; explore; observe) :- person_trait(P, mysterious).
allowed_action_target(P, learn_about; question; follow) :- person_trait(P, mysterious).

allowed_action_use(P, sympathize; understand; counsel) :- person_trait(P, empathetic).
allowed_action_target(P, comfort; aid; listen_to) :- person_trait(P, empathetic).

allowed_action_use(P, improvise; adapt; create) :- person_trait(P, resourceful).
allowed_action_target(P, fix; utilize; innovate) :- person_trait(P, resourceful).

% Allowed actions for Set 2 traits
allowed_action_use(P, explore; travel; discover) :- person_trait(P, adventurous).
allowed_action_target(P, venture; embark; encounter) :- person_trait(P, adventurous).

allowed_action_use(P, help; heal; nurture) :- person_trait(P, compassionate).
allowed_action_target(P, care_for; support; protect) :- person_trait(P, compassionate).

allowed_action_use(P, persist; strive; achieve) :- person_trait(P, determined).
allowed_action_target(P, overcome; confront; endure) :- person_trait(P, determined).

allowed_action_use(P, investigate; observe; question) :- person_trait(P, enigmatic).
allowed_action_target(P, explore; understand; follow) :- person_trait(P, enigmatic).

allowed_action_use(P, give; share; assist) :- person_trait(P, generous).
allowed_action_target(P, help; support; donate_to) :- person_trait(P, generous).

allowed_action_use(P, defer; serve; acknowledge) :- person_trait(P, humble).
allowed_action_target(P, honor; respect; follow) :- person_trait(P, humble).

allowed_action_use(P, notice; deduce; analyze) :- person_trait(P, perceptive).
allowed_action_target(P, interpret; understand; observe) :- person_trait(P, perceptive).

allowed_action_use(P, recover; endure; persist) :- person_trait(P, resilient).
allowed_action_target(P, withstand; survive; adapt) :- person_trait(P, resilient).

allowed_action_use(P, question; doubt; investigate) :- person_trait(P, skeptical).
allowed_action_target(P, challenge; scrutinize; test) :- person_trait(P, skeptical).

allowed_action_use(P, negotiate; mediate; soothe) :- person_trait(P, tactful).
allowed_action_target(P, appease; resolve; communicate) :- person_trait(P, tactful).

% Allowed actions for Set 3 traits
allowed_action_use(P, analyze; calculate; research) :- person_trait(P, analytical).
allowed_action_target(P, study; understand; investigate) :- person_trait(P, analytical).

allowed_action_use(P, influence; lead; charm) :- person_trait(P, charismatic).
allowed_action_target(P, inspire; persuade; gather) :- person_trait(P, charismatic).

allowed_action_use(P, work_hard; persevere; focus) :- person_trait(P, diligent).
allowed_action_target(P, complete; achieve; contribute_to) :- person_trait(P, diligent).

allowed_action_use(P, create; innovate; design) :- person_trait(P, inventive).
allowed_action_target(P, develop; construct; build) :- person_trait(P, inventive).

allowed_action_use(P, sense; predict; empathize) :- person_trait(P, intuitive).
allowed_action_target(P, trust; follow; understand) :- person_trait(P, intuitive).

allowed_action_use(P, wait; endure; tolerate) :- person_trait(P, patient).
allowed_action_target(P, withstand; support; nurture) :- person_trait(P, patient).

allowed_action_use(P, solve; decide; implement) :- person_trait(P, pragmatic).
allowed_action_target(P, manage; execute; improve) :- person_trait(P, pragmatic).

allowed_action_use(P, joke; react; respond) :- person_trait(P, quick_witted).
allowed_action_target(P, entertain; outsmart; impress) :- person_trait(P, quick_witted).

allowed_action_use(P, persist; push; confront) :- person_trait(P, tenacious).
allowed_action_target(P, overcome; achieve; tackle) :- person_trait(P, tenacious).

allowed_action_use(P, envision; plan; foresee) :- person_trait(P, visionary).
allowed_action_target(P, inspire; lead; create) :- person_trait(P, visionary).

% Allowed actions for Set 1 types
allowed_action_use(I, attack; defend; strike) :- item_type(I, weapon).
allowed_action_target(I, equip; wield; enhance) :- item_type(I, weapon).

allowed_action_use(I, protect; equip; block) :- item_type(I, armor).
allowed_action_target(I, wear; reinforce; upgrade) :- item_type(I, armor).

allowed_action_use(I, drink; heal; brew) :- item_type(I, potion).
allowed_action_target(I, consume; store; find) :- item_type(I, potion).

allowed_action_use(I, study; activate; safeguard) :- item_type(I, artifact).
allowed_action_target(I, research; protect; unlock) :- item_type(I, artifact).

allowed_action_use(I, read; cast_spell; decipher) :- item_type(I, scroll).
allowed_action_target(I, translate; study; store) :- item_type(I, scroll).

allowed_action_use(I, repair; craft; use) :- item_type(I, tool).
allowed_action_target(I, fix; build; maintain) :- item_type(I, tool).

allowed_action_use(I, eat; cook; gather) :- item_type(I, food).
allowed_action_target(I, consume; share; prepare) :- item_type(I, food).

allowed_action_use(I, appraise; trade; find) :- item_type(I, gem).
allowed_action_target(I, value; store; collect) :- item_type(I, gem).

allowed_action_use(I, wear; mend; tailor) :- item_type(I, clothing).
allowed_action_target(I, wash; fold; store) :- item_type(I, clothing).

allowed_action_use(I, navigate; explore; mark) :- item_type(I, map).
allowed_action_target(I, read; follow; hide) :- item_type(I, map).

% Allowed actions for Set 2 types
allowed_action_use(I, study; activate; display) :- item_type(I, relic).
allowed_action_target(I, protect; analyze; find) :- item_type(I, relic).

allowed_action_use(I, read; study; learn) :- item_type(I, tome).
allowed_action_target(I, understand; interpret; translate) :- item_type(I, tome).

allowed_action_use(I, collect; trade; examine) :- item_type(I, trinket).
allowed_action_target(I, value; gift; store) :- item_type(I, trinket).

allowed_action_use(I, wear; enchant; protect) :- item_type(I, amulet).
allowed_action_target(I, equip; safeguard; empower) :- item_type(I, amulet).

allowed_action_use(I, carry; enchant; ward) :- item_type(I, charm).
allowed_action_target(I, give; use; store) :- item_type(I, charm).

allowed_action_use(I, drink; heal; mix) :- item_type(I, elixir).
allowed_action_target(I, brew; consume; store) :- item_type(I, elixir).

allowed_action_use(I, cast_spell; channel; attack) :- item_type(I, staff).
allowed_action_target(I, wield; enhance; focus) :- item_type(I, staff).

allowed_action_use(I, see; predict; scry) :- item_type(I, orb).
allowed_action_target(I, gaze; focus; store) :- item_type(I, orb).

allowed_action_use(I, wear; bind; cast_spell) :- item_type(I, ring).
allowed_action_target(I, enchant; give; store) :- item_type(I, ring).

allowed_action_use(I, unlock; open; hide) :- item_type(I, key).
allowed_action_target(I, find; carry; use) :- item_type(I, key).

% Allowed actions for Set 3 types
allowed_action_use(I, mix; prepare; gather) :- item_type(I, ingredient).
allowed_action_target(I, store; use; collect) :- item_type(I, ingredient).

allowed_action_use(I, carry; protect; empower) :- item_type(I, talisman).
allowed_action_target(I, wear; enchant; safeguard) :- item_type(I, talisman).

allowed_action_use(I, read; learn; study) :- item_type(I, book).
allowed_action_target(I, interpret; translate; write) :- item_type(I, book).

allowed_action_use(I, focus; channel; enhance) :- item_type(I, crystal).
allowed_action_target(I, appraise; collect; store) :- item_type(I, crystal).

allowed_action_use(I, block; protect; equip) :- item_type(I, shield).
allowed_action_target(I, carry; upgrade; reinforce) :- item_type(I, shield).

allowed_action_use(I, light; explore; find) :- item_type(I, lantern).
allowed_action_target(I, carry; hang; store) :- item_type(I, lantern).

allowed_action_use(I, wear; protect; reinforce) :- item_type(I, helm).
allowed_action_target(I, carry; upgrade; equip) :- item_type(I, helm).

allowed_action_use(I, wear; walk; run) :- item_type(I, boots).
allowed_action_target(I, carry; equip; mend) :- item_type(I, boots).

allowed_action_use(I, punch; protect; reinforce) :- item_type(I, gauntlets).
allowed_action_target(I, equip; upgrade; carry) :- item_type(I, gauntlets).

allowed_action_use(I, cast_spell; focus; channel) :- item_type(I, wand).
allowed_action_target(I, wield; enchant; store) :- item_type(I, wand).
