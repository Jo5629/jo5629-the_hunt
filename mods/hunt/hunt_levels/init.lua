hunt_levels = {}

local modpath = minetest.get_modpath(minetest.get_current_modname())
local storage = minetest.get_mod_storage()
local tmp = {}

if storage:get_string("hunt_levels.player_levels") ~= nil then
    tmp = minetest.deserialize(storage:get_string("hunt_levels.player_levels")) or {}
end

function hunt_levels.save_players()
    storage:set_string("hunt_levels.player_levels", minetest.serialize(tmp))
end

function hunt_levels.get_players()
    return tmp
end

function hunt_levels.save_player_level(pname, level, xp, xp_max)
    tmp[pname] = {
        level = level,
        xp = xp,
        xp_max = xp_max,
    }

    hunt_levels.save_players()
end

function hunt_levels.get_player_level(pname)
    return tmp[pname]
end

function hunt_levels.get_xp_for_level(level)
    local baseCost = 1000
    local xp_needed = math.ceil(level * baseCost * 1.4)

    return xp_needed
end

function hunt_levels.get_xp_needed(pname)
    local xp_table = hunt_levels.get_player_level(pname)

    local level = xp_table.level + 1
    local xp_needed = hunt_levels.get_xp_for_level(level)

    return xp_needed
end

function hunt_levels.calculate_level_from_xp(num)
    local level = 0
    local xp_needed = 0
    repeat
        level = level + 1

        xp_needed = hunt_levels.get_xp_for_level(level)

        if xp_needed >= num then
            break
        end
    until false

    return level, xp_needed
end

function hunt_levels.set_xp(pname, num)
    local num = math.ceil(num)

    local xp_table = hunt_levels.get_player_level(pname)

    if not xp_table then
        return
    end

    local level, xp_needed = hunt_levels.calculate_level_from_xp(num)

    hunt_levels.save_player_level(pname, level - 1, num, xp_needed)
end

function hunt_levels.add_xp(pname, num)
    local num = math.ceil(num)

    local xp_table = hunt_levels.get_player_level(pname)

    if not xp_table then
        return
    end

    hunt_levels.set_xp(pname, xp_table.xp + num)
end

minetest.register_privilege("levels_admin", {
    description = "Gives the ability to do advanced /levels command.",
    give_to_singleplayer = false
})

dofile(modpath .. "/levels_command.lua")

minetest.register_on_joinplayer(function(player, last_login)
    local pname = player:get_player_name()

    if last_login == nil or not hunt_levels.get_player_level(pname) then
        hunt_levels.save_player_level(pname, 0, 0, 0)
    end
end)

hunt_api.register_on_save_data(function()
    hunt_levels.save_players()
end)