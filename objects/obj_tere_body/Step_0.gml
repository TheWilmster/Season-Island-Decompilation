if (do_follow_mouse)
{
	x = obj_cursor.x + mouse_follow_offset_x;
	y = obj_cursor.y + mouse_follow_offset_y;
}
else if (state)
{
	state();
}
