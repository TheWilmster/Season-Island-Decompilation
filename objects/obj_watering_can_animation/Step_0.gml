watering_can_image_alpha -= watering_can_image_alpha_step;
if (watering_can_image_alpha <= 0)
	instance_destroy();
if (alarm_is_expired(0))
	alarm_set(0, waterdrop_delay);
