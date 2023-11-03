hunt_core.lobby_spawnpoint = {x = 10, y = 1, z = 10}

hunt_lobbies = {}
hunt_lobbies.main_lobby = {}

minetest.register_chatcommand("lobby", {
    description = "Returns you to the lobby.",
    func = function(name, param)
            local player = minetest.get_player_by_name(name)
            player:set_pos(hunt_core.lobby_spawnpoint)
    end,
})

local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(modpath .. "/nodes.lua")