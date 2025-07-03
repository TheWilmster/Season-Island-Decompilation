event_inherited();

destroy = function()
{
	instance_destroy();
};

heart_draw_scale_min = 1;
heart_draw_scale = heart_draw_scale_min;
heart_draw_scale_max = 1.05;
heart_draw_scale_angle = 0;
heart_draw_scale_angle_spd = 0.10471975511965977;
create_mover_shake(1, 1, 0);
