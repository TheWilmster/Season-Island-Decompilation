heart_draw_scale = heart_draw_scale_min + ((heart_draw_scale_max - heart_draw_scale_min) * (1 - abs(sin(heart_draw_scale_angle))));
heart_draw_scale_angle += heart_draw_scale_angle_spd;
if (heart_draw_scale_angle > (2 * pi))
	heart_draw_scale_angle -= (2 * pi);
