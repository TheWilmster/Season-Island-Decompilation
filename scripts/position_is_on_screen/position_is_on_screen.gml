function position_is_on_screen(x, y, width = 0, height = 0)
{
	var _x_camera = camera_get_view_x(view_camera[0]);
	var _y_camera = camera_get_view_y(view_camera[0]);
	return (x + width) >= _x_camera && x <= (_x_camera + 640) && (y + height) >= _y_camera && y <= (_y_camera + 360);
}
