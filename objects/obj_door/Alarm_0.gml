audio_play_sound(snd_enter_level, 1, false);
camera_x_speed = 4;
fade_dark(function()
{
	obj_sound_manager.room_music_stop();
	game_begin();
});
