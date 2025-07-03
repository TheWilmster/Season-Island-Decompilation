image_alpha += fade_speed;
if (image_alpha == 1)
{
	fade_speed = -fade_speed;
	if (undefined != callback)
		callback(args);
	global.is_game_paused = false;
}
if (image_alpha <= 0 && fade_speed < 0)
	instance_destroy();

image_alpha = min(image_alpha, 1);