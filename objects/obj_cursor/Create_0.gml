draw_tooltip = function(text)
{
	if (text == "")
		exit;
	var tooltip_width = text_formatter.text_width_ext(text, tooltip_width_max);
	var tooltip_height = text_formatter.text_height_ext(text, tooltip_width_max);
	var tooltip_x = (x < 320) ? ((x + sprite_width) - 2) : (x - tooltip_width - 12);
	var tooltip_y = (y > 180) ? (y - tooltip_height) : y;
	draw_nineslice_around(spr_gui_cursor_tooltip, 0, tooltip_x - box_margin, tooltip_y - box_margin, tooltip_x + tooltip_width + box_margin, tooltip_y + tooltip_height + box_margin, 0, c_white, tooltip_alpha);
	text_formatter.get_formatted_text(text).wrap(tooltip_width_max).draw(tooltip_x + tooltip_offset_x, tooltip_y);
};

text_formatter = new TextFormatter(font_get_name(fnt_pixel_operator_8), c_white, 0, 0);
tooltip_offset_x = 2;
tooltip_width_max = 640;
box_margin = 2;
tooltip_alpha = 0.8;
sprite_arrow = spr_cursor_arrow;
sprite_hand = spr_cursor_hand;

get_nearest_clickable_object_at_cursor_position = function()
{
	var nearest = undefined;
	var cursor_x = x;
	var cursor_y = y;
	with (obj__clickable_object)
	{
		if (cursor_meeting(cursor_x, cursor_y) && is_visible)
		{
			if (nearest)
			{
				if (depth <= nearest.depth)
					nearest = self;
			}
			else
			{
				nearest = self;
			}
		}
	}
	return nearest;
};

previous_x = x;
previous_y = y;

get_dx = function()
{
	return x - previous_x;
};

get_dy = function()
{
	return y - previous_y;
};

draw = function()
{
	if (global.can_click)
	{
		var clickable_object = get_nearest_clickable_object_at_cursor_position();
		if (instance_exists(clickable_object) && clickable_object.can_be_clicked())
		{
			draw_tooltip(clickable_object.get_cursor_tooltip());
			draw_sprite(sprite_hand, 0, x, y);
			if (mouse_check_button_pressed(mb_left) && clickable_object.can_cursor_click())
			{
				clickable_object.is_being_clicked = true;
				clickable_object.on_mouse_pressed();
			}
		}
		else
		{
			draw_sprite(sprite_arrow, 0, x, y);
		}
	}
	else
	{
		draw_sprite(sprite_arrow, 0, x, y);
	}
};

depth = Depth.Cursor;
