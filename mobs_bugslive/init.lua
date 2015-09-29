
if mobs.mod and mobs.mod == "redo" then

-- bugs
	mobs:register_mob("mobs_bugslive:bug", {
		type = "animal",
		visual = "mesh",
		mesh = "bug.x",
		textures = {
			{"bug1.png"},
			{"bug2.png"},
			{"bug3.png"},
			{"bug4.png"},
			{"bug5.png"},
			{"bug6.png"},
			{"bug7.png"},
			{"bug8.png"}
		},
		collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.2, 0.2},
		hp_min = 1,
		hp_max = 1,
		armor = 200,
		knock_back = 0,
		blood_amount = 1,
		lava_damage = 1,
		fall_damage = 0,
		damage = 1,
		reach = 1,
		attack_type = "dogfight",
		group_attack = true,
		view_range = 3,
		stepheight = 1.1,
		jump_height = 2,
		jump_chance = 5,
		fall_speed = -5,
		floats = 0,
		on_rightclick = function(self, clicker)
			mobs:capture_mob(self, clicker, 50, 80, 0, true, nil)
		end
	})

	--name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height
	mobs:spawn_specific("mobs_bugslive:bug",
		{"default:dirt_with_grass", "default:stone", "ethereal:green_dirt_top"},
		{"air", "default:water_source", "default:water_flowing", "default:river_water_source", "default:river_water_flowing"},
		-1, 20, 30, 6000, 2, -31000, 31000
	)
	mobs:register_egg("mobs_bugslive:bug", "Bug", "inv_bug.png", 0)

end
