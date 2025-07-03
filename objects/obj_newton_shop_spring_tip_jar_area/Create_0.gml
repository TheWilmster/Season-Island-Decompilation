event_inherited();

on_click_without_item = function()
{
	create_textbox("newton spring shop tip jar");
};

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.Crinoid:
			create_textbox("newton spring shop tip jar crinoid");
			break;
		case ItemType.BigCrinoid:
			create_textbox("newton spring shop tip jar crinoid big");
			break;
	}
};
