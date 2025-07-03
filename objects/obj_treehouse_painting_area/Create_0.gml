event_inherited();
name = "Painting";

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.WateringCanOil:
			create_textbox("treehouse painting oil");
			break;
		case ItemType.WateringCanFull:
			water(x + (sprite_width / 2), y + (sprite_height / 2));
			global.inventory.item_replace_selected(ItemType.WateringCan);
			create_textbox("treehouse painting watering can full");
			break;
		case ItemType.LegendaryShears:
			create_textbox("treehouse painting topiary shears legendary");
			break;
	}
};

on_click_without_item = function()
{
	create_textbox(chatterbox_node_title);
};
