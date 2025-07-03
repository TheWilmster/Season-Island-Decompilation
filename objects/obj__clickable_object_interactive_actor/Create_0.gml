event_inherited();

get_cursor_tooltip_without_item = function()
{
	return string("Talk to {0}", name);
};

get_cursor_tooltip_with_item = function()
{
	return string("Show [{0}] to {1}", obj_data.get_item_sprite_name(global.inventory.get_selected_item()), name);
};
