function add_inventory_item_floating(_item_id)
{
	instance_create_depth(x - (sprite_width / 2), y - (sprite_height / 2), Depth.InvItem, obj_floating_inventory_item, 
	{
		item_id: _item_id
	});
}
