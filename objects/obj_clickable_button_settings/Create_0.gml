event_inherited();
tooltip = "Settings";

on_click = function()
{
	obj_menu_main.set_visibility(false);
	global.is_game_paused = true;
	instance_create_depth(0, 0, -9999, obj_menu_settings);
};

set_label(string("[{0}]", sprite_get_name(spr_gui_button_icon_settings)));

can_be_clicked = function()
{
	return !global.is_game_paused;
};
