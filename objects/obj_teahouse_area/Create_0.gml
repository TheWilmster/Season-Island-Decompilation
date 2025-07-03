event_inherited();

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.Hammer:
			create_textbox("teahouse hammer");
			break;
	}
};

on_click_without_item = function()
{
	create_textbox(dialogue_node_title);
};
