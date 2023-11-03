minetest.register_privilege("hunt_admin", {
        description = "Allows you to use advanced commands.",
        give_to_singleplayer = false,
})

local cmd = chatcmdbuilder.register("loadout", {
        description = "Gets the loadout of you or another player's.",
        privs = {
                server = true,
                hunt_admin = true,
        }
})

cmd:sub("", function(name)
        hunt_core.give_loadout(name, nil)
        minetest.chat_send_player(name, "Got your own loadout.")
end)

cmd:sub("get :target", function(name, target)
        if not hunt_core.get_loadout(target) then
                minetest.chat_send_player(name, minetest.colorize("red", "Player not found."))
                return
        end

        hunt_core.give_loadout(name, target)
        minetest.chat_send_player(name, "Got loadout of: " .. target)
end)