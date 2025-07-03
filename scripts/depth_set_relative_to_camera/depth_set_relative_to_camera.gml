function depth_set_relative_to_camera()
{
	if (position_is_off_screen(x, y, sprite_width, sprite_height))
		exit;
	depth = obj_camera.y - y - sprite_height;
}
