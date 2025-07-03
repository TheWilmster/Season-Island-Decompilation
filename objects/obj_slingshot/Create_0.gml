event_inherited();
is_aiming = false;
slingshot_strength = 0.09;
slingshot_vine_col = 5401395;
vine_center_offset_x = sprite_width / 2;
vine_center_offset_y = 4;

on_mouse_pressed = function()
{
	is_aiming = true;
	sprite_index = spr_item_slingshot_throwing;
};

on_mouse_released = function()
{
	if (!is_aiming)
		exit;
	sprite_index = spr_item_slingshot;
	is_aiming = false;
	var pebble_xspeed = ((x + vine_center_offset_x) - obj_cursor.x) * slingshot_strength;
	var pebble_yspeed = ((y + vine_center_offset_y) - obj_cursor.y) * slingshot_strength;
	audio_play_sound(snd_page_turn, 1, false);
	instance_create_depth(obj_cursor.x, obj_cursor.y, depth - 2, obj_small_pebble_throwing, 
	{
		xspeed: pebble_xspeed,
		yspeed: pebble_yspeed
	});
};

draw_slingshot_shooting = function()
{
	draw_self();
	var slingshot_x = x;
	var slingshot_y = y;
	var slingshot_vine_x1 = slingshot_x + (8 * image_xscale);
	var slingshot_vine_x2 = slingshot_x + (22 * image_xscale);
	var slingshot_vine_y = slingshot_y + (4 * image_yscale);
	var col = draw_get_color();
	draw_set_color(slingshot_vine_col);
	var vine_width = 2 * image_yscale;
	draw_line_width(obj_cursor.x, obj_cursor.y, slingshot_vine_x1, slingshot_vine_y, vine_width);
	draw_line_width(obj_cursor.x, obj_cursor.y, slingshot_vine_x2, slingshot_vine_y, vine_width);
	draw_set_color(col);
	draw_sprite(spr_arrows_4_directions, 0, obj_cursor.x, obj_cursor.y);
};

draw = function()
{
	if (is_aiming)
		draw_slingshot_shooting();
	else
		draw_self();
};

set_visibility(false);
