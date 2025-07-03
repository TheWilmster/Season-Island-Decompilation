event_inherited();
tooltip = "";

get_cursor_tooltip = function()
{
	return tooltip;
};

nineslice = sprite_exists(sprite_index) ? sprite_get_nineslice(sprite_index) : undefined;
label = "";
text_formatter = new TextFormatter(font_get_name(fnt_pixel_operator), c_white, 1, 1);
label_width = 1;
label_height = 1;
text_width = 640;

set_label = function(label)
{
	nineslice = sprite_get_nineslice(sprite_index);
	self.label = label;
	label_width = text_formatter.text_width_ext(label, text_width);
	label_height = text_formatter.text_height_ext(label, text_width);
	image_xscale = label_width / sprite_get_width(sprite_index);
	image_yscale = label_height / sprite_get_height(sprite_index);
};

draw_label = function()
{
	text_formatter.get_formatted_text(label).wrap(text_width).draw(x + (label_width / 2), y + (label_height / 2));
};

button_pressed_sprite_index = asset_unknown;

draw = function()
{
	var button_sprite = (is_being_clicked && button_pressed_sprite_index != -1) ? button_pressed_sprite_index : sprite_index;
	draw_sprite_stretched_ext(button_sprite, 0, x - nineslice.left, y - nineslice.top, label_width + nineslice.left + nineslice.right, label_height + nineslice.top + nineslice.bottom, c_white, image_alpha);
	draw_label();
};

get_width = function()
{
	return label_width;
};

get_height = function()
{
	return label_height;
};

cursor_meeting = function(x, y)
{
	return point_in_rectangle(x, y, self.x - nineslice.left, self.y - nineslice.top, self.x + label_width + nineslice.right, self.y + label_height + nineslice.bottom);
};

sound_pressed = snd_button_pressed;
sound_released = snd_button_released;

on_mouse_pressed = function()
{
	if (sound_pressed)
		audio_play_sound(sound_pressed, 1, false);
};

on_mouse_released = function()
{
	if (sound_released)
		audio_play_sound(sound_released, 1, false);
};
