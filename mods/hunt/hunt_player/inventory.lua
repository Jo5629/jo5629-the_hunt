local current_version = string.format("The Hunt %s by Jo5629/IMDman56", hunt_core.current_version)

local about_table = {
    current_version,
    "",
}

local formspec = {
    string.format("textarea[0.2,0.1;7.8,6;;;%s]", table.concat(about_table, "\n"))
}

sfinv.override_page("sfinv:crafting", {
    title = "About",
    get = function(self, player, context)
		return sfinv.make_formspec(player, context, table.concat(formspec, ""), true)
	end
})

local function get_formspec(pname)
    local xp_table = hunt_levels.get_player_level(pname)
    local xp_max = hunt_levels.get_xp_needed(pname)

    local leveling_table = {
        current_version,
        "",
        "",
        "Level: " .. xp_table.level,
        "XP: " .. xp_table.xp,
        "XP Needed: " .. xp_max - xp_table.xp,
    }

    local barwidth = 6
    local perc = xp_table.xp/xp_max
    local formspec = {
        "",
        string.format("textarea[0.2,0.1;7.8,6;;;%s]", table.concat(leveling_table, "\n")),
        "background[1,4;" .. barwidth ..",0.7;progress_gray.png;false]",
        "background[1,4;" .. (barwidth * perc) ..",0.7;progress_green.png;false]",
    }

    return table.concat(formspec, "")
end

sfinv.register_page("hunt_player:leveling", {
    title = "Leveling",
    get = function(self, player, context)
        return sfinv.make_formspec(player, context,
                get_formspec(player:get_player_name()), false, "size[8,5]")
    end
})