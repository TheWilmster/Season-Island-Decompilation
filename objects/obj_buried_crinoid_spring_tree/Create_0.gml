event_inherited();
name = "Mysterious object";
cut_counter = 4;

cut_particle_sprite_index = spr_buried_crinoid_spring_tree_cut_particles;

action_fully_cut = function()
{
	global.inventory.item_replace_selected(ItemType.Crinoid);
	create_textbox("buried crinoid cut");
	instance_destroy();
};

can_reach = function()
{
	return obj_stepladder.is_visible;
};

on_click_without_item = function()
{
	if (can_reach())
		create_textbox("buried crinoid can reach");
	else
		create_textbox("buried crinoid");
};

on_click_with_item = function()
{
	if (is_cut())
		exit;
	switch (global.inventory.get_selected_item())
	{
		case ItemType.TopiaryShears:
			if (!obj_stepladder.is_visible)
			{
				create_textbox("buried crinoid too high to cut");
				exit;
			}
			cut();
			break;
		case ItemType.Stepladder:
			global.inventory.item_rmv_selected();
			obj_stepladder.set_visibility(true);
			create_textbox("place down stepladder");
			break;
	}
};
