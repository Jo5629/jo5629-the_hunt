local current_version = string.format("The Hunt %s by Jo5629/IMDman56", hunt_core.current_version)

minetest.register_node("hunt_lobby:classes", {
        description = "Choose your class with this node.",
        tiles = {
                "classes_side.png",
                "classes_side.png",
                "classes_side.png",
                "classes_side.png",
                "classes_side.png",
                "classes_front.png",
        },
        paramtype2 = "facedir",
        on_construct = function(pos)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Choose your class here.")
        end,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
                local name = clicker:get_player_name()
                local class_table = {
                        current_version,
                        "",
                        "Current Class: THIS IS A WIP",
                }

                local formspec = {
                        "formspec_version[4]",
                        "size[10,10]",
                        string.format("textarea[0.2,0.2;7.8,6;;;%s]", table.concat(class_table, "\n"))
                }

                minetest.show_formspec(name, "hunt_lobby:classes", table.concat(formspec, ""))
        end
})