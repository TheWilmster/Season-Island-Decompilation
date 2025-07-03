loosen_apple = function()
{
	can_loosen_apple = false;
	create_mover_shake(2, 2, 0.3, obj_falling_apple);
	var added_looseness = 0.5 * sqrt(sqr(xspeed) + sqr(yspeed));
	obj_falling_apple.add_looseness(added_looseness);
	audio_play_sound(snd_punch, 1, false);
};

if (place_meeting(x, y, obj_falling_apple))
{
	instance_destroy();
	create_falling_sprite(sprite_index, image_index, x, y, depth, irandom_range(-2, 2), 0, weight, 1, 1, -30);
	audio_play_sound(snd_spike_grunt, 1, false);
}
can_loosen_apple = true;
