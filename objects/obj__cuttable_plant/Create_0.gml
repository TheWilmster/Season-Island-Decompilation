event_inherited();
cut_counter = 0;
action_fully_cut = virtual_method;

cut = function()
{
	if (cut_counter == 0)
		exit;
	var particle_number = 3;
	audio_play_sound(snd_cut, 1, false);
	cut_counter--;
	if (cut_counter == 0)
	{
		particle_number = 6;
		action_fully_cut();
	}
	create_falling_sprites_shatter(cut_particle_sprite_index, x + (sprite_width / 2), y + (sprite_height / 2), depth - 2, particle_number);
};

is_cut = function()
{
	return cut_counter == 0;
};
