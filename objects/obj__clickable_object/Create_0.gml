event_inherited();
on_click = virtual_method;

get_cursor_tooltip = function()
{
	return "";
};

can_be_clicked = function()
{
	return true;
};

can_cursor_click = function()
{
	return !is_being_clicked && is_visible && global.can_click && can_be_clicked();
};

on_mouse_pressed = function()
{
};

on_mouse_released = function()
{
};

is_being_clicked = false;

