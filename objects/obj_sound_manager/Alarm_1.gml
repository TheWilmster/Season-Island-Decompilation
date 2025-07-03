if (audio_group_is_loaded(audiogroup_music))
	room_music_play();
else
	alarm_set(1, 1);
