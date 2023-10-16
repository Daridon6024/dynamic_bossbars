#define storage dynamic_bossbars:config
#define storage dynamic_bossbars:entity_database
#define storage dynamic_bossbars:bossbar_id

#---don't run if not active---
execute if data storage dynamic_bossbars:config {active:0b} run return 0

#---default storage---
execute unless data storage dynamic_bossbars:bossbar_id input run data merge storage dynamic_bossbars:bossbar_id {input:{create_bossbar_id:{UUID0:0,UUID1:0,UUID2:0,UUID3:0,identifier:"name"}}}
execute unless data storage dynamic_bossbars:bossbar_id output run data merge storage dynamic_bossbars:bossbar_id {output:{create_bossbar_id:{bossbar_id:"0.0.0.0.name"}}}

execute unless data storage dynamic_bossbars:config active run data merge storage dynamic_bossbars:config {active:1b}

execute unless data storage dynamic_bossbars:entity_database data run data merge storage dynamic_bossbars:entity_database {data:{current:[]}}
execute unless data storage dynamic_bossbars:entity_database input run data merge storage dynamic_bossbars:entity_database {input:{create_new_entry:{entity_UUID:[I;0,0,0,0],identifier:"name",color:"white",style:"progress",value_setter:"data get entity @s Health",max_setter:"attribute @s generic.max_health get",player_setter:"execute as @a[distance=..64] run",name_setter:'{"selector":"@s"}'},create_bossbar:{bossbar_id:"0.0.0.0.name",color:"white",style:"progress",name_setter:'{"selector":"@s"}'},get_entries_by_UUID:{UUID:[I;0,0,0,0],update_single_bossbar:{bossbar_id:"0.0.0.0.name",value_setter:"data get entity @s Health",max_setter:"attribute @s generic.max_health get",player_setter:"execute as @a[distance=..64] run",name_setter:'{"selector":"@s"}'},remove_single_bossbar:{bossbar_id:"0.0.0.0.name"}}}}
execute unless data storage dynamic_bossbars:entity_database output run data merge storage dynamic_bossbars:entity_database {output:{get_entries_by_UUID:{entries:[]}}}
execute unless data storage dynamic_bossbars:entity_database temp run data merge storage dynamic_bossbars:entity_database {temp:{}}