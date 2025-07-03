event_inherited();
var nineslice = sprite_get_nineslice(sprite_index);
image_xscale = (32 + nineslice.top + nineslice.bottom) / sprite_width;
image_yscale = (32 + nineslice.left + nineslice.right) / sprite_height;

get_item_id = function()
{
	return global.inventory.items[order];
};

on_click = function()
{
	var inventory_slot_item_id = get_item_id();
	if (inventory_slot_item_id == -1)
		exit;
	if (global.inventory.selected_slot == order)
	{
		global.inventory.deselect_item();
		exit;
	}
	global.inventory.select_item_at_index(order);
};

get_cursor_tooltip = function()
{
	var item_id = get_item_id();
	if (item_id == ItemType.None)
		return "";
	return obj_data.get_item_name(item_id);
};

can_be_clicked = function()
{
	return !global.is_game_paused && get_item_id() != ItemType.None;
};

draw = function()
{
	draw_self();
	if (order == global.inventory.selected_slot)
		draw_sprite_ext(spr_gui_inventory_slot_selected, 0, (x + (sprite_width / 2)) - ((image_xscale * sprite_get_width(spr_gui_inventory_slot_selected)) / 2), (y + (sprite_height / 2)) - ((image_yscale * sprite_get_height(spr_gui_inventory_slot_selected)) / 2), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	var item_id = get_item_id();
	if (item_id == ItemType.None)
		exit;
	var item_sprite_index = obj_data.get_item_sprite_index(item_id);
	if (item_sprite_index == -1)
		exit;
	draw_sprite(item_sprite_index, 0, (x + (sprite_width / 2)) - (sprite_get_width(item_sprite_index) / 2), (y + (sprite_height / 2)) - (sprite_get_height(item_sprite_index) / 2));
};

get_width = function()
{
	return sprite_width;
};

get_height = function()
{
	return sprite_height;
};
