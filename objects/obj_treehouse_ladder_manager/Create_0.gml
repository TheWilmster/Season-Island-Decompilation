is_ladder_fixed = false;

are_planks_attached_to_ladder = function()
{
	with (obj_treehouse_ladder_plank)
	{
		if (!is_attached())
			return false;
	}
	return true;
};

check_if_ladder_is_fixed = function()
{
	if (is_ladder_fixed)
		exit;
	if (are_planks_attached_to_ladder())
	{
		is_ladder_fixed = true;
		global.inventory.item_rmv(ItemType.Nails);
		create_textbox("treehouse ladder fixed");
	}
};
