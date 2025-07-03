event_inherited();
y -= (sprite_height / 2);

draw = function()
{
	var sprite = is_being_clicked ? spr_slider_handle_pressed : spr_slider_handle;
	draw_sprite(sprite, 0, x, y);
};

get_width = function()
{
	return sprite_width;
};

get_height = function()
{
	return sprite_height;
};
