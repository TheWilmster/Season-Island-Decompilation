event_inherited();
name = "Tea set";

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
	if (event_flag_get(Event.SpringDateStart))
		create_textbox("teahouse tea set no spring");
	else
		create_textbox("teahouse tea set");
};
