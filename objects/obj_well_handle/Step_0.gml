if (is_being_clicked)
{
	x = obj_cursor.x;
	y = obj_cursor.y;
	rope_length = get_rope_length();
	var angle_to_cursor = 1.5707963267948966 + arctan2(-y + init_y, x - init_x);
	x = init_x + (rope_length * sin(angle_to_cursor));
	y = init_y + (rope_length * cos(angle_to_cursor));
	var rope_length_difference = rope_length_previous - rope_length;
	obj_well_hook.rope_length += rope_length_difference;
	obj_well_stick.change_rope_image_index(rope_length_difference * rope_animation_speed);
	angle = 1.5707963267948966 + arctan2(-y + init_y, x - init_x);
	image_angle = (angle * 180) / pi;
}
