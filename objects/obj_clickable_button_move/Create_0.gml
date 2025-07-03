event_inherited();
tooltip = "Move";

on_click = function()
{
	instance_create_depth(0, 0, Depth.Menu, obj_menu_move);
};

set_label(string("[{0}]", sprite_get_name(spr_gui_button_icon_move)));

can_be_clicked = function()
{
	return !global.is_game_paused;
};
