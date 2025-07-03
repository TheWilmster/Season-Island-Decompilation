event_inherited();
name = "Ceiling fan";
is_falling = false;

fall = function()
{
	obj_menu_main.set_visibility(false);
	global.can_click = false;
	state = state_falling;
};

yspd = 0;
yacc = 0.1;

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.LegendaryShears:
			sfx_play(snd_cut);
			fall();
			break;
	}
};

ground_y = 320;

state_idle = function()
{
};

state_falling = function()
{
	yspd += yacc;
	y += yspd;
	if ((y + sprite_height) >= ground_y)
	{
		camera_shake(5, 5, 0.4);
		obj_menu_main.set_visibility(true);
		global.can_click = true;
		global.inventory.item_add(ItemType.GiantCog);
		sfx_play(snd_punch, 0.7);
		create_falling_sprites_shatter(spr_item_giant_cog, x + (sprite_width / 2), y + (sprite_height / 2), Depth.Particle, 3);
		instance_destroy();
	}
};

state = state_idle;

on_click_without_item = function()
{
	create_textbox("treehouse ceiling fan");
};
