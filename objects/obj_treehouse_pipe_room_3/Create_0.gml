event_inherited();
sprite_index_fixed = spr_treehouse_pipe_room_3;

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.Pipe:
			if (is_fixed)
				break;
			sprite_index = sprite_index_fixed;
			is_fixed = true;
			global.inventory.item_rmv_selected();
			break;
		case ItemType.LoveLetter:
			create_textbox("treehouse oil pipe newton love letter");
			break;
		case ItemType.Hammer:
			if (is_fixed)
				hit();
			break;
		case ItemType.WateringCan:
			if (is_fixed)
				create_textbox("treehouse pipe no oil");
			else
				create_textbox("treehouse pipe broken watering can");
			break;
		case ItemType.WateringCanFull:
			create_textbox("treehouse pipe watering can full");
			break;
	}
};
