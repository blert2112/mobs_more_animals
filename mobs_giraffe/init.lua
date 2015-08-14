
if mobs.mod and mobs.mod == "redo" then

-- jeraf
	mobs:register_mob("mobs_giraffe:jeraf", {
		type = "animal",
		visual = "mesh",
		mesh = "mobs_jeraf.x",
		textures = {
			{"mobs_jeraf.png"},
		},
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
		animation = {
			speed_normal = 15,	speed_run = 24,
			stand_start = 0,	stand_end = 30,
			walk_start = 70,	walk_end = 100,
			run_start = 70,		run_end = 100
		},
		makes_footstep_sound = true,
		hp_min = 8,
		hp_max = 12,
		armor = 200,
		knock_back = 1,
		water_damage = 1,
		lava_damage = 5,
		fall_damage = 10,
		passive = true,
		view_range = 16,
		walk_velocity = 2,
		run_velocity = 4,
		stepheight = 2.1,
		jump = false,
		drops = {
			{name = "mobs:meat_raw", chance = 1, min = 1, max = 3},
			{name = "mobs:leather", chance = 1, min = 1, max = 4}
		},
		follow = {"group:leaves"},
		replace_rate = 50,
		replace_what = {"group:leaves"},
		replace_with = "air",
		on_rightclick = function(self, clicker)
			if mobs:feed_tame(self, clicker, 10, true) then
				return
			end
			mobs:capture_mob(self, clicker, 0, 0, 80, false, nil)
		end
	})

	local l_spawn_elevation_min = minetest.setting_get("water_level")
	if l_spawn_elevation_min then
		l_spawn_elevation_min = l_spawn_elevation_min + 1
	else
		l_spawn_elevation_min = 1
	end
	--name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height
	mobs:spawn_specific("mobs_giraffe:jeraf",
		{"default:sand", "default:desert_sand"},
		{"air"},
		8, 20, 30, 20000, 1, l_spawn_elevation_min, 31000
	)
	mobs:register_egg("mobs_giraffe:jeraf", "Giraffe", "wool_yellow.png", 1)

end
