event_inherited();
obj_menu_main.set_visibility(false);
global.is_game_paused = true;

create_back_button_and_destroy = function()
{
	array_push(child_nodes, instance_create_depth(0, 0, Depth.ButtonUI, obj_clickable_button_close_menu));
	with (child_nodes[0])
	{
		x = 320 - (get_width() / 2);
		y = 180 - (get_height() / 2);
	}
};

get_width = function()
{
	return ((array_length(child_nodes) - 1) * child_nodes[0].get_width()) + ((array_length(child_nodes) - 2) * button_spacing);
};

get_height = function()
{
	var sum = 0;
	for (var i = 0; i < array_length(child_nodes); i++)
		sum += child_nodes[i].get_height();
	sum += ((array_length(child_nodes) - 1) * button_spacing);
	return sum;
};

button_spacing = 12;
var room_data = obj_data.get_room(room);
if (!room_data)
{
	create_back_button_and_destroy();
	exit;
}
room_structs = struct_get_from_hash(room_data, variable_get_hash("neighbor_rooms"));
if (room_structs == undefined)
{
	create_back_button_and_destroy();
	exit;
}

is_room_struct_available = function(struct)
{
	var cond = struct_get_from_hash(struct, variable_get_hash("cond"));
	if (cond == undefined)
		return true;
	return cond();
};

for (var i = 0; i < array_length(room_structs); i++)
{
	var room_struct = room_structs[i];
	if (!is_room_struct_available(room_struct))
		continue;
	var rm = struct_get_from_hash(room_struct, variable_get_hash("rm"));
	if (rm == undefined)
		continue;
	array_push(child_nodes, instance_create_depth(0, 0, Depth.ButtonUI, obj_clickable_button_move_room, 
	{
		target_room: rm
	}));
	var room_button = array_get_last(child_nodes);
}
array_push(child_nodes, instance_create_depth(0, 0, Depth.ButtonUI, obj_clickable_button_close_menu));
if (array_length(child_nodes) == 1)
{
	with (child_nodes[0])
	{
		x = 320 - (get_width() / 2);
		y = 180 - (get_height() / 2);
	}
	exit;
}
var cursor_x = 320;
var total_width = get_width();
for (var i = 0; i < (array_length(child_nodes) - 1); i++)
{
	with (child_nodes[i])
	{
		y = 180 - get_height();
		x = cursor_x - (total_width / 2);
		cursor_x += get_width();
	}
	cursor_x += button_spacing;
}
var spacing = button_spacing;
var first_button = child_nodes[0];
with (array_get_last(child_nodes))
{
	x = 320 - (get_width() / 2);
	y = first_button.y + first_button.get_height() + spacing;
}
