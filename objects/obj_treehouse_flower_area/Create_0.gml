event_inherited();
name = "Lone flower";

on_click_without_item = function()
{
	create_textbox("treehouse lone flower");
};

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.WateringCanOil:
			create_textbox("treehouse lone flower watering can full oil");
			break;
		case ItemType.LegendaryShears:
			create_textbox("treehouse lone flower topiary shears legendary");
			break;
		case ItemType.LoveLetter:
			create_textbox("treehouse lone flower love letter");
			break;
		case ItemType.Hammer:
		case ItemType.Nails:
			create_textbox("treehouse lone flower hammer");
			break;
		case ItemType.WateringCanFull:
			water(x + (sprite_width / 2), y);
			global.inventory.item_replace_selected(ItemType.WateringCan);
			create_textbox("treehouse lone flower watering can full");
			break;
	}
};
