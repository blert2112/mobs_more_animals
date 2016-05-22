
if mobs.mod and mobs.mod == "redo" then

-- better rat
	mobs:register_mob("mobs_better_rat:rat", {
		type = "animal",
		--lifetimer = 180,

		visual = "mesh",
		--visual_size = {x=1, y=1},
		mesh = "rat.b3d",
		--gotten_mesh = "",
		rotate = 180,
		collisionbox = {-0.1, -0.01, -0.1, 0.1, 0.1, 0.1},
		--animation = { 
		--	speed_normal = 0,	speed_run = 0,
		--	stand_start = 0,	stand_end = 0,
		--	walk_start = 0,		walk_end = 0,
		--	run_start = 0,		run_end = 0,
		--	punch_start = 0,	punch_end = 0,
		--	punch2_start = 0,	punch2_end = 0,
		--	shoot_start = 0,	shoot_end = 0,
		--	speed_punch = 0,	speed_punch2 = 0,	speed_shoot = 0
		--},
		textures = {
			{"rat_black.png"},
			{"rat_brown.png"},
			{"rat_gray.png"},
			{"rat_white.png"}
		},
		--gotten_texture = {{}},
		--child_texture = {{}},

		stepheight = 1.1,
		--fear_height = 0,
		runaway = true,
		--jump = false,
		--jump_chance = 0,
		jump_height = 2,
		fly = false,
		--fly_in = "air",
		walk_chance = 60,
		walk_velocity = 2,
		run_velocity = 4,
		--fall_speed = -10,
		--floats = 1,

		view_range = 8,
		follow = {"mobs:cheese", "mobs_mr_goat:goatcheese"},

		passive = true,
		attack_type = "dogfight",
		damage = 1,
		reach = 1,
		--docile_by_day = false,
		--attacks_monsters = false,
		pathfinding = false,
		--double_melee_attack = false,
		group_attack = true,
		--explosion_radius = 1,
		--arrow = "ent:name",
		--shoot_interval = 1,
		--shoot_offset = 0,
		--dogshoot_switch = 1,
		--dogshoot_count_max = 5,

		hp_min= 2,
		hp_max = 5,
		armor = 80,
		--knock_back = 3,
		lava_damage = 2,
		fall_damage = 0,
		water_damage = 1,
		--light_damage = 0,
		recovery_time = 0.25,
		--immune_to = {},
		blood_amount = 1,
		--blood_texture = "mobs_blood.png",

		--makes_footstep_sound = false,
		--sounds = {},

		drops = {
			{name = "mobs:cheese", chance = 1, min = 1, max = 2},
		},

		replace_what = {
			"mobs:cheese", "mobs:cheeseblock",
			"mobs_mr_goat:goatcheese", "mobs_mr_goat:goatcheeseblock",
			"farming:barley_5", "farming:barley_6", "farming:barley_7",
			"farming_corn_7.png", "farming_corn_8.png",
			"farming:wheat_5", "farming:wheat_6", "farming:wheat_7", "farming:wheat_8"
		},
		replace_with = "air",
		replace_rate = 10,
		--replace_offset = 0,	

		--do_custom = function(self, dtime)
			--end
		--custom_attack = function(self, to_attack)
			--end,
		--on_blast = funtion(object, damage)
				--return do_damage, do_knockback, drops
			--end,
		--on_die = function(self, pos)
			--end,
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
