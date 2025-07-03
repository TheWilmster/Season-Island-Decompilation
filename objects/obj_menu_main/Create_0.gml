event_inherited();
inventory = undefined;
button_settings = undefined;
button_move = undefined;

draw = function()
{
	draw_self();
};

get_width = function()
{
	return sprite_width;
};

get_height = function()
{
	return sprite_height;
};

image_alpha = 0.5;
image_xscale = 640 / sprite_width;
image_yscale = 72 / sprite_height;
x = 0;
y = 0;
inventory = instance_create_depth(x, y, Depth.Inventory, obj_inventory);
button_settings = instance_create_depth(x, y, Depth.ButtonUI, obj_clickable_button_settings);
button_move = instance_create_depth(x, y, Depth.ButtonUI, obj_clickable_button_move);
var remaining_space = get_width() - inventory.get_width();
inventory.set_position((get_width() / 2) - (inventory.get_width() / 2), (y + (get_height() / 2)) - (inventory.get_height() / 2));
button_settings.x += (remaining_space / 4) - (button_settings.get_width() / 2);
button_settings.y += (get_height() / 2) - (button_settings.get_height() / 2);
button_move.x += get_width() - (remaining_space / 4) - (button_move.get_width() / 2);
button_move.y += (get_height() / 2) - (button_move.get_height() / 2);
child_nodes = [inventory, button_settings, button_move];
