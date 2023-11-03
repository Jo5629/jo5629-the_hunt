local modpath = minetest.get_modpath(minetest.get_current_modname())
local maps_path = modpath .. "/maps/"

for _, dirname in ipairs(minetest.get_dir_list(maps_path, true)) do
        for _, filename in ipairs(minetest.get_dir_list(maps_path, true)) do
                if filename == "map.conf" then
                        local map_meta = Settings(maps_path .. "/" .. dirname .. "/" .. filename)
                        local map_name = map_meta:get("name")
                        hunt_map.maps[map_name] = {
                                name = map_name,
                                author = map_meta:get("author"),
                                pos1 = vector.add(#hunt_map.maps + 1, map_meta:get("pos1")),
                                pos2 = vector.add(#hunt_map.maps + 1, map_meta:get("pos2")),
                                lobby_spawnpoint = vector.add(#hunt_map.maps + 1, map_meta:get("lobby_spawnpoint")),
                                team1_spawnpoint = vector.add(#hunt_map.maps + 1, map_meta:get("team1_spawnpoint")),
                                team2_spawnpoint = vector.add(#hunt_map.maps + 1, map_meta:get("team2_spawnpoint")),
                        }
                        minetest.log("action", "Registered map: " .. map_name)
                end
        end
end