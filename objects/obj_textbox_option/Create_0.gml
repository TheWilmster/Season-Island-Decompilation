event_inherited();
text_formatter = new TextFormatter(obj_textbox.text_font_name, c_white, 1, 1);
ellipse_w = 0;
ellipse_h = 0;

set_label = function(_label)
{
	self.label = _label;
	label_width = text_formatter.text_width_ext(_label, text_width);
	label_height = text_formatter.text_height_ext(_label, text_width);
	ellipse_w = label_width / sqrt(2);
	ellipse_h = label_height / sqrt(2);
};

set_label(ChatterboxGetOption(obj_textbox.chatterbox, option_index));

on_click = function()
{
	if (alarm_is_expired(0))
		alarm_set(0, 1);
};

draw = function()
{
	var alpha = draw_get_alpha();
	draw_set_alpha(obj_textbox.textbox_alpha);
	obj_textbox.draw_ellipse_angle(x, y, label_width, label_height, RAD);
	draw_set_alpha(alpha);
	var label_formatted = is_selected ? string("[c_yellow][{0}]{1}", font_get_name(global.font_textbox), label) : label;
	text_formatter.get_formatted_text(label_formatted).wrap(text_width).draw(x + (label_width / 2), y + (label_height / 2));
};

cursor_meeting = function(_x, _y)
{
	return point_in_rectangle(_x, _y, self.x, self.y, self.x + label_width, self.y + label_height);
};

is_selected = false;

on_mouse_pressed = function()
{
	is_selected = true;
	sfx_play(snd_button_pressed);
};

on_mouse_released = function()
{
	is_selected = false;
	sfx_play(snd_button_released);
};
