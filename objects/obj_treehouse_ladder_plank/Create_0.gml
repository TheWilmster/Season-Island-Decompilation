event_inherited();
is_left_nail_placed = false;
is_right_nail_placed = false;
left_nail_value = 0;
right_nail_value = 0;
is_being_dragged = false;
left_nail_relative_x = 10;
left_nail_relative_y = 8;
right_nail_relative_x = sprite_width - 10;
right_nail_relative_y = 12;
nail_detection_radius = 12;
nail_value_max = 3;

get_nail_sprite = function(index)
{
	switch (index)
	{
		case 0:
			return spr_treehouse_ladder_plank_nail_not_hit;
		case 1:
			return spr_treehouse_ladder_plank_nail;
		case 2:
			return spr_treehouse_ladder_plank_nail_2;
		case 3:
			return spr_treehouse_ladder_plank_nail_3;
	}
	return -1;
};

draw_nail = function(x, y, index)
{
	var sprite = get_nail_sprite(index ? right_nail_value : left_nail_value);
	draw_sprite(sprite, 0, x - (sprite_get_width(sprite) / 2), y - sprite_get_height(sprite));
};

draw_nails = function()
{
	if (is_left_nail_placed)
		draw_nail(x + left_nail_relative_x, y + left_nail_relative_y, false);
	if (is_right_nail_placed)
		draw_nail(x + right_nail_relative_x, y + right_nail_relative_y, true);
};

draw = function()
{
	draw_self();
	draw_nails();
	if (is_being_dragged)
		draw_sprite(spr_arrows_4_directions, 0, x + (sprite_width / 2), y + (sprite_height / 2));
};

hit_nail = function(is_right)
{
	camera_shake();
	sfx_play(snd_button_released);
	if (is_right)
		right_nail_value++;
	else
		left_nail_value++;
	obj_treehouse_ladder_manager.check_if_ladder_is_fixed();
};

is_partially_attached = function()
{
	if (is_left_nail_placed && left_nail_value > 0)
		return true;
	if (is_right_nail_placed && right_nail_value > 0)
		return true;
	return false;
};

is_attached = function()
{
	return (is_left_nail_placed && left_nail_value == nail_value_max) && (is_right_nail_placed && right_nail_value == nail_value_max);
};

is_in_ladder_area = function()
{
	return position_meeting(x, y, obj_treehouse_ladder_area) && position_meeting(x, y + sprite_height, obj_treehouse_ladder_area) && position_meeting(x + sprite_width, y, obj_treehouse_ladder_area) && position_meeting(x + sprite_width, y + sprite_height, obj_treehouse_ladder_area);
};

can_be_attached_at_current_position = function()
{
	return is_in_ladder_area() && !place_meeting(x, y, obj_treehouse_ladder_plank);
};

is_cursor_near_left_nail_position = function()
{
	return distance_2_points(obj_cursor.x, obj_cursor.y, x + left_nail_relative_x, y + left_nail_relative_y) < nail_detection_radius;
};

is_cursor_near_right_nail_position = function()
{
	return distance_2_points(obj_cursor.x, obj_cursor.y, x + right_nail_relative_x, y + right_nail_relative_y) < nail_detection_radius;
};

on_mouse_pressed = function()
{
	if (is_attached())
		exit;
	switch (global.inventory.get_selected_item())
	{
		case ItemType.Nails:
			if (!can_be_attached_at_current_position())
				break;
			if (!is_left_nail_placed && is_cursor_near_left_nail_position())
				is_left_nail_placed = true;
			else if (!is_right_nail_placed && is_cursor_near_right_nail_position())
				is_right_nail_placed = true;
			break;
		case ItemType.Hammer:
			if (!can_be_attached_at_current_position())
				break;
			if (is_left_nail_placed && left_nail_value < nail_value_max && is_cursor_near_left_nail_position())
				hit_nail(false);
			else if (is_right_nail_placed && right_nail_value < nail_value_max && is_cursor_near_right_nail_position())
				hit_nail(true);
			break;
		case ItemType.None:
			if (!is_partially_attached())
				is_being_dragged = true;
			break;
	}
};

on_mouse_released = function()
{
	if (is_attached())
		exit;
	if (global.inventory.get_selected_item() == ItemType.None)
		is_being_dragged = false;
};

get_cursor_tooltip = function()
{
	if (!can_be_attached_at_current_position())
		return "";
	var selected_item = global.inventory.get_selected_item();
	if (selected_item == ItemType.None)
		return "";
	if (is_cursor_near_left_nail_position() || is_cursor_near_right_nail_position())
		return string("[{0}]", obj_data.get_item_sprite_name(selected_item));
	return "";
};
