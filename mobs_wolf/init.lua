
if mobs.mod and mobs.mod == "redo" then

-- wolf
	mobs:register_mob("mobs_wolf:wolf", {
		type = "animal",
		visual = "mesh",
		mesh = "mobs_wolf.x",
		textures = {
			{"mobs_wolf.png"},
		},
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
		animation = {
			speed_normal = 20,	speed_run = 30,
			stand_start = 10,	stand_end = 20,
			walk_start = 75,	walk_end = 100,
			run_start = 100,	run_end = 130,
			punch_start = 135,	punch_end = 155
		},
		makes_footstep_sound = true,
		sounds = {
			war_cry = "mobs_wolf_attack"
		},
		hp_min = 4,
		hp_max = 6,
		armor = 200,
		lava_damage = 5,
		fall_damage = 4,
		damage = 2,
		attack_type = "dogfight",
		group_attack = true,
		view_range = 7,
		walk_velocity = 2,
		run_velocity = 3,
		stepheight = 1.1,
		follow = "mobs:meat_raw",
		on_rightclick = function(self, clicker)
			if mobs:feed_tame(self, clicker, 2, false) then
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
		visual = "mesh",
		mesh = "mobs_wolf.x",
		textures = {
			{"mobs_dog.png"},
			{"mobs_medved.png"}
		},
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
		animation = {
			speed_normal = 20,	speed_run = 30,
			stand_start = 10,	stand_end = 20,
			walk_start = 75,	walk_end = 100,
			run_start = 100,	run_end = 130,
			punch_start = 135,	punch_end = 155
		},
		makes_footstep_sound = true,
		sounds = {
			war_cry = "mobs_wolf_attack"
		},
		hp_min = 5,
		hp_max = 7,
		armor = 200,
		lava_damage = 5,
		fall_damage = 5,
		damage = 2,
		attack_type = "dogfight",
		attacks_monsters = true,
		group_attack = true,
		view_range = 15,
		walk_velocity = 2,
		run_velocity = 4,
		stepheight = 1.1,
		follow = "mobs:raw_meat",
		on_rightclick = function(self, clicker)
			if mobs:feed_tame(self, clicker, 6, true) then
				return
			end
			if clicker:get_wielded_item():is_empty() and clicker:get_player_name() == self.owner then
				if clicker:get_player_control().sneak then
					self.order = ""
					self.state = "walk"
				else
					if self.order == "follow" then
						self.order = "stand"
						self.state = "stand"
					else
						self.order = "follow"
						self.state = "walk"
					end
				end
				return
			end
			mobs:capture_mob(self, clicker, 0, 0, 80, false, nil)
		end
	})

	mobs:register_egg("mobs_wolf:dog", "Dog", "wool_brown.png", 1)

end
