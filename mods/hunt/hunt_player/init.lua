dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/inventory.lua")

minetest.register_on_joinplayer(function(player, last_login)
    local name = player:get_player_name()
    minetest.after(0.01, function() player:set_pos(hunt_core.lobby_spawnpoint) end)

    if last_login == nil or hunt_core.players_loadout[name].primary == nil then
        hunt_core.players_loadout[name] = hunt_core.default_loadout
    end
end)

minetest.register_on_respawnplayer(function(player)
    minetest.after(0.01, function() player:set_pos(hunt_core.lobby_spawnpoint) end)
end)

minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
    if hunt_teams.get(hitter:get_player_name()) == hunt_teams.get(player:get_player_name()) then
        return false
    end
end)