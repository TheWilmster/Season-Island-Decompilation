event_inherited();
sprite_index_fixed = spr_treehouse_pipe_room_2;

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
		case ItemType.WateringCan:
			if (is_fixed)
			{
				global.inventory.item_replace_selected(ItemType.WateringCanOil);
				create_mover_shake(3, 3, 0.1);
				sfx_play(snd_oil);
				create_textbox("treehouse pipe fill watering can with oil");
			}
			else
			{
				create_textbox("treehouse pipe broken watering can");
			}
			break;
		case ItemType.LoveLetter:
			create_textbox("treehouse oil pipe newton love letter");
			break;
		case ItemType.Hammer:
			if (is_fixed)
				hit();
			break;
		case ItemType.WateringCanFull:
			create_textbox("treehouse pipe watering can full");
			break;
	}
};
