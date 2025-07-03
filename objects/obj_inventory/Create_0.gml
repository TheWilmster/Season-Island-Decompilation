event_inherited();
inventory_slots = [];
inventory_slot_spacing = 12;
var cursor_x = x;
for (var i = 0; i < global.inventory.get_size(); i++)
{
	array_push(inventory_slots, instance_create_depth(cursor_x, y, Depth.ButtonUI, obj_inventory_slot, 
	{
		order: i
	}));
	cursor_x += (inventory_slots[i].get_width() + inventory_slot_spacing);
}
child_nodes = inventory_slots;

set_position = function(_x, _y)
{
	self.x = _x;
	self.y = _y;
	var cursor_x = _x;
	for (var i = 0; i < global.inventory.get_size(); i++)
	{
		var inventory_slot = inventory_slots[i];
		inventory_slot.x = cursor_x;
		inventory_slot.y = _y;
		cursor_x += (inventory_slots[i].get_width() + inventory_slot_spacing);
	}
};

draw = function()
{
	array_foreach(inventory_slots, function(item)
	{
		item.draw();
	});
};

get_width = function()
{
	var sum = 0;
	for (var i = 0; i < array_length(inventory_slots); i++)
		sum += inventory_slots[i].get_width();
	sum += ((array_length(inventory_slots) - 1) * inventory_slot_spacing);
	return sum;
};

get_height = function()
{
	return inventory_slots[0].get_height();
};

get_inventory_slot_instance_at_index = function(index)
{
	return inventory_slots[index];
};
