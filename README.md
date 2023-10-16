# Dynamic Bossbars for Minecraft
## What is This?
Dynamic Bossbars is a namespace that allows you to create bossbars whose instance is dependent on an entity's instead of being dependent to the world. When the entity is killed or unloads, then the bossbar is automatically removed.

Additionally, it is possible to have multiple instances of the same type of bossbar on different entities, meaning that you no longer need to share a single bossbar between multiple entities, similar to how the bossbars in vanilla minecraft work (this was the main issue this project targets).

Bossbars are primarily used to track the health of an entity, but you can actually track any arbitrary data, such as position, fall distance, scoreboard values, warden anger, a nearby entity's data/storage data, function with custom return values, etc.

## How to Use
### Adding to your datapack
Dynamic Bossbars is designed to be run in a traditional survival world, but it should work for custom minigames as well.

If you wish to use Dynamic Bossbars, you can incorperate this namespace directly into your datapack with no other dependencies. Just make sure to add the load and tick functions to the `#load` and `#tick` function tags.

Ideally, the tick function should run **\*after\*** the other tick functions in order to get the most recent data/scoreboard values from the other namespaces.

### Adding bossbars
The main function that you will be using is the `add_bossbar` function (`dynamic_bossbars:entity/add_bossbar.mcfunction`). When run as an entity, this function will attach a bossbar with the given parameters to the entity executing this function. Here is what you will need to specify for the parameters of this function:

* identifier -> string: A string that is appended to the entity's UUID to create the bossbar's unique id. `"health"` and `"fall_distance"` are good examples of identifiers. Trying to add a second bossbar with the same identifier on the same entity will neither overwrite the existing bossbar nor add a new one, similar to attribute modifiers.
* color -> string: Color of bossbar. Use an existing options provided by Minecraft in the `bossbar add` command (e.g. `"white"`, `"red"`, etc.)
* style -> string: Style of bossbar. Use an existing options provided by Minecraft in the `bossbar add` command (e.g. `"progress"`, `"notched_20"`, etc.)
* value_setter -> command: A command whose result will be used to set the value of the bossbar. This command will be run every tick. Executed as and at the entity this bossbar belongs to. Pass in as a string. Example: `"data get entity @s Health"`
* max_setter -> command: A command whose result will be used to set the max value of the bossbar. This command will be run every tick. Executed as and at the entity this bossbar belongs to. Pass in as a string. Example: `"attribute @s generic.max_health get"`
* player_setter -> command (`execute as ... run`): An execute command that selects the players who will be displayed the bossbar. Executed as and at the entity this bossbar belongs to. It is possible to check for conditions on the entity before checking for players. Pass in as a string. Examples: `"execute as @a[distance=..32] run"` or `"execute if score @s boss_phase matches 1.. as @a[distance=..80] run"`
* name_setter -> JSON text: The JSON text component that will determine the bossbar's display name. This text is parsed in the "bossbar add" command context. Example: `'{"selector":"@s"}'`

Example of command you would use in your datapack:

`execute as @e[type=pig] run function dynamic_bossbars:entity/add_bossbar {identifier:"health",color:"red",style:"progress",value_setter:"data get entity @s Health",max_setter:"attribute @s generic.max_health get",player_setter:"execute as @a[distance=..32] run",name_setter:'{"selector":"@s"}'}`

#### Things to Remember When Adding Bossbars

When creating the setters, **DO NOT USE THE RETURN COMMAND FOR CONSTANT VALUES**. Instead, either create a constant in command storage and then use the `data get` command to retrieve it or use a scoreboard value.

* NOT OKAY: `return 4`
* GOOD: `scoreboard players get @s <objective>`
* ALSO GOOD: `data get storage <namespace_id> constants.<value>`

Additionally, do not use the `return run` command for dynamic values. Just use the command directly. If you want a custom setter function, you will need to use the `return` command inside the specified function's file.

* NOT OKAY: `return run function <function_name>`
* GOOD: `function <function_name>`

You are expected to run the `add_bossbar` function every tick on the relevent entities, and not just as a one time command. The reason for this is because the bossbars will not persist if the entity is unloaded. The function is designed to not overwrite any existing bossbars and to not be as taxing if the bossbar already exists, so you should be fine running it every tick.

### Other functions
Here are the other functions you may use if nessesary for debugging:

* entity/remove_own_bossbars: Removes the bossbars of a single entity at the end of the tick.
* storage/entity_database/remove_all_bossbars.mcfunction: Removes all current bossbars. Useful for resetting bossbars if you incorrectly set the parameters of a bossbar.
* activate.mcfunction: Resumes execution of the tick and load functions.
* deactivate.mcfunction: Pauses execution of the tick and load functions.
* unload.mcfunction: Removes all data and bossbars from your world. Reload after this function if you want to reset the database, or remove the namespace from your datapack after running this function if you want to uninstall it.

## Limitations
Of course, this is not a perfect system. Here are a few of the limitations you may encounter:

* Requires function macros to run (Minecraft 1.20.2 and above).
* Unloading the data does not remove the tags of currenly unloaded entities that had prevously been given a bossbar. This is relavively insignificant. The only consequence of this is if you uninstall and then reinstall the namespace, there may be a slight performance hit around previously tagged entities that have no current bossbars. However, if reinstalled, and the same entities have bossbars, there will be no issue.
* It is not implemented to have bossbars that exist in a many-to-many relationship among entities. For example, it is possible for bossbars to display a Warden's highest anger value to all players and it is possible for all players to see the highest anger any Warden has on them. However, it is not possible for every player to see every individual Warden's anger on them. It is technically possible, but quite cumbersome and much more inefficient. To implement this, entities would need to remember the specific other entities required to calculate the bossbar, but this is only possible though command storage. Using command storage for this purpose would either be incredibly fragile or result in rapidly growing databases, which are both not preferable. If entities could hold custom NBT data, then implementing this would be trivial, but a database wouldn't be required in the first place if that was the case. Besides, in most cases, if an entity is just using one other entity for its calculations, it is possible to simply tag that other entity and calculate from there.
