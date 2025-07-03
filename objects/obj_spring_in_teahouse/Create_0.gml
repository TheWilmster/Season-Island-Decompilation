event_inherited();
name = "Spring";

on_click_without_item = function()
{
	talk("teahouse spring");
};

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.LoveLetter:
			talk("teahouse spring newton love letter");
			break;
		case ItemType.LoveLetterWet:
			talk("teahouse spring newton love letter wet");
			break;
		case ItemType.LegendaryShears:
			talk("teahouse spring topiary shears legendary");
			break;
		case ItemType.Hammer:
			talk("teahouse spring hammer");
			break;
		default:
			talk("teahouse spring wrong item");
			break;
	}
};
