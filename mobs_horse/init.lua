
if mobs.mod and mobs.mod == "redo" then

-- horse
	mobs:register_mob("mobs_horse:horse", {
		type = "npc",
		--lifetimer = 180,

		visual = "mesh",
		visual_size = {x=1.20, y=1.20},
		mesh = "mobs_horse.x",
		--gotten_mesh = "",
		--rotate = 0,
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.25, 0.4},
		animation = { 
			speed_normal = 15,	speed_run = 30,
			stand_start = 25,	stand_end = 75,
			walk_start = 75,	walk_end = 100,
			run_start = 75,	run_end = 100,
			--punch_start = 0,	punch_end = 0,
			--punch2_start = 0,	punch2_end = 0,
			--shoot_start = 0,	shoot_end = 0,
			--speed_punch = 0,	speed_punch2 = 0,	speed_shoot = 0
		},
		textures = {
			{"mobs_horse.png"},
			{"mobs_horsepeg.png"},
			{"mobs_horseara.png"}
		},
		--gotten_texture = {{"mobs_medved.png"}},
		--child_texture = {},

		--stepheight = 0.6,
		fear_height = 3,
		runaway = true,
		--jump = true,
		--jump_chance = 0,
		--jump_height = 6,
		fly = false,
		--fly_in = "air",
		walk_chance = 60,
		--walk_velocity = 1,
		--run_velocity = 2,
		--fall_speed = -10,
		--floats = 1,

		view_range = 5,
		follow = {
			"farming:wheat"
		},

		passive = true,
		attack_type = "dogfight",
		damage = 5,
		reach = 3,
		--docile_by_day = false,
		attacks_monsters = false,
		pathfinding = true,
		--double_melee_attack = false,
		--group_attack = false,
		--explosion_radius = 1,
		--arrow = "ent:name",
		--shoot_interval = 1,
		--shoot_offset = 0,
		--dogshoot_switch = 1,
		--dogshoot_count_max = 5,

		hp_min = 12,
		hp_max = 16,
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
			{name="mobs:meat_raw", chance=1, min=2, max=3}
		},

		--replace_what = {},
		--replace_with = "",
		--replace_rate = 10,
		--replace_offset = 0,	

		do_custom = function(self, dtime)
				--set needed value if not already present
				if not self.v2 then
					self.v2 = 0
					self.max_speed_forward = 6
					self.max_speed_reverse = 5
					self.accel = 6
					self.braking = 6
					self.turn_spd = 6
					self.terrain_type = 3
					self.driver_attach_at = {x=0, y=20, z=-2}
					self.driver_eye_offset = {x=0, y=3, z=0}
				end
				if self.driver then
					lib_mount.drive(self, dtime, true, "walk", "stand", 1, false)
					return false
				end
				return true
			end,
		--custom_attack = function(self, to_attack)
			--end,
		--on_blast = funtion(object, damage)
				--return do_damage, do_knockback, drops
			--end,
		--on_die = function(self, pos)
			--end,
		on_rightclick = function(self, clicker)
				if not clicker or not clicker:is_player() then
					return
				end
				if mobs:feed_tame(self, clicker, 10, true, true) then
					return
				end
				if self.tamed and self.owner == clicker:get_player_name() then
					local inv = clicker:get_inventory()
					if self.driver and clicker == self.driver then
						-- detach
						self.object:set_properties({textures = self.base_texture, stepheight = 0.6})
						lib_mount.detach(clicker, {x=1, y=0, z=1})
						if inv:room_for_item("main", "mobs:saddle") then
							inv:add_item("main", "mobs:saddle")
						else
							minetest.add_item(clicker.getpos(), "mobs:saddle")
						end
					elseif not self.driver then
						-- attach
						if clicker:get_wielded_item():get_name() == "mobs:saddle" then
							local tex = string.split(self.base_texture[1], ".")
							self.object:set_properties({textures = {tex[1].."h1."..tex[2]}, stepheight = 1.1})
							lib_mount.attach(self, clicker, false)
							inv:remove_item("main", "mobs:saddle")
						end
					end
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
		"mobs_horse:horse",
		{"default:dirt_with_grass", "ethereal:green_dirt_top"},
		{"air"},
		8, 20, 30, 11000, 1, l_spawn_elevation_min, 31000
	)
	mobs:register_egg("mobs_horse:horse", "Horse", "mobs_horse_inv.png", 0)

	-- saddle
	minetest.register_craftitem(":mobs:saddle", {
		description = "Saddle",
		inventory_image = "mobs_saddle.png",
	})

	minetest.register_craft({
		output = "mobs:saddle",
		recipe = {
			{"mobs:leather", "mobs:leather", "mobs:leather"},
			{"mobs:leather", "default:steel_ingot", "mobs:leather"},
			{"mobs:leather", "default:steel_ingot", "mobs:leather"},
		}
	})

end
