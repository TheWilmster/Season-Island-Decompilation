event_inherited();
name = "Rope";

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.LegendaryShears:
			create_textbox("treehouse rope topiary shears legendary");
			break;
	}
};

on_click_without_item = function()
{
	create_textbox("treehouse rope");
};
