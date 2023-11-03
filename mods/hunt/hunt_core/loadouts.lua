local storage = minetest.get_mod_storage()

hunt_core.players_loadout = minetest.deserialize(storage:get_string("hunt_core.players_loadout")) or {}
hunt_core.loadout_weapons = {
	primary = {"ctf_ranged:ak47_loaded", "ctf_ranged:benelli_loaded", "ctf_ranged:g11_loaded", "ctf_ranged:jackhammer_loaded", "ctf_ranged:m16_loaded",
	"ctf_ranged:m200_loaded", "ctf_ranged:m60_loaded", "ctf_ranged:mini14_loaded", "ctf_ranged:mp5_loaded", "ctf_ranged:remington870_loaded", "ctf_ranged:rpk_loaded",
	"ctf_ranged:scar_loaded", "ctf_ranged:svd_loaded", "ctf_ranged:thompson_loaded", "ctf_ranged:uzi_loaded"},
	secondary = {"ctf_ranged:deagle_loaded", "ctf_ranged:deagle_gold_loaded", "ctf_ranged:python_loaded", "ctf_ranged:makarov_loaded", "ctf_ranged:glock17_loaded"},
	handheld = {"default:sword_stone"},
}

hunt_core.default_loadout = {
	primary = "ctf_ranged:m16_loaded",
	secondary = "ctf_ranged:glock17_loaded",
	handheld = "default:sword_stone",
}

function hunt_core.get_loadout(pname)
        return hunt_core.players_loadout[pname]
end

function hunt_core.set_loadout(pname, loadout_table)
        hunt_core.players_loadout[pname] = loadout_table
end

function hunt_core.give_loadout(pname, target) --> Gives loadout to pname. If target nil, then get self.
	local player = minetest.get_player_by_name(pname)
	local loadout = {}
	if not target then
		loadout = hunt_core.get_loadout(pname)
	else
		loadout = hunt_core.get_loadout(target)
	end

	local inv = player:get_inventory()
	inv:add_item("main", loadout.primary)
	inv:add_item("main", loadout.secondary)
	inv:add_item("main", loadout.handheld)
	inv:add_item("main", ItemStack("ctf_ranged:ammo 80"))
end