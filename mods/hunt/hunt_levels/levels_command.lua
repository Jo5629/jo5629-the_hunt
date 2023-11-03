local cmd = chatcmdbuilder.register("levels", {
    description = "Do /levels help to get started.",
    privs = {
        interact = true,
    }
})

cmd:sub("help", function(name)
    local help_table = {
        "/levels help - Brings you back to this info board.",
        "/levels - Get your own level, XP, XP_MAX",
        "/levels get <player> - Gets a player's Level, XP, XP_MAX",
        "/levels set_level <player> <num> - Sets a player's level to this number",
        "/levels set_xp <player> <num> - Sets a player's XP to this number",
        "/levels add_xp <player> <num> - Changes a player's XP by that number",
    }

    minetest.chat_send_player(name, minetest.colorize("#29d10f", table.concat(help_table, "\n")))
end)

cmd:sub("get :target", function(name, target)
    local xp_table = hunt_levels.get_player_level(target)
    if not xp_table then
        minetest.chat_send_player(name, minetest.colorize("#ff0000", "Player not found."))
        return
    end

    minetest.chat_send_player(name, minetest.colorize("#29d10f", "Stats for: " .. target))
    minetest.chat_send_player(name, "Level: " .. xp_table.level)
    minetest.chat_send_player(name, "XP: " .. xp_table.xp)
    minetest.chat_send_player(name, "XP MAX: " .. xp_table.xp_max)
end)

cmd:sub("", function(name)
    local xp_table = hunt_levels.get_player_level(name)
    minetest.chat_send_player(name, "Level: " .. xp_table.level)
    minetest.chat_send_player(name, "XP: " .. xp_table.xp)
    minetest.chat_send_player(name, "XP MAX: " .. xp_table.xp_max)
end)



cmd:sub("set_level :target :num",  {
    privs = {
        server = true,
        levels_admin = true,
    },

    func = function(name, target, num)
        local num = math.abs(num)

        local xp_table = hunt_levels.get_player_level(target)
        if not xp_table then
            minetest.chat_send_player(name, minetest.colorize("#ff0000", "Player not found."))
            return
        end

        local xp = hunt_levels.get_xp_for_level(num)
        hunt_levels.save_player_level(target, num, xp, xp)

        minetest.chat_send_player(name, minetest.colorize("#29d10f", "Set level of " .. target .. " to: " .. num))
    end,
})

cmd:sub("set_xp :target :num",  {
    privs = {
        server = true,
        levels_admin = true,
    },

    func = function(name, target, num)
        hunt_levels.set_xp(target, num)
        minetest.chat_send_player(name, minetest.colorize("#29d10f", "Set XP of " .. target .. " to: " .. num))
    end,
})

cmd:sub("add_xp :target :num", {
    privs = {
        server = true,
        levels_admin = true,
    },

    func = function(name, target, num)
        if not hunt_levels.get_player_level(target) then
            minetest.chat_send_player(name, minetest.colorize("#ff0000", "Player not found."))
            return
        end

        local num = math.ceil(num)

        hunt_levels.add_xp(target, num)

        minetest.chat_send_player(name, minetest.colorize("#29d10f", "Added " .. num .. "  XP to " .. target))
    end,
})