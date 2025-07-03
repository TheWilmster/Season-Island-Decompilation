event_inherited();

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.SmallCogs:
			audio_play_sound(snd_box, 1, false);
			global.inventory.item_rmv_selected();
			obj_treehouse_cog.set_visibility(true);
			obj_treehouse_cog_2.set_visibility(true);
			obj_treehouse_cog_3.set_visibility(true);
			obj_teahouse_door_area.spin_cogs();
			instance_destroy();
			break;
	}
};

on_click_without_item = function()
{
	create_textbox("treehouse cog area 1");
};
