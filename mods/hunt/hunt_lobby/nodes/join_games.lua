local tiles = {
        "join_lobby_side.png",
        "join_lobby_side.png",
        "join_lobby_side.png",
        "join_lobby_side.png",
        "join_lobby_side.png",
        "join_lobby_front.png",
}

minetest.register_node("hunt_lobby:join_deathmath_solo", {
        description = "Deathmatch Solo Lobby.",
        tiles = tiles,
        paramtype2 = "facedir",
        on_construct = function(pos)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Join a solo deathmatch lobby.")
        end,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
                local name = clicker:get_player_name()
                local formspec = {
                        "size[3,2]",
                        "button[0.5,0.2;2,2;join_lobby;Join Lobby]",
                }
                minetest.show_formspec(name, "hunt_lobby:join_deathmatch_solo", table.concat(formspec, ""))
        end,
})