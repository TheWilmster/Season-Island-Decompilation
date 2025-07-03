recently_destroyed_instances = [];
room_functions = {};
room_data = {};
persistent_objects = [
{
	object_index: obj_npc_springflower_group,
	variable_names: ["is_awake"]
}, 
{
	object_index: obj__clickable_object_interactive,
	variable_names: ["is_visible"]
}, 
{
	object_index: obj_newton_holding_knife,
	variable_names: ["is_fallen"]
}, 
{
	object_index: obj__cuttable_plant,
	variable_names: ["cut_counter"]
}, 
{
	object_index: obj__treehouse_pipe,
	variable_names: ["is_fixed"]
}, 
{
	object_index: obj_teahouse_door_area,
	variable_names: ["is_oiled"]
}, 
{
	object_index: obj_well_hook,
	variable_names: ["attached_item_id", "rope_length", "angle"]
}, 
{
	object_index: obj_well_handle,
	variable_names: ["rope_length", "angle", "x", "y"]
}, 
{
	object_index: obj__treehouse_cog,
	variable_names: ["is_spinning_automatically"]
}, 
{
	object_index: obj_treehouse_ladder_plank,
	variable_names: ["x", "y", "is_left_nail_placed", "is_right_nail_placed", "left_nail_value", "right_nail_value"]
}, 
{
	object_index: obj_treehouse_ladder_manager,
	variable_names: ["is_ladder_fixed"]
}, 
{
	object_index: obj_falling_apple,
	variable_names: ["looseness"]
}];

assign_instance_indexes = function(inst)
{
	var i = 0;
	with (inst)
		self.index = ++i;
};

find_instance_by_index = function(object, index)
{
	with (object)
	{
		if (self.index == index)
			return self;
	}
};

push_destroyed_instance = function(inst)
{
	array_push(recently_destroyed_instances, 
	{
		object_name: inst.object_index,
		index: inst.index
	});
};

function save_current_room()
{
	var current_room_data = {};
	var instance_data = [];
	for (var i = 0; i < array_length(persistent_objects); i++)
	{
		var persistent_instance = persistent_objects[i];
		with (persistent_instance.object_index)
		{
			var instance_struct = 
			{
				object_name: object_get_name(object_index),
				index: index
			};
			var variable_names = persistent_instance.variable_names;
			for (var j = 0; j < array_length(variable_names); j++)
			{
				var variable_name = variable_names[j];
				variable_struct_set(instance_struct, variable_name, variable_instance_get(self, variable_name));
			}
			array_push(instance_data, instance_struct);
		}
	}
	current_room_data.instance_data = instance_data;
	current_room_data.destroyed_instances = array_copy_deep(recently_destroyed_instances);
	variable_struct_set(room_data, room_get_name(room), current_room_data);
}

function load_current_room()
{
	var current_room_data = variable_struct_get(room_data, room_get_name(room));
	if (current_room_data == undefined)
		exit;
	var instance_data = current_room_data.instance_data;
	array_foreach(instance_data, function(inst)
	{
		var obj = asset_get_index(inst.object_name);
		if (!obj)
			exit;
		var instance = find_instance_by_index(obj, inst.index);
		if (!instance)
			exit;
		var instance_struct_copy = struct_copy_deep(inst);
		struct_remove(instance_struct_copy, "object_name");
		struct_remove(instance_struct_copy, "index");
		variables_instance_set(instance, instance_struct_copy);
	});
	array_foreach(struct_get_from_hash(current_room_data, variable_get_hash("destroyed_instances")), function(inst)
	{
		var obj = asset_get_index(inst.object_name);
		var index = inst.index;
		var instance = find_instance_by_index(obj, index);
		if (!instance)
		{
			show_debug_message(string("LOADING ROOM DATA: Could not destroy object {0} with index {1}: instance not found.", inst.object_name, index));
			exit;
		}
		instance_destroy(instance);
	});
	with (obj_npc_springflower_group)
	{
		if (is_awake)
		{
			sprite_index = spr_springflowers;
			image_speed = 1;
		}
	}
	with (obj_newton_holding_knife)
	{
		if (is_fallen)
		{
			set_sprite_fallen();
			state = state_fallen;
		}
	}
	with (obj__treehouse_pipe)
	{
		if (is_fixed)
			sprite_index = sprite_index_fixed;
	}
	with (obj__treehouse_cog)
	{
		if (is_spinning_automatically)
			state = state_spin_automatically;
	}
	with (obj_well_handle)
		image_angle = (angle * 180) / pi;
}

room_set_function = function(_room, _function)
{
	variable_struct_set(room_functions, room_get_name(_room), _function);
};

room_set_function(rm_cabin, function()
{
	obj_menu_main.set_visibility(false);
	switch (global.chapter)
	{
		case 1:
			create_textbox("game start");
			break;
		case 2:
			obj_data.load_chatterbox_chapter(Chapters.Spring);
			create_textbox("demo");
			obj_save_file_manager.save();
			break;
	}
});
room_set_function(rm_chapter_end, function()
{
	obj_save_file_manager.reset_chapter_data();
	global.chapter++;
	obj_save_file_manager.data.chapter = global.chapter;
	room_goto(rm_cabin);
});
room_set_function(rm_spring_2, function()
{
	with (obj_npc_buttermantis)
		set_visibility(event_flag_get(Event.EnterNewtonShop));
	if (!event_flag_get(Event.KillerScene))
	{
		if (global.inventory.contains_item(ItemType.Slingshot))
		{
			event_flag_set(Event.KillerScene);
			obj_spring_scared.set_visibility(true);
			obj_newton_holding_knife.set_visibility(true);
			obj_sound_manager.global_sound_play(snd_tornado_warning);
			global.inventory.item_rmv(ItemType.Slingshot);
			create_textbox("spring vs newton");
		}
		else
		{
			obj_spring_scared.set_visibility(false);
			obj_newton_holding_knife.set_visibility(false);
		}
	}
	if (event_flag_get(Event.MetSpring))
	{
		obj_newton_holding_knife.set_visibility(false);
		if (!event_flag_get(Event.MetNewton))
		{
			event_flag_set(Event.MetNewton);
			create_textbox("newton");
		}
	}
});
room_set_function(rm_spring, function()
{
	with (obj_npc_pompom)
		set_visibility(event_flag_get(Event.EnterTreehouseOutside));
	if (!event_flag_get(Event.MetSpring) && event_flag_get(Event.KillerDefeat))
	{
		event_flag_set(Event.MetSpring);
		create_textbox("spring");
	}
});
room_set_function(rm_treehouse_entrance, function()
{
	if (!event_flag_get(Event.EnterTreehouseOutside))
		event_flag_set(Event.EnterTreehouseOutside);
});
room_set_function(rm_treehouse, function()
{
	if (!event_flag_get(Event.EnterTreehouse))
	{
		event_flag_set(Event.EnterTreehouse);
		create_textbox("treehouse");
	}
});
room_set_function(rm_spring_newton_shop, function()
{
	if (!event_flag_get(Event.EnterNewtonShop))
	{
		event_flag_set(Event.EnterNewtonShop);
		obj_newton_in_shop.talk_immediate("newton enter shop");
	}
});
room_set_function(rm_teahouse, function()
{
	if (!event_flag_get(Event.EnterTeahouse))
	{
		event_flag_set(Event.EnterTeahouse);
		obj_spring_in_teahouse.talk_immediate("spring enter teahouse");
	}
});
