event_inherited();
image_xscale = 12;
var slider_instance = self;
slider_handle_instance = instance_create_depth(x, y + (sprite_height / 2), depth - 1, obj_slider_handle, 
{
	slider_instance: slider_instance
});
text_formatter_label = new TextFormatter("fnt_pixel_operator_8_outline_8dir", c_white, 2, 1);
text_formatter_value = new TextFormatter("fnt_pixel_operator_8_outline_8dir", c_white, 0, 1);
margin = 4;

value_update = function(amt)
{
	var relative_handle_x = amt - x;
	value = relative_handle_x / (sprite_width - slider_handle_instance.sprite_width);
	value_update_effect();
};

draw = function()
{
	draw_self();
	text_formatter_label.get_formatted_text(label).draw(x - margin, y + (sprite_height / 2));
	text_formatter_value.get_formatted_text(string("{0}%", floor(value * 100))).draw(x + sprite_width + margin, y + (sprite_height / 2));
};

value_set = function(val)
{
	self.value = val;
	slider_handle_instance.x = x + (val * (sprite_width - slider_handle_instance.sprite_width));
};

get_width = function()
{
	return sprite_width;
};

get_height = function()
{
	return slider_handle_instance.get_height();
};

fix_handle_position = function()
{
	slider_handle_instance.x = x + (value * (sprite_width - slider_handle_instance.sprite_width));
	slider_handle_instance.y = (y + (sprite_height / 2)) - (slider_handle_instance.sprite_height / 2);
};

value_update_effect = virtual_method;
label = "";
