event_inherited();

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.LegendaryShears:
			create_textbox("teahouse flowers topiary shears legendary");
			break;
		case ItemType.LoveLetter:
			create_textbox("teahouse flowers newton love letter");
			break;
		case ItemType.LoveLetterWet:
			create_textbox("teahouse flowers newton love letter wet");
			break;
	}
};

on_click_without_item = function()
{
	create_textbox(dialogue_node_title);
};
