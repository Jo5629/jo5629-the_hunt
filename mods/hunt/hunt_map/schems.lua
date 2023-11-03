--> Place lobby and other mandatory schematics for the world (other than maps).

local schems_modpath = minetest.get_modpath(minetest.get_current_modname()) .. "/schems"
local storage = minetest.get_mod_storage()

minetest.register_on_newplayer(function(player)
        if storage:get_string("hunt_map.placed_lobby") ~= true then

                local value
                local file, err = io.open(schems_modpath .."/lobby.we", "rb")

                if file then
                        value = file:read("*a")
                        file:close()

                        worldedit.deserialize({x = 0, y = 0, z = 0}, value)

                        minetest.log("action", "Lobby schematic placed.")
                        storage:set_string("hunt_map.placed_lobby", true)

                        minetest.after(1, function() player:set_pos(hunt_core.lobby_spawnpoint) end)
                end
        end
end)