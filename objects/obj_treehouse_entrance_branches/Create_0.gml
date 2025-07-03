event_inherited();
name = "Branches";
cut_counter = 5;

action_fully_cut = function()
{
	instance_destroy();
	event_flag_set(Event.TreehouseBranchesCut);
};

on_click_with_item = function()
{
	if (is_cut())
		exit;
	switch (global.inventory.get_selected_item())
	{
		case ItemType.SuperiorShears:
			if (cut_counter == 3)
			{
				global.inventory.item_replace_selected(ItemType.BigCrinoid);
				create_textbox("treehouse entrance branches superior topiary shears stuck");
			}
			else
			{
				cut();
			}
			break;
		case ItemType.LegendaryShears:
			cut();
			break;
		case ItemType.TopiaryShears:
			create_textbox("treehouse entrance branches topiary shears");
			break;
		case ItemType.WateringCanFull:
			global.inventory.item_replace_selected(ItemType.WateringCan);
			water(x + (sprite_width / 2), y + (sprite_height / 2));
			create_textbox("treehouse entrance branches watering can full");
			break;
	}
};

on_click_without_item = function()
{
	create_textbox("treehouse entrance branches");
};
