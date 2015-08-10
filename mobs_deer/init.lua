
if mobs.mod and mobs.mod == "redo" then

-- deer
	mobs:register_mob("mobs_deer:deer", {
		type = "animal",
		visual = "mesh",
		mesh = "mobs_deer2.x",
		textures = {
			{"mobs_deer.png"},
		},
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
		animation = {
			speed_normal = 15,	speed_run = 24,
			stand_start = 25,	stand_end = 75,
			walk_start = 75,	walk_end = 100,
			run_start = 75,		run_end = 100
		},
		makes_footstep_sound = true,
		hp_min = 4,
		hp_max = 8,
		armor = 200,
		knock_back = 1,
		water_damage = 1,
		lava_damage = 5,
		fall_damage = 5,
		passive = true,
		view_range = 14,
		run_velocity = 3,
		stepheight = 1.1,
		jump_height = 8,
		jump_chance = 5,
		drops = {
			{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
			--{name = "mobs:leather", chance = 1, min = 1, max = 3}
		},
		follow = "farming:wheat",
		replace_rate = 50,
		replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "farming:wheat_8"},
		replace_with = "air",
		on_rightclick = function(self, clicker)
			if mobs:feed_tame(self, clicker, 10, true) then
				return
			end
			mobs:capture_mob(self, clicker, 0, 0, 80, false, nil)
		end
	})

	local l_spawn_elevation_min = minetest.setting_get("water_level") + 1 or 1
	--name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height
	mobs:spawn_specific("mobs_deer:deer",
		{"default:dirt_with_grass", "ethereal:green_dirt_top"},
		{"air"},
		8, 20, 30, 20000, 1, l_spawn_elevation_min, 31000
	)
	mobs:register_egg("mobs_deer:deer", "Deer", "wool_violet.png", 1)

end
