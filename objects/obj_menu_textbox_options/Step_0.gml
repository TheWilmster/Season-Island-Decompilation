var vertical_selected_option_index = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
if (vertical_selected_option_index != 0)
{
	sfx_play((vertical_selected_option_index < 0) ? snd_button_released : snd_button_pressed);
	if (selected_option_index < 0)
	{
		if (vertical_selected_option_index > 0)
			selected_option_index = array_length(options) - 1;
		else
			selected_option_index = 0;
	}
	else if (array_length(options) > 1)
	{
		deselect_current_option();
		selected_option_index += vertical_selected_option_index;
	}
	if (selected_option_index < 0)
		selected_option_index += array_length(options);
	selected_option_index %= array_length(options);
	select_current_option();
}
if (keyboard_check_pressed(vk_left))
{
	sfx_play(snd_button_released);
	if (selected_option_index > -1)
		deselect_current_option();
	selected_option_index = 0;
	select_current_option();
}
if (keyboard_check_pressed(vk_right))
{
	sfx_play(snd_button_pressed);
	if (selected_option_index > -1)
		deselect_current_option();
	selected_option_index = array_length(options) - 1;
	select_current_option();
}
if ((keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) && selected_option_index > -1)
	options[selected_option_index].on_click();
