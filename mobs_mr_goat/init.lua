
if mobs.mod and mobs.mod == "redo" then

-- mr.goat
	mobs:register_mob("mobs_mr_goat:goat", {
		type = "animal",
		--lifetimer = 180,

		visual = "mesh",
		visual_size = {x=2,y=2},
		mesh = "mobs_goat.b3d",
		--gotten_mesh = "",
		--rotate = 0,
		collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.75, 0.3},
		animation = {
			-- 1-30 head down, 31-60 head up, 61-121 tail wiggle, 185-215 lay down,
			-- 216-245 getting up, 331-390 chewing, 391-511 look around
			speed_normal = 15,		speed_run = 24,
			stand_start = 1,		stand_end = 121,
			walk_start = 122,		walk_end = 182,
			run_start = 122,		run_end = 182,
			punch_start = 246,		punch_end = 330,
			--punch2_start = 70,	punch2_end = 100,
			--shoot_start = 0,	shoot_end = 0,
			--speed_punch = 0,	speed_punch2 = 0,	speed_shoot = 0
		},
		textures = {
			{"mobs_goat_white.png"},
			{"mobs_goat_brown.png"},
			{"mobs_goat_grey.png"},
		},
		--gotten_texture = {},
		--child_texture = {},

		stepheight = 0.6,
		fear_height = 4,
		--jump = true,
		jump_chance = 5,
		jump_height = 4,
		fly = false,
		--fly_in = "air",
		walk_chance = 60,
		--walk_velocity = 1,
		--run_velocity = 2,
		--fall_speed = -10,
		--floats = 1,

		view_range = 7,
		follow = {
			"farming:straw"
		},

		passive = true,
		attack_type = "dogfight",
		damage = 3,
		reach = 2,
		--docile_by_day = false,
		--attacks_monsters = false,
		pathfinding = false,
		runaway = false,
		--double_melee_attack = false,
		--group_attack = false,
		--explosion_radius = 1,
		--arrow = "ent:name",
		--shoot_interval = 1,
		--shoot_offset = 0,
		--dogshoot_switch = 1,
		--dogshoot_count_max = 5,

		hp_min = 6,
		hp_max = 12,
		armor = 200,
		knock_back = 1,
		lava_damage = 7,
		fall_damage = 7,
		water_damage = 1,
		--light_damage = 0,
		recovery_time = 0.25,
		--immune_to = {},
		--blood_amount = 5,
		--blood_texture = "mobs_blood.png",

		makes_footstep_sound = true,
		sounds = {
			random = "mobs_sheep",
		},

		drops = {
			{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
			{name = "mobs:leather", chance = 1, min = 1, max = 2}
		},

		replace_what = {"default:grass_3", "default:grass_4", "default:grass_5",},
		replace_with = "air",
		replace_rate = 50,
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
				if  mobs:feed_tame(self, clicker, 8, true, true) then
					return
				end
				local tool = clicker:get_wielded_item()
				if tool:get_name() == "bucket:bucket_empty" then
					if self.gotten == true or self.child == true then
						return
					end
					local inv = clicker:get_inventory()
					inv:remove_item("main", "bucket:bucket_empty")
					if inv:room_for_item("main", {name = "mobs_mr_goat:bucket_goatmilk"}) then
						clicker:get_inventory():add_item("main", "mobs_mr_goat:bucket_goatmilk")
					else
						local pos = self.object:getpos()
						pos.y = pos.y + 0.5
						minetest.add_item(pos, {name = "mobs_mr_goat:bucket_goatmilk"})
					end
					self.gotten = true -- milked
					return
				end
				mobs:capture_mob(self, clicker, 0, 0, 60, false, nil)
			end
	})

	local l_spawn_elevation_min = minetest.setting_get("water_level")
	if l_spawn_elevation_min then
		l_spawn_elevation_min = l_spawn_elevation_min + 1
	else
		l_spawn_elevation_min = 1
	end
	--name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height
	mobs:spawn_specific("mobs_mr_goat:goat",
		{"default:dirt_with_grass", "ethereal:green_dirt_top"},
		{"air"},
		0, 20, 30, 15000, 1, l_spawn_elevation_min, 31000
	)
	mobs:register_egg("mobs_mr_goat:goat", "Goat", "default_grass.png", 1)

	-- bucket of goat milk
	minetest.register_craftitem("mobs_mr_goat:bucket_goatmilk", {
		description = "Bucket of Goat Milk",
		inventory_image = "mobs_bucket_milk.png",
		stack_max = 1,
		on_use = minetest.item_eat(10, 'bucket:bucket_empty')
	})

	-- cheese wedge
	minetest.register_craftitem("mobs_mr_goat:goatcheese", {
		description = "Goat Cheese",
		inventory_image = "mobs_cheese.png",
		on_use = minetest.item_eat(6)
	})
	minetest.register_craft({
		type = "cooking",
		output = "mobs_mr_goat:goatcheese",
		recipe = "mobs_mr_goat:bucket_goatmilk",
		cooktime = 8,
		replacements = {{ "mobs_mr_goat:bucket_goatmilk", "bucket:bucket_empty"}}
	})

	-- cheese block
	minetest.register_node("mobs_mr_goat:goatcheeseblock", {
		description = "Goat Cheese Block",
		tiles = {"mobs_cheeseblock.png"},
		is_ground_content = false,
		groups = {crumbly = 3},
		sounds = default.node_sound_dirt_defaults()
	})
	minetest.register_craft({
		output = "mobs_mr_goat:goatcheeseblock",
		recipe = {
			{'mobs_mr_goat:goatcheese', 'mobs_mr_goat:goatcheese', 'mobs_mr_goat:goatcheese'},
			{'mobs_mr_goat:goatcheese', 'mobs_mr_goat:goatcheese', 'mobs_mr_goat:goatcheese'},
			{'mobs_mr_goat:goatcheese', 'mobs_mr_goat:goatcheese', 'mobs_mr_goat:goatcheese'}
		}
	})
	minetest.register_craft({
		output = "mobs_mr_goat:goatcheese 9",
		recipe = {
			{'mobs_mr_goat:goatcheeseblock'}
		}
	})

end
