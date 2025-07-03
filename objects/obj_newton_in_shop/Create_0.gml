event_inherited();
name = "Newton";

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.Crinoid:
			global.inventory.item_replace_selected(ItemType.SuperiorShears);
			talk("newton crinoid");
			break;
		case ItemType.BigCrinoid:
			global.inventory.item_replace_selected(ItemType.LegendaryShears);
			talk("newton crinoid big");
			global.inventory.item_add(ItemType.LoveLetter);
			break;
		case ItemType.LoveLetter:
			talk("newton newton love letter");
			break;
		case ItemType.LoveLetterWet:
			global.inventory.item_replace_selected(ItemType.LoveLetter);
			talk("newton newton love letter wet");
			break;
		case ItemType.SuperiorShears:
		case ItemType.LegendaryShears:
			talk("newton refund");
			break;
		case ItemType.TopiaryShears:
			talk("newton topiary shears");
			break;
		default:
			talk("newton spring shop wrong item");
			break;
	}
};

on_click_without_item = function()
{
	talk("newton spring shop");
};
