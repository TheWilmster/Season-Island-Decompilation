window_set_size(1280, 720);
alarm_set(0, 1);
surface_resize(application_surface, 1280, 720);
display_set_gui_size(640, 360);

function shake(x, y, shake_amt = 0)
{
	create_mover_shake(x, y, shake_amt);
}

function shake_stop()
{
	instance_destroy(obj_camera_mover_shake);
}

x = 0;
y = 0;
