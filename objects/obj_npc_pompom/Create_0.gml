event_inherited();
name = "Pompom";

on_click_without_item = function()
{
	create_textbox("pompom");
};

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.LoveLetter:
			create_textbox("pompom newton love letter");
			break;
		case ItemType.LoveLetterWet:
			create_textbox("pompom newton love letter wet");
			break;
		default:
			create_textbox("pompom wrong item");
			break;
	}
};
