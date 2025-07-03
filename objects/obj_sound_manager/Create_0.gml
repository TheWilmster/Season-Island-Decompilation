room_music_play = function()
{
	var rm = obj_data.get_room(room);
	if (!rm)
	{
		audio_group_stop_all(audiogroup_music);
		current_sound_type = -1;
		exit;
	}
	var sound_type = struct_get_from_hash(rm, variable_get_hash("sound_type"));
	if (sound_type == undefined)
	{
		audio_group_stop_all(audiogroup_music);
		current_sound_type = -1;
		exit;
	}
	switch (sound_type)
	{
		case SoundType.Multiple:
			if (current_sound_type == SoundType.Single && current_sound)
			{
				audio_stop_sound(current_sound);
				current_sound = noone;
			}
			var season_id = rm.season;
			var season = obj_data.seasons[rm.season];
			var sound_channels = season.sound_channels;
			var first_time_playing_sound = array_length(current_sound_channels) == 0;
			current_sound_channels = sound_channels;
			if (!audio_is_playing(sound_channels[0]))
			{
				array_foreach(sound_channels, function(_sound)
				{
					audio_play_sound(_sound, 1, true);
					audio_sound_gain(_sound, 0, 0);
				});
			}
			var sound_channel_volumes = rm.sound_channel_volumes;
			current_sound_channel_volumes = array_copy_deep(sound_channel_volumes);
			array_foreach(sound_channel_volumes, method(
			{
				sound_channels: sound_channels,
				first_time_playing_sound: first_time_playing_sound
			}, function(volume, channel)
			{
				audio_sound_gain(sound_channels[channel], volume, first_time_playing_sound ? 0 : 1000);
			}));
			break;
		case SoundType.Single:
			if (current_sound_type == SoundType.Multiple)
			{
				array_foreach(current_sound_channels, function(sound)
				{
					audio_stop_sound(sound);
				});
				current_sound_channels = [];
				current_sound_channel_volumes = [];
			}
			if (!struct_exists(rm, "sound"))
			{
				if (current_sound)
				{
					audio_stop_sound(current_sound);
					current_sound = noone;
				}
				break;
			}
			if (rm.sound != current_sound)
			{
				audio_stop_sound(current_sound);
				audio_play_sound(rm.sound, 1, true);
				current_sound = rm.sound;
			}
			break;
	}
	current_sound_type = sound_type;
};

global_sound_play = function(sound)
{
	audio_group_stop_all(audiogroup_music);
	audio_play_sound(sound, 1, true);
	global_sound = sound;
};

global_sound_stop = function()
{
	audio_stop_sound(global_sound);
	global_sound = noone;
	room_music_play();
};

global_sound_pause = function()
{
	audio_pause_sound(global_sound);
};

global_sound_resume = function()
{
	audio_resume_sound(global_sound);
};

global_sound_fade_in = function(time)
{
	audio_sound_gain(global_sound, 1, time);
};

global_sound_fade_out = function(time)
{
	audio_sound_gain(global_sound, 0, time);
};

room_music_pause = function()
{
	switch (current_sound_type)
	{
		case SoundType.Multiple:
			array_foreach(current_sound_channels, function(sound)
			{
				audio_pause_sound(sound);
			});
			break;
		case SoundType.Single:
			audio_pause_sound(current_sound);
			break;
	}
};

room_music_resume = function()
{
	switch (current_sound_type)
	{
		case SoundType.Multiple:
			array_foreach(current_sound_channels, function(sound)
			{
				audio_resume_sound(sound);
			});
			break;
		case SoundType.Single:
			audio_resume_sound(current_sound);
			break;
	}
};

room_music_fade_in = function(time = 1000)
{
	switch (current_sound_type)
	{
		case SoundType.Multiple:
			array_foreach(current_sound_channels, method(
			{
				current_sound_channel_volumes: current_sound_channel_volumes,
				fade_time: time
			}, function(sound, volume_index)
			{
				audio_sound_gain(sound, current_sound_channel_volumes[volume_index], fade_time);
			}));
			break;
		case SoundType.Single:
			audio_sound_gain(current_sound, 1, time);
			break;
	}
};

room_music_fade_out = function(time = 1000)
{
	switch (current_sound_type)
	{
		case SoundType.Multiple:
			array_foreach(current_sound_channels, method(
			{
				fade_time: time
			}, function(sound)
			{
				audio_sound_gain(sound, 0, fade_time);
			}));
			break;
		case SoundType.Single:
			audio_sound_gain(current_sound, 0, time);
			break;
	}
};

room_music_stop = function()
{
	switch (current_sound_type)
	{
		case SoundType.Multiple:
			array_foreach(current_sound_channels, function(time)
			{
				audio_stop_sound(time);
			});
			current_sound_channels = [];
			break;
		case SoundType.Single:
			audio_stop_sound(current_sound);
			current_sound = noone;
			break;
	}
	current_sound_type = -1;
};

textbox_sound_play = function(sound)
{
	audio_sound_pitch(sound, 1);
	if (current_textbox_sound != noone)
	{
		alarm_set(0, -1);
		textbox_sound_stop();
	}
	current_textbox_sound = sound;
	audio_play_sound(sound, 1, true);
};

textbox_sound_fade_out = function()
{
	alarm_set(0, 60);
	audio_sound_gain(current_textbox_sound, 0, 1000);
};

textbox_sound_stop = function()
{
	audio_stop_sound(current_textbox_sound);
	audio_sound_gain(current_textbox_sound, 1, 0);
	current_textbox_sound = noone;
};

textbox_sound_fade_in = function(sound)
{
	audio_play_sound(sound, 1, true);
	audio_sound_gain(sound, 0, 0);
	audio_sound_gain(sound, 1, 1000);
	current_textbox_sound = sound;
};

on_room_start = function()
{
	if (current_textbox_sound != noone)
		textbox_sound_stop();
	if (!global_sound)
	{
		if (audio_group_is_loaded(audiogroup_music))
			room_music_play();
		else
			alarm_set(1, 1);
	}
};
