event_inherited();

function get_dx()
{
	return radius_x * angle_spd * cos(angle + angle_offset);
}

function get_dy()
{
	return radius_y * angle_spd * sin(angle + angle_offset) * -1;
}

function move(inst)
{
	if (0 == angle_spd)
		exit;
	angle = angle_fix(angle + angle_spd);
	var _dx = 0;
	var _dy = 0;
	if (radius_x > 0)
		_dx = get_dx();
	if (radius_y > 0)
		_dy = get_dy();
	inst.x += _dx;
	inst.y += _dy;
	dx += _dx;
	dy += _dy;
}

function reset_position()
{
	moving_instance.x -= dx;
	moving_instance.y -= dy;
}
