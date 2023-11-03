hunt_api = {}

hunt_api.registered_on_shutdown = {}
hunt_api.registered_on_save_data = {}
hunt_api.registered_on_joinplayer = {}
hunt_api.registered_on_leaveplayer = {}

--> @param func function
function hunt_api.register_on_shutdown(func)
	table.insert(hunt_api.registered_on_shutdown, func)
end

--> @param func function
function hunt_api.register_on_save_data(func)
	table.insert(hunt_api.registered_on_save_data, func)
end

function hunt_api.register_on_joinplayer(func)
	table.insert(hunt_api.registered_on_joinplayer, func)
end

function hunt_api.register_on_leaveplayer(func)
	table.insert(hunt_api.registered_on_leaveplayer, func)
end