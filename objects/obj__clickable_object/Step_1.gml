if (is_being_clicked && !mouse_check_button(mb_left))
{
	if (cursor_meeting(obj_cursor.x, obj_cursor.y))
		on_click();
	is_being_clicked = false;
	on_mouse_released();
}
