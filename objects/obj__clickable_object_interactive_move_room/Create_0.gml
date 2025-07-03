event_inherited();

is_room_struct_available = function(struct)
{
	var cond = struct_get_from_hash(struct, variable_get_hash("cond"));
	if (cond == undefined)
		return true;
	return cond();
};

create_move_menu = function()
{
	instance_create_depth(0, 0, Depth.Menu, obj_menu_move_room, 
	{
		target_room: target_room
	});
};

is_target_room_available = function()
{
	var current_room_struct = obj_data.get_room(room);
	if (!current_room_struct)
		return false;
	var neighbor_rooms = struct_get_from_hash(current_room_struct, variable_get_hash("neighbor_rooms"));
	if (neighbor_rooms == undefined)
		return false;
	var target_room_struct_index = array_find_index(neighbor_rooms, method(
	{
		target_room: target_room
	}, function(room_data)
	{
		return room_data.rm == target_room;
	}));
	if (target_room_struct_index == -1)
		return false;
	var target_room_struct = neighbor_rooms[target_room_struct_index];
	return is_room_struct_available(target_room_struct);
};

on_click_without_item_room_unavailable = virtual_method;

on_click_without_item = function()
{
	if (is_target_room_available())
		create_move_menu();
	else
		on_click_without_item_room_unavailable();
};
