function is_below_view()
{
	return y > (camera_get_view_y(view_camera[0]) + 360 + sprite_height);
}
