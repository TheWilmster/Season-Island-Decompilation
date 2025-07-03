event_inherited();
name = "Springflowers";
is_awake = false;
image_speed = 0;

on_click_with_item = function()
{
	if (event_flag_get(Event.KillerScene) && !event_flag_get(Event.KillerDefeat))
	{
		create_textbox("springflowers spring in danger");
		exit;
	}
	switch (global.inventory.get_selected_item())
	{
		case ItemType.WateringCanFull:
			water(x + (sprite_width / 2), y);
			global.inventory.item_replace_selected(ItemType.WateringCan);
			if (is_awake)
			{
				create_textbox("springflowers too much water");
				exit;
			}
			is_awake = true;
			image_speed = 1;
			state = state_waking_up;
			global.is_game_paused = true;
			obj_menu_main.set_visibility(false);
			global.inventory.item_add(ItemType.Vine);
			global.inventory.deselect_item();
			break;
		case ItemType.TopiaryShears:
			if (is_awake)
				create_textbox("springflowers topiary shears");
			break;
		case ItemType.SuperiorShears:
			if (is_awake)
				create_textbox("springflowers topiary shears superior");
			break;
		case ItemType.LegendaryShears:
			if (is_awake)
				create_textbox("springflowers topiary shears legendary");
			break;
		case ItemType.WateringCan:
			if (is_awake)
				create_textbox("springflowers watering can");
			else
				create_textbox("springflowers watering can asleep");
			break;
		case ItemType.LoveLetter:
			if (is_awake)
				create_textbox("springflowers newton love letter");
			break;
		case ItemType.LoveLetterWet:
			if (is_awake)
				create_textbox("springflowers newton love letter wet");
			break;
		default:
			if (is_awake)
				create_textbox("springflowers wrong item");
			break;
	}
};

on_click_without_item = function()
{
	if (event_flag_get(Event.KillerScene) && !event_flag_get(Event.KillerDefeat))
	{
		create_textbox("springflowers spring in danger");
		exit;
	}
	else if (event_flag_get(Event.MetSpring) && !event_flag_get(Event.EnterTreehouseOutside))
	{
		create_textbox("springflowers after talking to spring");
		exit;
	}
	if (is_awake)
		create_textbox("springflowers");
	else
		create_textbox("springflowers asleep");
};

stop_animating = function()
{
	image_speed = 0;
	image_index = 0;
};

state_idle = function()
{
};

state_waking_up = function()
{
	if (image_index == image_number)
	{
		sprite_index = spr_springflowers;
		state = state_idle;
		global.is_game_paused = false;
		obj_menu_main.set_visibility(true);
		create_textbox("springflowers wake up");
	}
};

state = state_idle;
