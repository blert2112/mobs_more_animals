
if mobs.mod and mobs.mod == "redo" then

-- bugs
	mobs:register_mob("mobs_bugslive:bug", {
		type = "animal",
		--lifetimer = 180,

		visual = "mesh",
		visual_size = {x=0.5, y=0.5},
		mesh = "bug.x",
		--gotten_mesh = "",
		--rotate = 0,
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
			{"bug1.png"},
			{"bug2.png"},
			{"bug3.png"},
			{"bug4.png"},
			{"bug5.png"},
			{"bug6.png"},
			{"bug7.png"},
			{"bug8.png"}
		},
		--gotten_texture = {{}},
		--child_texture = {{}},

		stepheight = 1.1,
		--fear_height = 0,
		runaway = true,
		--jump = true,
		jump_chance = 5,
		jump_height = 2,
		fly = false,
		--fly_in = "air",
		walk_chance = 60,
		walk_velocity = 2,
		run_velocity = 4,
		fall_speed = -5,
		floats = 0,

		view_range = 3,
		--follow = {},

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

		hp_min = 1,
		hp_max = 1,
		armor = 200,
		knock_back = 0,
		lava_damage = 1,
		fall_damage = 0,
		--water_damage = 0,
		--light_damage = 0,
		recovery_time = 0.25,
		--immune_to = {},
		blood_amount = 1,
		--blood_texture = "mobs_blood.png",

		--makes_footstep_sound = false,
		--sounds = {},

		--drops = {},

		replace_what = {
			"farming:beanpole_5",
			"farming:cucumber_4",
			"farming:melon_8",
			"farming:pumpkin_8"
		},
		replace_with = "air",
		replace_rate = 10,
		--replace_offset = 0,

		do_custom = function(self, dtime)
				if math.random() > 0.5 then
					if self.floats == 0 then
						self.floats = 1
					else
						self.floats = 0
					end
				end
			end,
		--custom_attack = function(self, to_attack)
			--end,
		--on_blast = funtion(object, damage)
				--return do_damage, do_knockback, drops
			--end,
		--on_die = function(self, pos)
			--end,
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
