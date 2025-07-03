default_data = 
{
	checkpoint_room_name: "",
	inventory_items: [],
	inventory_selected_slot: -1,
	timer: 0,
	chapter: Chapters.Spring,
	event_flags: [],
	room_data: {},
	settings: 
	{
		music_volume: 1,
		sfx_volume: 1
	},
	chatterbox_variables: "",
	global_sound_name: "",
	spring_date_score: 0
};
data = struct_copy_deep(default_data);

function reset_data()
{
	data = struct_copy_deep(default_data);
}

function file_get_data(fname)
{
	return json_file_get_struct(fname, true);
}

function load_data_from_file(fname)
{
	var save_data = file_get_data(fname);
	if (!save_data)
	{
		show_debug_message("load_data_from_file: Could not load file \"" + fname + "\"");
		exit;
	}
	data_override_safe(data, save_data);
	show_debug_message("Loaded data:");
	print_data();
	show_debug_message("end of loaded data.");
}

function data_override_safe(struct1, struct2)
{
	var _keys = struct_get_names(struct2);
	for (var _i = 0; _i < array_length(_keys); _i++)
	{
		var _key = _keys[_i];
		if ("inventory" == _key)
			variable_struct_set(struct1, _key, variable_struct_get(struct2, _key));
		else if ("room_data" == _key)
			variable_struct_set(struct1, _key, variable_struct_get(struct2, _key));
		else if (is_struct(variable_struct_get(struct2, _key)))
			data_override_safe(variable_struct_get(struct1, _key), variable_struct_get(struct2, _key));
		else if (struct_exists(struct1, _key))
			variable_struct_set(struct1, _key, variable_struct_get(struct2, _key));
	}
}

function save_data_to_file(fname)
{
	var _json = json_stringify(data);
	var _file = file_text_open_write(fname);
	file_text_write_string(_file, base64_encode(_json));
	file_text_close(_file);
	timer_set();
	create_popup("Game saved!");
	show_debug_message("Saved data:");
	print_data();
	show_debug_message("end of saved data.");
}

function settings_save_to_file(fname)
{
	if (file_exists(fname))
	{
		var _file = file_text_open_read(fname);
		var _contents = file_text_read_string(_file);
		file_text_close(_file);
		if (_contents != "")
		{
			var _json = base64_decode(_contents);
			var _struct = json_parse(_json);
			_struct.settings = data.settings;
			_json = json_stringify(_struct);
			_file = file_text_open_write(fname);
			file_text_write_string(_file, base64_encode(_json));
			file_text_close(_file);
		}
	}
	else
	{
		show_debug_message("settings_save_to_file: file \"" + fname + "\" does not exist.");
	}
}

function timer_set()
{
	time = current_time;
}

function timer_save()
{
	data.timer += (current_time - time) * 1000;
}

function is_empty(fname)
{
	var _file = file_text_open_read(fname);
	if (_file == -1)
		return true;
	var _contents = file_text_read_string(_file);
	file_text_close(_file);
	if (_contents == "")
		return true;
	return false;
}

function override(fname1, fname2)
{
	if (!file_exists(fname2))
	{
		show_debug_message("Couldn't open file \"" + fname2 + "\". File not found.");
		exit;
	}
	if (!file_exists(fname1))
	{
		show_debug_message("Couldn't open file \"" + fname1 + "\". File not found.");
		exit;
	}
	var _file_new_data = file_text_open_read(fname1);
	var _new_file_contents = file_text_read_string(_file_new_data);
	file_text_close(_file_new_data);
	var _file = file_text_open_write(fname2);
	file_text_write_string(_file, _new_file_contents);
	file_text_close(_file);
}

function erase_file(fname)
{
	file_delete("save");
	create_popup("File data erased");
}

function load()
{
	load_data_from_file("save");
	if (data.global_sound_name != "")
	{
		var global_sound = asset_get_index(data.global_sound_name);
		if (global_sound)
			obj_sound_manager.global_sound_play(global_sound);
	}
    
	array_foreach(data.inventory_items, function(item, index)
	{
		global.inventory.items[index] = item;
	});
    
	global.inventory.select_item_at_index(data.inventory_selected_slot);
    
	array_foreach(data.event_flags, function(is_flagged, event)
	{
		if (is_flagged)
			event_flag_set(event);
	});
    
	obj_room_data_manager.room_data = data.room_data;
    
	var rm = asset_get_index(data.checkpoint_room_name);
	if (rm)
		room_goto(rm);
	else
		room_goto(rm_cabin);
    
	obj_room_data_manager.load_current_room();
    
	global.chapter = data.chapter;
	try
	{
		obj_data.load_chatterbox_chapter(global.chapter);
	}
	catch (error)
	{
		show_debug_message(error.message);
	}
    
	if (data.chatterbox_variables != "")
		ChatterboxVariablesImport(data.chatterbox_variables);
    
	audio_group_set_gain(audiogroup_music, data.settings.music_volume, 0);
	audio_group_set_gain(audiogroup_sfx, data.settings.sfx_volume, 0);
}

function save()
{
	timer_save();
	var global_sound = obj_sound_manager.global_sound;
	data.global_sound_name = global_sound ? audio_get_name(global_sound) : "";
	data.checkpoint_room_name = room_get_name(room);
	data.inventory_items = global.inventory.items;
	data.inventory_selected_slot = global.inventory.selected_slot;
	data.event_flags = global.event_flags;
	obj_room_data_manager.save_current_room();
	data.room_data = obj_room_data_manager.room_data;
	data.chatterbox_variables = ChatterboxVariablesExport();
	data.chapter = global.chapter;
	data.settings.music_volume = audio_group_get_gain(audiogroup_music);
	data.settings.sfx_volume = audio_group_get_gain(audiogroup_sfx);
	save_data_to_file("save");
}

function erase()
{
	erase_file("save");
}

settings_save = function()
{
	data.settings.music_volume = audio_group_get_gain(audiogroup_music);
	data.settings.sfx_volume = audio_group_get_gain(audiogroup_sfx);
	settings_save_to_file("save");
};

save_file_exists = function()
{
	return file_exists("save");
};

reset_data_field = function(key)
{
	variable_struct_set(data, key, variable_struct_get(default_data, key));
};

reset_chapter_data = function()
{
	reset_data_field("checkpoint_room_name");
	reset_data_field("inventory_items");
	global.inventory.items = data.inventory_items;
	reset_data_field("inventory_selected_slot");
	global.inventory.selected_slot = data.inventory_selected_slot;
	reset_data_field("event_flags");
	global.event_flags = data.event_flags;
	reset_data_field("room_data");
	obj_room_data_manager.room_data = data.room_data;
	reset_data_field("chatterbox_variables");
	ChatterboxVariablesResetAll();
	obj_data.unload_chatterbox_chapter();
	reset_data_field("global_sound_name");
	obj_sound_manager.global_sound = noone;
};

print_data = function()
{
	show_debug_message(data);
	show_debug_message(string("timer = {0}", time_format_string(data.timer)));
};
