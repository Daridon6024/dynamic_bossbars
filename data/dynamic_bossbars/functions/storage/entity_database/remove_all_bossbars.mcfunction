data modify storage dynamic_bossbars:entity_database temp.invalid_entries set from storage dynamic_bossbars:entity_database data.current
execute if data storage dynamic_bossbars:entity_database temp.invalid_entries[0] run function dynamic_bossbars:storage/entity_database/remove_orphan_bossbars