event_inherited();
item_id = -1;

on_click = function()
{
	audio_play_sound(snd_bonus, 1, false);
	instance_destroy();
	add_inventory_item_floating(item_id);
};

get_cursor_tooltip = function()
{
	return string("Take {0}", name);
};

set_item_id = function(item_id)
{
	self.item_id = item_id;
	name = obj_data.get_item_name(item_id);
};

draw = function()
{
	draw_self();
};
