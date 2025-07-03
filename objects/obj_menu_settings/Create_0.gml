event_inherited();
button_spacing = 16;
var cursor_y = 180;
slider_music_volume = instance_create_depth(x, cursor_y, Depth.ButtonUI, obj_slider_music_volume);
array_push(child_nodes, slider_music_volume);
cursor_y += (button_spacing + slider_music_volume.get_height());
slider_sfx_volume = instance_create_depth(x, cursor_y, Depth.ButtonUI, obj_slider_sfx_volume);
array_push(child_nodes, slider_sfx_volume);
cursor_y += (button_spacing + slider_sfx_volume.get_height());
button_save_game = instance_create_depth(x, cursor_y, Depth.ButtonUI, obj_clickable_button_save_game);
array_push(child_nodes, button_save_game);
cursor_y += (button_spacing + button_save_game.get_height());
button_close_menu = instance_create_depth(x, cursor_y, Depth.ButtonUI, obj_clickable_button_close_menu);
array_push(child_nodes, button_close_menu);
cursor_y += (button_spacing + button_close_menu.get_height());

get_width = function()
{
	return slider_music_volume.get_width();
};

get_height = function()
{
	var sum = 0;
	for (var i = 0; i < array_length(child_nodes); i++)
		sum += child_nodes[i].get_height();
	sum += ((array_length(child_nodes) - 1) * button_spacing);
	return sum;
};

for (var i = 0; i < array_length(child_nodes); i++)
{
	var child_node = child_nodes[i];
	child_node.x = 320 - (child_node.get_width() / 2);
	child_node.y -= get_height() / 2;
}
slider_music_volume.fix_handle_position();
slider_sfx_volume.fix_handle_position();
