event_inherited();
name = "Hanging stars";

on_click_without_item = function()
{
	create_textbox("treehouse entrance hanging stars");
};

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.TopiaryShears:
		case ItemType.SuperiorShears:
		case ItemType.LegendaryShears:
			create_textbox("treehouse entrance hanging stars topiary shears");
			break;
		case ItemType.Crinoid:
		case ItemType.BigCrinoid:
			create_textbox("treehouse entrance hanging stars crinoid");
			break;
	}
};
