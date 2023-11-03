local modpath = minetest.get_modpath(minetest.get_current_modname())

hunt_map = {}
hunt_map.maps = {}

dofile(modpath .. "/nodes.lua")
dofile(modpath .. "/functions.lua")
dofile(modpath .. "/maps.lua")
dofile(modpath .. "/schems.lua")
dofile(modpath .. "/commands.lua")