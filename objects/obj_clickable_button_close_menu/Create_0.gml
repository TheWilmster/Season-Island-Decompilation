event_inherited();

on_click = function()
{
	obj_menu_manager.close_current_menu();
	obj_menu_main.set_visibility(true);
	global.is_game_paused = false;
};

text_formatter.font_color = 0;
set_label("Back");
