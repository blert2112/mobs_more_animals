
if mobs.mod and mobs.mod == "redo" then

-- wolf
	mobs:register_mob("mobs_wolf:wolf", {
		type = "animal",
		--lifetimer = 180,

		visual = "mesh",
		--visual_size = {x=1, y=1},
		mesh = "mobs_wolf.x",
		--gotten_mesh = "",
		--rotate = 0,
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
		animation = { 
			speed_normal = 20,	speed_run = 30,
			stand_start = 10,	stand_end = 20,
			walk_start = 75,	walk_end = 100,
			run_start = 100,	run_end = 130,
			punch_start = 135,	punch_end = 155,
			--punch2_start = 0,	punch2_end = 0,
			--shoot_start = 0,	shoot_end = 0,
			--speed_punch = 0,	speed_punch2 = 0,	speed_shoot = 0
		},
		textures = {
			{"mobs_wolf.png"},
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
		walk_velocity = 2,
		run_velocity = 3,
		--fall_speed = -10,
		--floats = 1,

		view_range = 7,
		follow = "mobs:meat_raw",

		passive = false,
		attack_type = "dogfight",
		damage = 2,
		reach = 2,
		--docile_by_day = false,
		attacks_monsters = false,
		pathfinding = true,
		--double_melee_attack = false,
		group_attack = true,
		--explosion_radius = 1,
		--arrow = "ent:name",
		--shoot_interval = 1,
		--shoot_offset = 0,
		--dogshoot_switch = 1,
		--dogshoot_count_max = 5,

		hp_min = 4,
		hp_max = 6,
		armor = 200,
		knock_back = 2,
		lava_damage = 5,
		fall_damage = 4,
		--water_damage = 0,
		--light_damage = 0,
		--recovery_time = 0.5,
		--immune_to = {},
		--blood_amount = 5,
		--blood_texture = "mobs_blood.png",

		makes_footstep_sound = true,
		sounds = {
			war_cry = "mobs_wolf_attack"
		},

		--drops = {},

		--replace_what = {},
		--replace_with = "air",
		--replace_rate = 20,
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
				if mobs:feed_tame(self, clicker, 2, false, true) then
					if self.food == 0 then
						local mob = minetest.add_entity(self.object:getpos(), "mobs_wolf:dog")
						local ent = mob:get_luaentity()
						ent.owner = clicker:get_player_name()
						ent.following = clicker
						ent.order = "follow"
						self.object:remove()
					end
					return
				end
				mobs:capture_mob(self, clicker, 0, 0, 80, true, nil)
			end
	})

	local l_spawn_elevation_min = minetest.setting_get("water_level")
	if l_spawn_elevation_min then
		l_spawn_elevation_min = l_spawn_elevation_min - 5
	else
		l_spawn_elevation_min = -5
	end
	--name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height
	mobs:spawn_specific("mobs_wolf:wolf",
		{"default:dirt_with_grass", "default:dirt","default:snow", "default:snowblock", "ethereal:green_dirt_top"},
		{"air"},
		-1, 20, 30, 10000, 2, l_spawn_elevation_min, 31000
	)
	mobs:register_egg("mobs_wolf:wolf", "Wolf", "wool_grey.png", 1)

-- Dog
	mobs:register_mob("mobs_wolf:dog", {
		type = "npc",
		--lifetimer = 180,

		visual = "mesh",
		--visual_size = {x=1, y=1},
		mesh = "mobs_wolf.x",
		--gotten_mesh = "",
		--rotate = 0,
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
		animation = { 
			speed_normal = 20,	speed_run = 30,
			stand_start = 10,	stand_end = 20,
			walk_start = 75,	walk_end = 100,
			run_start = 100,	run_end = 130,
			punch_start = 135,	punch_end = 155,
			--punch2_start = 0,	punch2_end = 0,
			--shoot_start = 0,	shoot_end = 0,
			--speed_punch = 0,	speed_punch2 = 0,	speed_shoot = 0
		},
		textures = {
			{"mobs_dog.png"},
			{"mobs_medved.png"}
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
		walk_velocity = 2,
		run_velocity = 4,
		--fall_speed = -10,
		--floats = 1,

		view_range = 15,
		follow = "mobs:meat_raw",

		passive = false,
		attack_type = "dogfight",
		damage = 2,
		reach = 2,
		--docile_by_day = false,
		attacks_monsters = true,
		pathfinding = true,
		--double_melee_attack = false,
		group_attack = true,
		--explosion_radius = 1,
		--arrow = "ent:name",
		--shoot_interval = 1,
		--shoot_offset = 0,
		--dogshoot_switch = 1,
		--dogshoot_count_max = 5,

		hp_min = 5,
		hp_max = 7,
		armor = 200,
		knock_back = 2,
		lava_damage = 5,
		fall_damage = 5,
		--water_damage = 0,
		--light_damage = 0,
		--recovery_time = 0.5,
		--immune_to = {},
		--blood_amount = 5,
		--blood_texture = "mobs_blood.png",

		makes_footstep_sound = true,
		sounds = {
			war_cry = "mobs_wolf_attack"
		},

		--drops = {},

		--replace_what = {},
		--replace_with = "air",
		--replace_rate = 20,
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
				if mobs:feed_tame(self, clicker, 6, true, true) then
					return
				end
				if clicker:get_wielded_item():is_empty() and clicker:get_player_name() == self.owner then
					if clicker:get_player_control().sneak then
						self.order = ""
						self.state = "walk"
						self.walk_velocity = 2
						self.stepheight = 0.6
					else
						if self.order == "follow" then
							self.order = "stand"
							self.state = "stand"
							self.walk_velocity = 2
							self.stepheight = 0.6
						else
							self.order = "follow"
							self.state = "walk"
							self.walk_velocity = 3
							self.stepheight = 1.1
						end
					end
					return
				end
				mobs:capture_mob(self, clicker, 0, 0, 80, false, nil)
			end
	})

	mobs:register_egg("mobs_wolf:dog", "Dog", "wool_brown.png", 1)

end
