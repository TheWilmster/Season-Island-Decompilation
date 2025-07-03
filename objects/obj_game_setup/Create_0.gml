function setup_scribble_typists_events()
{
	scribble_typists_add_event("camshake", function(element, arguments, characterIndex)
	{
		var typed_parameter_array = array_map(arguments, function(element, index)
		{
			switch (index)
			{
				case 0:
				case 1:
				case 2:
					return real(element);
			}
		});
		script_execute_ext(camera_shake, typed_parameter_array);
	});
	scribble_typists_add_event("create_sprite", function(element, arguments, characterIndex)
	{
		var typed_parameter_array = array_map(arguments, function(element, index)
		{
			switch (index)
			{
				case 0:
					return asset_get_index(element);
				case 1:
					return real(element);
			}
		});
		var sprite = typed_parameter_array[0];
		if (sprite == asset_unknown)
			exit;
		script_execute_ext(obj_textbox.create_display_sprite, typed_parameter_array);
	});
	scribble_typists_add_event("create_sprite_item", function(element, arguments, characterIndex)
	{
		var typed_parameter_array = array_map(arguments, function(element, index)
		{
			switch (index)
			{
				case 0:
					return asset_get_index(element);
				case 1:
					return real(element);
			}
		});
		var sprite = typed_parameter_array[0];
		if (sprite == asset_unknown)
			exit;
		with (obj_textbox)
		{
			script_execute_ext(create_display_sprite, typed_parameter_array);
			frame_display_sprite(spr_gui_inventory_slot_selected, 0, 1);
		}
	});
	scribble_typists_add_event("create_sprite_art", function(element, arguments, characterIndex)
	{
		var typed_parameter_array = array_map(arguments, function(element, index)
		{
			switch (index)
			{
				case 0:
					return asset_get_index(element);
				case 1:
					return real(element);
			}
		});
		var sprite = typed_parameter_array[0];
		if (sprite == asset_unknown)
			exit;
		with (obj_textbox)
		{
			script_execute_ext(create_display_sprite, typed_parameter_array);
			frame_display_sprite(spr_frame_yellow, 0, 0);
		}
	});
	scribble_typists_add_event("destroy_sprite", function(element, arguments, characterIndex)
	{
		with (obj_textbox)
			destroy_display_sprite();
	});
	scribble_typists_add_event("emote", function(element, arguments, characterIndex)
	{
		with (obj_textbox)
			talksprite_emote(real(arguments[0]));
	});
	scribble_typists_add_event("continue", function(element, arguments, characterIndex)
	{
		with (obj_textbox)
			page_flip();
	});
	scribble_typists_add_event("music", function(element, arguments, characterIndex)
	{
		var typed_parameter_array = array_map(arguments, function(element, index)
		{
			switch (index)
			{
				case 0:
					return asset_get_index(element);
			}
		});
		if (typed_parameter_array[0] == asset_unknown)
			exit;
		obj_sound_manager.textbox_sound_play(typed_parameter_array[0]);
	});
	scribble_typists_add_event("music_fade_out", function(element, arguments, characterIndex)
	{
		obj_sound_manager.textbox_sound_fade_out();
	});
	scribble_typists_add_event("music_fade_in", function(element, arguments, characterIndex)
	{
		var typed_parameter_array = array_map(arguments, function(element, index)
		{
			switch (index)
			{
				case 0:
					return asset_get_index(element);
			}
		});
		var sound = typed_parameter_array[0];
		if (sound == asset_unknown)
			exit;
		obj_sound_manager.textbox_sound_fade_in(sound);
	});
	scribble_typists_add_event("sfx", function(element, arguments, characterIndex)
	{
		var typed_parameter_array = array_map(arguments, function(element, index)
		{
			switch (index)
			{
				case 0:
					return asset_get_index(element);
			}
		});
		var sound = typed_parameter_array[0];
		if (sound == asset_unknown)
			exit;
		audio_play_sound(sound, 1, false);
	});
	scribble_typists_add_event("music_pitch", function(element, arguments, characterIndex)
	{
		with (obj_sound_manager)
			audio_sound_pitch(current_textbox_sound, real(arguments[0]));
	});
	scribble_typists_add_event("spring_anime", function(element, arguments, characterIndex)
	{
		obj_talksprite_spring.anime_effect_create(real(arguments[0]));
	});
	scribble_typists_add_event("spring_anime_stop", function(element, arguments, characterIndex)
	{
		obj_talksprite_spring.anime_effect_destroy();
	});
}

function setup_chatterbox_functions()
{
	ChatterboxAddFunction("talkspriteFadeIn", function(actor_name, emotion = 0)
	{
		obj_textbox.talksprite_fade_in(actor_name, emotion);
	});
	ChatterboxAddFunction("talkspriteFadeOut", function()
	{
		obj_textbox.talksprite_fade_out();
	});
	ChatterboxAddFunction("visitedSelf", function()
	{
		var chatterbox_current = __ChatterboxSystem().__current;
		return ChatterboxGetVisited(ChatterboxGetCurrent(chatterbox_current), ChatterboxGetCurrentSource(chatterbox_current));
	});
	ChatterboxAddFunction("actorHide", function(actor_name)
	{
		with (obj_textbox)
			actor_hide_from_string(actor_name);
	});
	ChatterboxAddFunction("actorShow", function(actor_name)
	{
		with (obj_textbox)
			actor_show_from_string(actor_name);
	});
	ChatterboxAddFunction("getSummerSwitchNumber", function()
	{
		return instance_number(obj_summer_portal_switch);
	});
	ChatterboxAddFunction("bookCreate", function()
	{
		instance_create_depth(x, y, Depth.Menu, obj_book);
		camera_shake(4, 4, 0.5);
		obj_book.dust();
		audio_play_sound(snd_punch, 1, false);
	});
	ChatterboxAddFunction("roomMusicFadeIn", function()
	{
		with (obj_sound_manager)
		{
			if (global_sound != noone)
				global_sound_fade_in();
			else
				room_music_fade_in();
		}
	});
	ChatterboxAddFunction("roomMusicFadeOut", function()
	{
		with (obj_sound_manager)
		{
			if (global_sound != noone)
				global_sound_fade_out();
			else
				room_music_fade_out();
		}
	});
	ChatterboxAddFunction("roomMusicStop", function()
	{
		with (obj_sound_manager)
		{
			if (global_sound != noone)
				global_sound_stop();
			else
				room_music_stop();
		}
	});
	ChatterboxAddFunction("roomMusicPause", function()
	{
		with (obj_sound_manager)
		{
			if (global_sound != noone)
				global_sound_pause();
			else
				room_music_pause();
		}
	});
	ChatterboxAddFunction("roomMusicResume", function()
	{
		with (obj_sound_manager)
		{
			if (global_sound != noone)
				global_sound_resume();
			else
				room_music_resume();
		}
	});
	ChatterboxAddFunction("musicFadeIn", function(sound_name)
	{
		obj_sound_manager.textbox_sound_fade_in(asset_get_index(sound_name));
	});
	ChatterboxAddFunction("musicFadeOut", function()
	{
		obj_sound_manager.textbox_sound_fade_out();
	});
	ChatterboxAddFunction("music", function(sound_name)
	{
		obj_sound_manager.textbox_sound_play(asset_get_index(sound_name));
	});
	ChatterboxAddFunction("musicStop", function()
	{
		obj_sound_manager.textbox_sound_stop();
	});
	ChatterboxAddFunction("musicPitch", function(pitch)
	{
		with (obj_sound_manager)
			audio_sound_pitch(current_textbox_sound, pitch);
	});
	ChatterboxAddFunction("musicPause", function()
	{
		with (obj_sound_manager)
			audio_pause_sound(current_textbox_sound);
	});
	ChatterboxAddFunction("musicResume", function()
	{
		with (obj_sound_manager)
			audio_resume_sound(current_textbox_sound);
	});
	ChatterboxAddFunction("delay", function(_time)
	{
		obj_textbox.delay(_time);
	});
	ChatterboxAddFunction("delaySeconds", function(_seconds)
	{
		obj_textbox.delay(_seconds * 60);
	});
	ChatterboxAddFunction("getCurrentTimeFormatted", function()
	{
		var str = "";
		if (current_hour < 10)
			str += "0";
		str += (string(current_hour) + ":");
		if (current_minute < 10)
			str += "0";
		str += (string(current_minute) + ":");
		if (current_second < 10)
			str += "0";
		str += string(current_second);
		return str;
	});
	ChatterboxAddFunction("getCurrentTimeFormattedSimplified", function()
	{
		var str = "";
		str += (string(current_hour % 12) + ":");
		if (current_minute < 10)
			str += "0";
		str += (string(current_minute) + " ");
		str += ((current_hour < 12) ? "AM" : "PM");
		return str;
	});
	ChatterboxAddFunction("talkspriteCreate", function(actor_name, emotion = 0)
	{
		obj_textbox.talksprite_create(actor_name, emotion);
	});
	ChatterboxAddFunction("talkspriteDestroy", function()
	{
		obj_textbox.talksprite_destroy();
	});
	ChatterboxAddFunction("showStory", function()
	{
		room_goto(obj_data.chapters[global.chapter].spawn_room);
		obj_fade_manual.image_alpha_spd = 0.0015;
		obj_fade_manual.fade_out();
	});
	ChatterboxAddFunction("newtonAdvertise", function(ad_type, _title, _subtitle)
	{
		obj_talksprite_newton.advertise(ad_type, _title, _subtitle);
	});
	ChatterboxAddFunction("newtonAdvertiseStop", function()
	{
		obj_talksprite_newton.advertise_stop();
	});
	ChatterboxAddFunction("eraseSaveFile", function()
	{
		obj_save_file_manager.erase();
		instance_destroy(obj_clickable_button_erase_savefile);
		audio_play_sound(snd_cut, 1, false);
	});
	ChatterboxAddFunction("springDateStart", function()
	{
		event_flag_set(Event.SpringDateStart);
		instance_destroy(obj_spring_in_teahouse);
		if (global.inventory.contains_item(ItemType.LoveLetter))
			global.inventory.item_rmv(ItemType.LoveLetter);
		else if (global.inventory.contains_item(ItemType.LoveLetterWet))
			global.inventory.item_rmv(ItemType.LoveLetterWet);
		instance_create_depth(0, 0, Depth.Particle, obj_spring_date_manager);
	});
	ChatterboxAddFunction("springDateStop", function()
	{
		obj_spring_date_manager.stop_date();
	});
	ChatterboxAddFunction("springDateFillMeter", function(amt)
	{
		obj_spring_date_manager.fill_meter(amt);
	});
	ChatterboxAddFunction("springDateGetScore", function()
	{
		return obj_save_file_manager.data.spring_date_score;
	});
	ChatterboxAddFunction("emote", function(emotion)
	{
		with (obj_textbox)
			talksprite_emote(real(emotion));
	});
	ChatterboxAddFunction("springAnime", function(effect)
	{
		with (obj_talksprite_spring)
			anime_effect_create(effect);
	});
	ChatterboxAddFunction("springAnimeStop", function()
	{
		with (obj_talksprite_spring)
			anime_effect_destroy();
	});
	ChatterboxAddFunction("showSlingshot", function()
	{
		obj_slingshot.set_visibility(true);
	});
}

function setup_chatterbox_constants()
{
	ChatterboxVariableSetConstant("shootingRangeMinigameWinScoreValue", 10);
	ChatterboxVariableSetConstant("shootingRangeMinigameNonFirstWinReward", 0.25);
	ChatterboxVariableSetConstant("springDateGoodScore", 100);
	ChatterboxVariableSetConstant("springDateBadScore", 0);
}

setup_scribble_typists_events();
setup_chatterbox_functions();
setup_chatterbox_constants();
ChatterboxLoadFromFile("dialogue_files/english/global.yarn", "global");
