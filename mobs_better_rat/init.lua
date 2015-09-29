
if mobs.mod and mobs.mod == "redo" then

-- better rat
	mobs:register_mob("mobs_better_rat:rat", {
		type = "animal",
		visual = "mesh",
		mesh = "rat.b3d",
		rotate = 180,
		textures = {
			{"rat_black.png"},
			{"rat_brown.png"},
			{"rat_gray.png"},
			{"rat_white.png"}
		},
		collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.2, 0.2},
		hp_min= 2,
		hp_max = 5,
		armor = 80,
		knock_back = 2,
		blood_amount = 1,
		water_damage = 1,
		lava_damage = 5,
		fall_damage = 0,
		damage = 1,
		reach = 1,
		attack_type = "dogfight",
		group_attack = true,
		drops = {
			{name = "mobs:cheese", chance = 1, min = 1, max = 2},
		},
		follow = {"mobs:cheese", "mobs_mr_goat:goatcheese"},
		replace_rate = 50,
		replace_what = {"mobs:cheese", "mobs:cheeseblock", "mobs_mr_goat:goatcheese", "mobs_mr_goat:goatcheeseblock"},
		replace_with = "air",
		view_range = 8,
		stepheight = 1.1,
		jump = false,
		on_rightclick = function(self, clicker)
			mobs:capture_mob(self, clicker, 25, 80, 0, true, nil)
		end
	})

	--name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height
	mobs:spawn_specific("mobs_better_rat:rat",
		{"default:stone"},
		{"air"},
		0, 20, 30, 16000, 2, -31000, 31000
	)
	mobs:register_egg("mobs_better_rat:rat", "rat", "wool_brown.png", 1)

end
