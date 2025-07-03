event_inherited();
if (active)
{
	radius_x = max(0, radius_x - amplitude_dx);
	radius_y = max(0, radius_y - amplitude_dy);
	if (0 == radius_x && 0 == radius_y)
	{
		instance_destroy();
		exit;
	}
}
