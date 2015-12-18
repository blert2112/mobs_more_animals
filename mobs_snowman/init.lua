
if mobs.mod and mobs.mod == "redo" then

-- snowman
	mobs:register_mob("mobs_snowman:snowman", {
		type = "animal",
		visual = "mesh",
		mesh = "snowman.b3d",
		textures = {
			{"default_coal_block.png", "default_coal_block.png", "snowman.png", "wool_orange.png"}
		},
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
		animation = {
			speed_normal = 24,	speed_run = 24,
			stand_start = 41,	stand_end = 90,
			walk_start = 1,		walk_end = 40,
			run_start = 1,		run_end = 40
		},
		makes_footstep_sound = true,
		hp_min = 3,
		hp_max = 5,
		armor = 200,
		knock_back = 1,
		water_damage = 5,
		lava_damage = 5,
		fall_damage = 5,
		passive = true,
		view_range = 10,
		walk_velocity = 0.5,
		run_velocity = 0.5,
		stepheight = 0.6,
		jump = false,
		drops = {
			{name = "default:snow", chance = 1, min = 5, max = 15}
		},
		replace_rate = 50,
		replace_what = {"air"},
		replace_with = "default:snow"
	})

minetest.register_node("mobs_snowman:tophat", {
	description = "Top Hat",
	tiles = {"default_coal_block.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {		
				{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25},
				{-0.125, -0.4375, -0.125, 0.125, -0.0625, 0.125}
			}
	},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local p = pos
		for i = 1,3 do
			p.y = p.y - 1
			local name = minetest.get_node(p).name
			if name ~= "default:snowblock" then
				return true
			end
		end
		for i = 1,4 do
			minetest.remove_node(p)
			p.y = p.y + 1			
		end
		p.y = p.y - 4
		minetest.add_entity(p, "mobs_snowman:snowman")
		return true
	end
})
 
minetest.register_craft({
	output = 'mobs_snowman:tophat',
	recipe = {
		{'', 'wool:black', ''},
		{'', 'wool:black', ''},
		{'wool:black', 'wool:black', 'wool:black'},
	}
})

end
