function game_begin()
{
	audio_stop_all();
	obj_save_file_manager.load();
	instance_create_depth(0, 0, Depth.Menu, obj_menu_main);
}
