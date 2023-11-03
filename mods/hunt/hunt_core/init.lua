hunt_core = {}

hunt_core.current_version = "v0.1.22"

function RunCallbacks(funclist, ...)
	for _, func in ipairs(funclist) do
		local temp = func(...)

		if temp then
			return temp
		end
	end
end

local modpath = minetest.get_modpath(minetest.get_current_modname())
dofile(modpath .. "/commands.lua")
dofile(modpath .. "/loadouts.lua")
dofile(modpath .. "/activate_callbacks.lua")

local storage = minetest.get_mod_storage()

hunt_api.register_on_save_data(function()
	storage:set_string("hunt_core.players_loadout", minetest.serialize(hunt_core.players_loadout))
	minetest.log("action", "Saved data.")
end)