function move(inst)
{
	if (0 == shake_x && 0 == shake_y)
		instance_destroy();
	var _dx = shake_x * random(1);
	var _dy = shake_y * random(1);
	if (dx > 0)
		_dx = -_dx;
	if (dy > 0)
		_dy = -_dy;
	dx += _dx;
	dy += _dy;
	inst.x += _dx;
	inst.y += _dy;
	shake_x = max(0, shake_x - shake_step);
	shake_y = max(0, shake_y - shake_step);
}

function set_active(flag)
{
	active = flag;
	if (!active)
	{
		moving_instance.x -= dx;
		moving_instance.y -= dy;
	}
}
