event_inherited();
on_click_without_item = virtual_method;
on_click_with_item = virtual_method;
get_cursor_tooltip_without_item = virtual_method;
get_cursor_tooltip_with_item = virtual_method;

on_click = function()
{
	if (global.inventory.selected_slot != -1)
		on_click_with_item();
	else
		on_click_without_item();
};

get_cursor_tooltip = function()
{
	if (global.inventory.get_selected_item() == ItemType.None)
	{
		if (name == "")
			return "Look";
		return get_cursor_tooltip_without_item();
	}
	if (name == "")
		return string("Use [{0}] here", obj_data.get_item_sprite_name(global.inventory.get_selected_item()));
	return get_cursor_tooltip_with_item();
};
