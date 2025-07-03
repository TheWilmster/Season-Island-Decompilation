event_inherited();
name = "Tree branch";
cut_counter = 3;

on_click_without_item = function()
{
	create_textbox("spring shade plant");
};

on_click_with_item = function()
{
	if (is_cut())
		exit;
	switch (global.inventory.get_selected_item())
	{
		case ItemType.TopiaryShears:
			cut();
			break;
	}
};

action_fully_cut = function()
{
	create_textbox("spring shade plant cut");
	global.inventory.deselect_item();
	global.inventory.item_add(ItemType.WoodenBranch);
	instance_destroy();
};
