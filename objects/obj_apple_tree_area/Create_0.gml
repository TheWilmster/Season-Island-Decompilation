event_inherited();
name = "Apple tree";

on_click_without_item = function()
{
	create_textbox("apple tree");
};

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.TopiaryShears:
			create_textbox("apple tree topiary shears");
			break;
		case ItemType.SuperiorShears:
			create_textbox("apple tree topiary shears superior");
			break;
		case ItemType.LegendaryShears:
			create_textbox("apple tree topiary shears legendary");
			break;
	}
};
