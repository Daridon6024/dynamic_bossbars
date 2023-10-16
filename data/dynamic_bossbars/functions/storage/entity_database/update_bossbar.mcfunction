# KEYS: input -> string
$execute store result bossbar dynamic_bossbars:$(UUID_string) value run data get entity @s Health
$execute store result bossbar dynamic_bossbars:$(UUID_string) max run attribute @s generic.max_health get

$execute if score @s dynamic_bossbars.color_int matches 0 run bossbar set dynamic_bossbars:$(UUID_string) color white
$execute if score @s dynamic_bossbars.color_int matches 1 run bossbar set dynamic_bossbars:$(UUID_string) color pink
$execute if score @s dynamic_bossbars.color_int matches 2 run bossbar set dynamic_bossbars:$(UUID_string) color red
$execute if score @s dynamic_bossbars.color_int matches 3 run bossbar set dynamic_bossbars:$(UUID_string) color yellow
$execute if score @s dynamic_bossbars.color_int matches 4 run bossbar set dynamic_bossbars:$(UUID_string) color green
$execute if score @s dynamic_bossbars.color_int matches 5 run bossbar set dynamic_bossbars:$(UUID_string) color blue
$execute if score @s dynamic_bossbars.color_int matches 6 run bossbar set dynamic_bossbars:$(UUID_string) color purple

$execute if score @s dynamic_bossbars.style_int matches 0 run bossbar set dynamic_bossbars:$(UUID_string) style progress
$execute if score @s dynamic_bossbars.style_int matches 1 run bossbar set dynamic_bossbars:$(UUID_string) style notched_6
$execute if score @s dynamic_bossbars.style_int matches 2 run bossbar set dynamic_bossbars:$(UUID_string) style notched_10
$execute if score @s dynamic_bossbars.style_int matches 3 run bossbar set dynamic_bossbars:$(UUID_string) style notched_12
$execute if score @s dynamic_bossbars.style_int matches 4 run bossbar set dynamic_bossbars:$(UUID_string) style notched_20