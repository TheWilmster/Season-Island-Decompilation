event_inherited();
name = event_flag_get(Event.MetNewton) ? "Newton's shop" : "Apple house?";

on_click_without_item_room_unavailable = function()
{
	create_textbox("newton shop closed");
};

on_click_with_item = function()
{
	if (event_flag_get(Event.KillerScene) && !event_flag_get(Event.KillerDefeat))
	{
		create_textbox("newton shop spring in danger");
		exit;
	}
	switch (global.inventory.get_selected_item())
	{
		case ItemType.WateringCanFull:
			create_textbox("newton shop watering can full");
			break;
		case ItemType.TopiaryShears:
			create_textbox("newton shop topiary shears");
			break;
		case ItemType.SuperiorShears:
			create_textbox("newton shop topiary shears superior");
			break;
		case ItemType.LegendaryShears:
			create_textbox("newton shop topiary shears legendary");
			break;
	}
};
