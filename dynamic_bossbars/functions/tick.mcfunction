#---don't run if not active---
execute unless data storage dynamic_bossbars:config {active:1b} run return 0

#---update bossbars---
data modify storage dynamic_bossbars:entity_database temp.invalid_entries set from storage dynamic_bossbars:entity_database data.current
execute as @e[tag=dynamic_bossbars.attr.has_bossbar] run function dynamic_bossbars:entity/update_bossbars

#---remove bossbars with no entity---
execute if data storage dynamic_bossbars:entity_database temp.invalid_entries[0] run function dynamic_bossbars:storage/entity_database/remove_orphan_bossbars

#---clear temp---
data modify storage dynamic_bossbars:entity_database temp set value {}