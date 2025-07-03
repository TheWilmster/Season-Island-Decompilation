ChatterboxSelect(obj_textbox.chatterbox, option_index);
obj_menu_manager.close_current_menu();
with (obj_textbox)
{
	page_read();
	state = state_typing;
}
