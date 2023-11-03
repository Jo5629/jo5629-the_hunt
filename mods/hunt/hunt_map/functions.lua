--> Multiple parts of the code from https://github.com/EISHU-MT/block_assault/blob/main/mods/engine/bs_maps/essential.lua

function hunt_map.request_offset(id, to_multiply)
	local amount = to_multiply or 250
	local a = amount * id
        
	return vector.new(a, a, a)
end

function hunt_map.emergeblocks_callback(pos, action, num_calls_remaining, ctx)
	if ctx.total_blocks == 0 then
		ctx.total_blocks = num_calls_remaining + 1
		ctx.current_blocks = 0
	end
	ctx.current_blocks = ctx.current_blocks + 1
	if ctx.current_blocks == ctx.total_blocks then
		if ctx.name then
			minetest.chat_send_player(ctx.name,
				string.format("Finished emerging %d blocks in %.2fms.",
				ctx.total_blocks, (os.clock() - ctx.start_time) * 1000))
		end
		ctx:callback()
	elseif ctx.progress then
		ctx:progress()
	end
end

function hunt_map.emerge_with_callbacks(name, pos1, pos2, callback, progress)
	local context = {
		current_blocks = 0,
		total_blocks = 0,
		start_time = os.clock(),
		name = name,
		callback = callback,
		progress = progress,
	}
	minetest.emerge_area(pos1, pos2, hunt_map.emergeblocks_callback, context)
end

local modpath = minetest.get_modpath(minetest.get_current_modname())
function hunt_map.place_map(dirname, map_def)
	if map_def == nil then return end
        local schematic = modpath .. "/maps/" .. dirname .. "/map.mts"
        hunt_map.emerge_with_callbacks(nil, map_def.pos1, map_def.pos2, function()
		core.log("info", "Placing map: "..map_def.name)
		local bool = minetest.place_schematic(map_def.pos1, schematic, map_def.rotation == "z" and "0" or "90")
		assert(bool, "Something failed!: Map core: 'map.mts' dont exist, or may it was corrupted!")
		core.log("info", "ON-PLACE-MAP: Map light areas fix starting")
		local function fix_light(...) core.fix_light(...) core.log("action", "ON-PLACE-MAP: Map light areas fix complete") end
		core.after(5, fix_light, map_def.pos1, map_def.pos2)
	end, nil)
end