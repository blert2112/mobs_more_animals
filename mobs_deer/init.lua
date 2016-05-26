
if mobs.mod and mobs.mod == "redo" then

-- deer
	mobs:register_mob("mobs_deer:deer", {
		type = "animal",
		--lifetimer = 180,

		visual = "mesh",
		--visual_size = {x=1, y=1},
		mesh = "mobs_deer2.x",
		--gotten_mesh = "",
		--rotate = 0,
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
		animation = { 
			speed_normal = 15,	speed_run = 24,
			stand_start = 25,	stand_end = 75,
			walk_start = 75,	walk_end = 100,
			run_start = 75,		run_end = 100
			--punch_start = 0,	punch_end = 0,
			--punch2_start = 0,	punch2_end = 0,
			--shoot_start = 0,	shoot_end = 0,
			--speed_punch = 0,	speed_punch2 = 0,	speed_shoot = 0
		},
		textures = {
			{"mobs_deer.png"},
		},
		--gotten_texture = {},
		--child_texture = {},

		stepheight = 1.1,
		fear_height = 4,
		--jump = true,
		jump_chance = 5,
		jump_height = 8,
		fly = false,
		--fly_in = "air",
		walk_chance = 75,
		--walk_velocity = 1,
		run_velocity = 3,
		--fall_speed = -10,
		--floats = 1,

		view_range = 14,
		follow = "farming:wheat",

		passive = true,
		attack_type = "dogfight",
		damage = 10,
		reach = 3,
		--docile_by_day = false,
		--attacks_monsters = false,
		runaway = true,
		pathfinding = false,
		--double_melee_attack = false,
		--group_attack = false,
		--explosion_radius = 1,
		--arrow = "ent:name",
		--shoot_interval = 1,
		--shoot_offset = 0,
		--dogshoot_switch = 1,
		--dogshoot_count_max = 5,

		hp_min = 4,
		hp_max = 8,
		armor = 200,
		knock_back = 1,
		lava_damage = 5,
		fall_damage = 5,
		water_damage = 1,
		--light_damage = 0,
		--recovery_time = 0.5,
		--immune_to = {},
		--blood_amount = 5,
		--blood_texture = "mobs_blood.png",

		makes_footstep_sound = true,
		--sounds = {},

		drops = {
			{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
			{name = "mobs:leather", chance = 1, min = 1, max = 3}
		},

		replace_what = {
			"default:grass_3", "default:grass_4", "default:grass_5", 
			"farming:wheat_8"
		},
		replace_with = "air",
		replace_rate = 20,
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
				if mobs:feed_tame(self, clicker, 8, true, false) then
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
	mobs:spawn_specific("mobs_deer:deer",
		{"default:dirt_with_grass", "ethereal:green_dirt_top"},
		{"air"},
		8, 20, 30, 20000, 1, l_spawn_elevation_min, 31000
	)
	mobs:register_egg("mobs_deer:deer", "Deer", "wool_violet.png", 1)

end
