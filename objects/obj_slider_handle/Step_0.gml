if (is_being_clicked)
{
	x = clamp(obj_cursor.x - (sprite_width / 2), slider_instance.x, (slider_instance.x + slider_instance.sprite_width) - sprite_width);
	slider_instance.value_update(x);
}
