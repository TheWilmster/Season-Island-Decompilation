event_inherited();
name = "Teahouse door";
is_oiled = false;
knock_counter = 0;
knock_value_max = 8;

knock = function()
{
	camera_shake();
	sfx_play(snd_punch);
	knock_counter++;
	if (knock_counter == knock_value_max)
	{
		knock_counter = 0;
		create_textbox("teahouse door knock");
	}
};

open = function()
{
	create_textbox("teahouse door hint move teahouse");
};

spin_cogs = function()
{
	if (are_cogs_set())
	{
		with (obj__treehouse_cog)
			spin_automatically();
		audio_play_sound(snd_bonus, 1, false);
		if (is_oiled)
			open();
	}
};

are_cogs_set = function()
{
	with (obj__treehouse_cog)
	{
		if (!is_visible)
			return false;
	}
	return true;
};

can_be_opened = function()
{
	return is_oiled && are_cogs_set();
};

on_click_without_item_room_unavailable = function()
{
	if (!are_cogs_set())
		create_textbox("teahouse door hint cogs");
	else if (!is_oiled)
		create_textbox("teahouse door hint oil");
};

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.WateringCanOil:
			is_oiled = true;
			global.inventory.item_rmv_selected();
			oil(x, y);
			if (are_cogs_set())
				open();
			break;
		case ItemType.LoveLetter:
			create_textbox("teahouse door newton love letter");
			break;
		case ItemType.LoveLetterWet:
			create_textbox("teahouse door newton love letter wet");
			break;
		case ItemType.Hammer:
			knock();
			break;
	}
};
