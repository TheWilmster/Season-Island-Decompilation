event_inherited();
name = "Pipe";
is_fixed = false;
sprite_index_broken = sprite_index;
sprite_index_fixed = -1;

hit = function()
{
	sprite_index = sprite_index_broken;
	is_fixed = false;
	global.inventory.item_add(ItemType.Pipe);
	camera_shake();
	sfx_play(snd_punch);
};

on_click_without_item = function()
{
	if (is_fixed)
		create_textbox("treehouse pipe");
	else
		create_textbox("treehouse pipe broken");
};
