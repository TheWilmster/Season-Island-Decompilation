event_inherited();
set_label(string("[scale,.5][{0}]", sprite_get_name(spr_gui_button_icon_erase_savefile)));
tooltip = "Erase savefile?";
if (!obj_save_file_manager.save_file_exists())
{
	instance_destroy();
	exit;
}

on_click = function()
{
	set_visibility(false);
	create_textbox("erase savefile", function()
	{
		set_visibility(true);
	}, "global");
};
