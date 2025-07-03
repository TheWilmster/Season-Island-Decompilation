event_inherited();
name = "Cherug";

make_slingshot = function()
{
	create_textbox("cherug make slingshot");
	global.inventory.item_rmv(ItemType.WoodenBranch);
	global.inventory.item_rmv(ItemType.Vine);
	global.inventory.item_add(ItemType.Slingshot);
};

on_click_with_item = function()
{
	if (event_flag_get(Event.KillerScene) && !event_flag_get(Event.KillerDefeat))
	{
		create_textbox("cherug spring in danger");
		exit;
	}
	switch (global.inventory.get_selected_item())
	{
		case ItemType.WateringCanBroken:
			create_textbox("cherug fix watering can");
			global.inventory.item_replace_selected(ItemType.WateringCan);
			global.inventory.deselect_item();
			break;
		case ItemType.StepladderBroken:
			create_textbox("cherug fix stepladder");
			global.inventory.item_replace_selected(ItemType.Stepladder);
			global.inventory.deselect_item();
			break;
		case ItemType.WoodenBranch:
			if (global.inventory.contains_item(ItemType.Vine))
				make_slingshot();
			else
				create_textbox("cherug wooden branch y");
			break;
		case ItemType.Vine:
			if (global.inventory.contains_item(ItemType.WoodenBranch))
				make_slingshot();
			else
				create_textbox("cherug springflower vine");
			break;
		case ItemType.WateringCanFull:
			water(x + (sprite_width / 2), y);
			global.inventory.item_replace_selected(ItemType.WateringCan);
			create_textbox("cherug watering can full");
			break;
		case ItemType.WateringCan:
			create_textbox("cherug watering can");
			break;
		case ItemType.Stepladder:
			create_textbox("cherug stepladder");
			break;
		case ItemType.LoveLetter:
			create_textbox("cherug newton love letter");
			break;
		case ItemType.LoveLetterWet:
			create_textbox("cherug newton love letter wet");
			break;
		default:
			create_textbox("cherug wrong item");
			break;
	}
};

on_click_without_item = function()
{
	if (event_flag_get(Event.KillerScene) && !event_flag_get(Event.KillerDefeat))
	{
		create_textbox("cherug spring in danger");
		exit;
	}
	else if (event_flag_get(Event.MetSpring) && !event_flag_get(Event.EnterTreehouseOutside))
	{
		create_textbox("cherug after talking to spring");
		exit;
	}
	create_textbox("cherug");
};
