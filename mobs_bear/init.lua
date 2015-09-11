
if mobs.mod and mobs.mod == "redo" then

-- bear
	mobs:register_mob("mobs_bear:medved", {
		type = "npc",
		visual = "mesh",
		mesh = "mobs_medved.x",
		textures = {
			{"mobs_medved.png"},
		},
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
		animation = { 
			speed_normal = 15,	speed_run = 24,
			stand_start = 0,	stand_end = 30,
			walk_start = 35,	walk_end = 65,
			run_start = 105,	run_end = 135,
			punch_start = 70,	punch_end = 100
		},
		makes_footstep_sound = true,
		hp_min= 10,
		hp_max = 25,
		armor = 100,
		knock_back = 1,
		lava_damage = 10,
		fall_damage = 5,
		damage = 10,
		attack_type = "dogfight",
		attacks_monsters = true,
		view_range = 14,
		stepheight = 1.1,
		jump = false,
		drops = {
			{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
			{name = "mobs:leather", chance = 1, min = 1, max = 2}			
		},
		follow = {"mobs:honey", "farming:raspberries", "farming:blueberries", "farming_plus:strawberry_item",
			"bushes:strawberry", "bushes:blackberry", "bushes:blueberry", "bushes:raspberry",
			"bushes:gooseberry", "bushes:mixed_berry"},
		replace_rate = 50,
		replace_what = {"mobs:beehive", "farming:blueberry_4", "farming:raspberry_4", "farming_plus:strawberry",
			"bushes:strawberry_bush", "bushes:blackberry_bush", "bushes:blueberry_bush", "bushes:raspberry_bush",
			"bushes:gooseberry_bush", "bushes:mixed_berry_bush"},
		replace_with = "air",
		on_rightclick = function(self, clicker)
			if mobs:feed_tame(self, clicker, 10, true) then
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

	local l_spawn_elevation_min = minetest.setting_get("water_level")
	if l_spawn_elevation_min then
		l_spawn_elevation_min = l_spawn_elevation_min - 10
	else
		l_spawn_elevation_min = -10
	end
	--name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height
	mobs:spawn_specific("mobs_bear:medved",
		{"default:dirt_with_grass", "default:dirt", "default:desert_sand", "ethereal:green_dirt_top"},
		{"air"},
		0, 20, 30, 20000, 1, l_spawn_elevation_min, 31000
	)
	mobs:register_egg("mobs_bear:medved", "Bear", "wool_brown.png", 1)

end
