--> Run the callbacks so that they work correctly.

local timer = 0
local save_interval = minetest.settings:get("hunt_settings.save_interval") or 6
minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer >= save_interval then
		RunCallbacks(hunt_api.registered_on_save_data)
		timer = 0
	end
end)

hunt_api.register_on_shutdown(function()
	RunCallbacks(hunt_api.registered_on_save_data)
end)

minetest.register_on_shutdown(function()
	RunCallbacks(hunt_api.registered_on_shutdown)
end)

minetest.register_on_joinplayer(function(player)
	RunCallbacks(hunt_api.registered_on_joinplayer)
end)

minetest.register_on_leaveplayer(function(player)
	RunCallbacks(hunt_api.registered_on_leaveplayer)
end)