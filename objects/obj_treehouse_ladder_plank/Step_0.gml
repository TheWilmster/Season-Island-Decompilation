if (is_being_dragged)
{
	var cursor_dx = obj_cursor.get_dx();
	var cursor_dy = obj_cursor.get_dy();
	x += cursor_dx;
	y += cursor_dy;
	if (x < 0 || (x + sprite_width) > 640)
		x -= cursor_dx;
	if (y < (obj_menu_main.y + obj_menu_main.sprite_height) || (y + sprite_height) > 360)
		y -= cursor_dy;
}
