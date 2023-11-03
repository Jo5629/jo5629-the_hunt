local current_version = string.format("The Hunt %s by Jo5629/IMDman56", hunt_core.current_version)

local loadout_weapons= {primary = {}, secondary = {}, handheld = {},}
local loadout_ids = {primary = {}, secondary = {}, handheld = {},}

local function find_string_in_table(string, table)
        local pos = 1
        for i, v in ipairs(table) do
                if v == string then
                        pos = i
                        break
                end
        end
        return pos
end

local function get_loadout_formspec(pname)
        loadout_weapons= {primary = {}, secondary = {}, handheld = {},}
        loadout_ids = {primary = {}, secondary = {}, handheld = {},}

        for _, weapon in pairs(hunt_core.loadout_weapons.primary) do
                local description = minetest.registered_items[weapon].description
                table.insert(loadout_weapons.primary, description)
                loadout_ids.primary[description] = weapon
        end
        for _, weapon in pairs(hunt_core.loadout_weapons.secondary) do
                local description = minetest.registered_items[weapon].description
                table.insert(loadout_weapons.secondary, description)
                loadout_ids.secondary[description] = weapon
        end
        for _, weapon in pairs(hunt_core.loadout_weapons.handheld) do
                local description = minetest.registered_items[weapon].description
                table.insert(loadout_weapons.handheld, description)
                loadout_ids.handheld[description] = weapon
        end

        table.sort(loadout_weapons.primary, function (a, b) return string.upper(a) < string.upper(b) end)
        table.sort(loadout_weapons.secondary, function (a, b) return string.upper(a) < string.upper(b) end)
        table.sort(loadout_weapons.handheld, function (a, b) return string.upper(a) < string.upper(b) end)

        local loadout_table = {
                current_version,
                "",
                "Your Loadout:",
        }

        local player_loadout = hunt_core.get_loadout(pname)
        local formspec = {
                "formspec_version[4]",
                "size[12,11]",
                string.format("textarea[0.2,0.2;11.6,2.2;;;%s]", table.concat(loadout_table, "\n")),

                "label[0.2,3;Primary:]",
                "item_image[3,3;1.5,1.5;" .. player_loadout.primary .."]",
                "dropdown[5.5,3;6,1;loadout_primary;" .. table.concat(loadout_weapons.primary, ",") .. ";" ..
                find_string_in_table(minetest.registered_items[player_loadout.primary].description, loadout_weapons.primary) ..";]",

                "label[0.2,5;Secondary:]",
                "item_image[3,5;1.5,1.5;" .. player_loadout.secondary .. "]",
                "dropdown[5.5,5;6,1;loadout_secondary;" .. table.concat(loadout_weapons.secondary, ",") .. ";" ..
                find_string_in_table(minetest.registered_items[player_loadout.secondary].description, loadout_weapons.secondary) .. ";]",

                "label[0.2,7;Handheld:]",
                "item_image[3,7;1.5,1.5;" .. player_loadout.handheld .."]",
                "dropdown[5.5,7;6,1;loadout_handheld;" .. table.concat(loadout_weapons.handheld, ",") .. ";" ..
                find_string_in_table(minetest.registered_items[player_loadout.handheld].description, loadout_weapons.handheld) .. ";]",

                "button[4.5,9.5;3,1;save;Save Loadout]",
        }

        return formspec
end

minetest.register_node("hunt_lobby:loadout", {
        description = "Choose your loadout with this node.",
        tiles = {
                "loadout_side.png",
                "loadout_side.png",
                "loadout_side.png",
                "loadout_side.png",
                "loadout_side.png",
                "loadout_front.png",
        },
        paramtype2 = "facedir",
        on_construct = function(pos)
                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Choose your loadout here.")
        end,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
                local name = clicker:get_player_name()
                minetest.show_formspec(name, "hunt_lobby:loadout", table.concat(get_loadout_formspec(name), ""))
        end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
        local name = player:get_player_name()
        if formname ~= "hunt_lobby:loadout" then
                return
        end

        if fields.save then
                minetest.close_formspec(name, formname)
                minetest.chat_send_player(name, minetest.colorize("green", "Loadout has been saved!"))
                local loadout_table = {
                        primary = loadout_ids.primary[fields.loadout_primary],
                        secondary = loadout_ids.secondary[fields.loadout_secondary],
                        handheld = loadout_ids.handheld[fields.loadout_handheld],
                }
                hunt_core.set_loadout(name, loadout_table)
        end
end)