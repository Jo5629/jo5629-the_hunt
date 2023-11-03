local version = "1.3.3"
local srcpath = minetest.get_modpath("parties") .. "/src"

dofile(srcpath .. "/api.lua")
dofile(srcpath .. "/callbacks.lua")
dofile(srcpath .. "/chatcmdbuilder.lua")
dofile(srcpath .. "/commands.lua")
dofile(srcpath .. "/player_manager.lua")

minetest.log("action", "[PARTIES] Mod initialised, running version " .. version)
