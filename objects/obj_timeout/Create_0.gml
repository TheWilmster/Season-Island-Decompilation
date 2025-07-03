if (time < 1)
{
	if (callback)
		callback();
	instance_destroy();
	exit;
}
alarm_set(0, time);
