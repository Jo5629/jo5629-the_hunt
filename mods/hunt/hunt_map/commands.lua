minetest.register_chatcommand("place_map", {
        description = "Place a map.",
        func = function(name, param)
                local map_def = hunt_map.maps[param]
                if  type(map_def) == "table" then
                        hunt_map.place_map(param, map_def)
                else
                         minetest.chat_send_player(name, minetest.colorize("red", "Map could not be found!"))
                        return
                end
        end,
})