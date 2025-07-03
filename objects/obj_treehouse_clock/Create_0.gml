event_inherited();
name = "Clock";

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.Hammer:
			global.inventory.item_add(ItemType.SmallCogs);
			obj_treehouse_wall_markings.set_visibility(false);
			camera_shake();
			sfx_play(snd_punch);
			create_falling_sprites_shatter(spr_item_small_cogs, x + (sprite_width / 2), y + (sprite_height / 2), Depth.Particle, 5);
			instance_destroy();
			break;
		case ItemType.LegendaryShears:
			create_textbox("treehouse clock topiary shears legendary");
			break;
		case ItemType.LoveLetter:
			create_textbox("treehouse clock newton love letter");
			break;
		case ItemType.LoveLetterWet:
			create_textbox("treehouse clock newton love letter wet");
			break;
	}
};

on_click_without_item = function()
{
	create_textbox("treehouse clock");
};

center_offset_x = 47;
center_offset_y = 47;
clock_hands_x = x + center_offset_x;
clock_hands_y = y + center_offset_y;
clock_radius = 20;
clock_hand_max_length = clock_radius - 1;
clock_hand_seconds_length = clock_hand_max_length;
clock_hand_minutes_length = clock_hand_max_length - 2;
clock_hand_hours_length = clock_hand_max_length - 5;
clock_hand_seconds_w = 1;
clock_hand_minutes_w = 2;
clock_hand_hours_w = 3;
clock_hand_color = 0;

draw_clock_hands = function()
{
	var seconds_angle = (((2 * pi) * current_second) / 60) - (90 * RAD);
	draw_line_width_color(clock_hands_x, clock_hands_y, clock_hands_x + (cos(seconds_angle) * clock_hand_seconds_length), clock_hands_y + (sin(seconds_angle) * clock_hand_seconds_length), clock_hand_seconds_w, clock_hand_color, clock_hand_color);
	var minutes_angle = (((2 * pi) * (current_minute + (current_second / 60))) / 60) - (90 * RAD);
	draw_line_width_color(clock_hands_x, clock_hands_y, clock_hands_x + (cos(minutes_angle) * clock_hand_minutes_length), clock_hands_y + (sin(minutes_angle) * clock_hand_minutes_length), clock_hand_minutes_w, clock_hand_color, clock_hand_color);
	var hours_angle = (((2 * pi) * ((current_hour + (current_minute / 60)) % 12)) / 12) - (90 * RAD);
	draw_line_width_color(clock_hands_x, clock_hands_y, clock_hands_x + (cos(hours_angle) * clock_hand_hours_length), clock_hands_y + (sin(hours_angle) * clock_hand_hours_length), clock_hand_hours_w, clock_hand_color, clock_hand_color);
};

draw = function()
{
	draw_self();
	draw_clock_hands();
};
