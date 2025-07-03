image_alpha += fade_speed;
if (image_alpha == 1)
{
	if (undefined != callback)
		callback(args);
	global.is_game_paused = false;
	instance_destroy();
}
