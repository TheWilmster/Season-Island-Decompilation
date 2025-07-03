event_inherited();
name = "Stepladder";
set_visibility(false);

on_click_without_item = function()
{
	create_textbox("stepladder");
};

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.WateringCanFull:
			water(x + (sprite_width / 2), y);
			global.inventory.item_replace_selected(ItemType.WateringCan);
			create_textbox("stepladder watering can full");
			break;
	}
};
