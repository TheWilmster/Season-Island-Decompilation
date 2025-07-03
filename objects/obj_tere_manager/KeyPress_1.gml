if (is_password_entered)
	exit;
if (keyboard_check_pressed(ord(string_char_at_index(password, current_password_character_index))))
{
	current_password_character_index++;
	if (current_password_character_index == string_length(password))
	{
		is_password_entered = true;
		instance_create_depth(-30, 180, Depth.Particle, obj_tere_body);
	}
}
else
{
	current_password_character_index = 0;
}
