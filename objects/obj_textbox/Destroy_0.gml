if (action_destroyed)
	action_destroyed();
destroy_display_sprite();
talksprite_fade_out();
if (was_main_menu_visible)
{
	with (obj_menu_main)
		set_visibility(true);
}
global.is_game_paused = false;
