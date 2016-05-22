
if mobs.mod and mobs.mod == "redo" then

-- bear
	mobs:register_mob("mobs_bear:medved", {
		type = "npc",
		--lifetimer = 180,

		visual = "mesh",
		--visual_size = {x=1, y=1},
		mesh = "mobs_medved.x",
		--gotten_mesh = "mobs_medved.x",
		rotate = 0,
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
		animation = { 
			speed_normal = 15,	speed_run = 30,
			stand_start = 0,	stand_end = 30,
			walk_start = 35,	walk_end = 65,
			run_start = 105,	run_end = 135,
			punch_start = 70,	punch_end = 100,
			--punch2_start = 70,	punch2_end = 100,
			--shoot_start = 0,	shoot_end = 0,
			--speed_punch = 0,	speed_punch2 = 0,	speed_shoot = 0
		},
		textures = {
			{"mobs_medved.png"},
			{"mobs_medved_dark.png"}
		},
		--gotten_texture = {{"mobs_medved.png"}},
		--child_texture = {{"mobs_medved.png"}},

		--stepheight = 0.6,
		fear_height = 4,
		runaway = false,
		jump = false,
		--jump_chance = 0,
		jump_height = 4,
		fly = false,
		--fly_in = "air",
		walk_chance = 75,
		--walk_velocity = 1,
		run_velocity = 3,
		--fall_speed = -10,
		--floats = 1,

		view_range = 12,
		follow = {
			"mobs:honey",
			"farming:blueberries", "farming:raspberries"
		},

		passive = true,
		attack_type = "dogfight",
		damage = 10,
		reach = 3,
		--docile_by_day = false,
		attacks_monsters = true,
		pathfinding = true,
		--double_melee_attack = false,
		--group_attack = false,
		--explosion_radius = 1,
		--arrow = "ent:name",
		--shoot_interval = 1,
		--shoot_offset = 0,
		--dogshoot_switch = 1,
		--dogshoot_count_max = 5,

		hp_min = 10,
		hp_max = 25,
		armor = 100,
		knock_back = 1,
		lava_damage = 10,
		fall_damage = 5,
		--water_damage = 0,
		--light_damage = 0,
		--recovery_time = 0.5,
		--immune_to = {},
		--blood_amount = 5,
		--blood_texture = "mobs_blood.png",

		makes_footstep_sound = true,
		--sounds = {},

		drops = {
			{name="mobs:meat_raw", chance=1, min=1, max=2},
			{name="mobs:leather", chance=1, min=1, max=2}			
		},

		replace_what = {
			"mobs:beehive",
			"mobs_bugslive:bug",
			"farming:blueberry_4", "farming:raspberry_4"
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
				if mobs:feed_tame(self, clicker, 10, true, true) then
					return
				end
				if clicker:get_wielded_item():is_empty() and clicker:get_player_name() == self.owner then
					if clicker:get_player_control().sneak then
						self.order = ""
						self.state = "walk"
						self.walk_velocity = 1
					else
						if self.order == "follow" then
							self.order = "stand"
							self.state = "stand"
							self.walk_velocity = 1
						else
							self.order = "follow"
							self.state = "walk"
							self.walk_velocity = 3
						end
					end
					return
				end
				mobs:capture_mob(self, clicker, 0, 0, 80, false, nil)
			end
	})

	local l_spawn_elevation_min = minetest.setting_get("water_level")
	if l_spawn_elevation_min then
		l_spawn_elevation_min = l_spawn_elevation_min - 10
	else
		l_spawn_elevation_min = -10
	end
	--name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height
	mobs:spawn_specific(
		"mobs_bear:medved",
		{"default:dirt_with_grass", "ethereal:green_dirt_top"},
		{"air"},
		0, 20, 30, 30000, 1, l_spawn_elevation_min, 31000
	)
	mobs:register_egg("mobs_bear:medved", "Bear", "wool_brown.png", 1)

end
