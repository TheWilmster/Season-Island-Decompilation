event_inherited();

draw = function()
{
	draw_self();
};

is_fallen = false;

fall = function()
{
	is_fallen = true;
	camera_shake();
	audio_play_sound(snd_snowball_kick, 1, false);
	set_sprite_fallen();
};

set_sprite_fallen = function()
{
	x = init_x;
	var head_x = x + sprite_width;
	var ground_y = y + sprite_height;
	sprite_index = spr_newton_holding_knife_fallen;
	x = head_x - sprite_width;
	y = ground_y - sprite_height;
};

name = "Knife guy";

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.WateringCanFull:
			water((x + sprite_width) - 10, y);
			global.inventory.item_replace_selected(ItemType.WateringCan);
			create_textbox(is_fallen ? "knife guy watering can full fallen" : "knife guy watering can full");
			break;
		case ItemType.TopiaryShears:
			create_textbox(is_fallen ? "knife guy topiary shears fallen" : "knife guy topiary shears");
			break;
		case ItemType.WateringCan:
			create_textbox(is_fallen ? "knife guy watering can fallen" : "knife guy watering can");
			break;
	}
};

on_click_without_item = function()
{
	if (is_fallen)
		create_textbox("knife guy fallen");
	else
		create_textbox("knife guy");
};

init_x = x;
angle = 0;
angle_spd = 5 * RAD;
movement_distance_max = 5;

state_idle = function()
{
	angle += angle_spd;
	if (angle >= (2 * pi))
		angle -= (2 * pi);
	if (!is_fallen)
		x = init_x + (movement_distance_max * cos(angle));
};

state_fallen = function()
{
};

state = state_idle;
