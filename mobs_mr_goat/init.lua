
if mobs.mod and mobs.mod == "redo" then

-- mr.goat
	mobs:register_mob("mobs_mr_goat:goat", {
		type = "animal",
		visual = "mesh",
		mesh = "mobs_goat.b3d",
		textures = {
			{"mobs_goat_white.png"},
			{"mobs_goat_brown.png"},
			{"mobs_goat_grey.png"},
		},
		visual_size = {x=2,y=2},
		collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.75, 0.3},
		animation = {
			speed_normal = 15,		speed_run = 24,
			stand_start = 1,		stand_end = 121,
			walk_start = 122,		walk_end = 182,
			run_start = 122,		run_end = 182,
			punch_start = 246,		punch_end = 330,
			-- 1-30 head down, 31-60 head up, 61-121 tail wiggle, 185-215 lay down,
			-- 216-245 getting up, 331-390 chewing, 391-511 look around
		},
		makes_footstep_sound = true,
		sounds = {
			random = "mobs_sheep",
		},
		hp_min = 6,
		hp_max = 12,
		armor = 200,
		knock_back = 1,
		water_damage = 1,
		lava_damage = 7,
		fall_damage = 7,
		damage = 2,
		attack_type = "dogfight",
		view_range = 7,
		stepheight = 1.1,
		jump_chance = 5,
		drops = {
			{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
			--{name = "mobs:leather", chance = 1, min = 1, max = 2}
		},
		follow = "farming:wheat",
		replace_rate = 50,
		replace_what = {"group:flora"},
		replace_with = "air",
		on_rightclick = function(self, clicker)
			if  mobs:feed_tame(self, clicker, 10, true) then
				return
			end
			local tool = clicker:get_wielded_item()
			if tool:get_name() == "bucket:bucket_empty" then
				if self.gotten == true
				or self.child == true then
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

	local l_spawn_elevation_min = minetest.setting_get("water_level") + 1 or 1
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
