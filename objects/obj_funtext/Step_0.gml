if (alarm_is_expired(0) && 1 == typist.get_state())
	alarm_set(0, max(min_delay, out_delay_per_char * string_length_scribble(text)));
else if (2 == typist.get_state())
	instance_destroy();
