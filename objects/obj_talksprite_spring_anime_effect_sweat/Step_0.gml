if (alarm_is_expired(0))
	alarm_set(0, random_range(sweat_delay_min, sweat_delay_max));
if (alarm_is_expired(1))
	alarm_set(1, shake_delay);
