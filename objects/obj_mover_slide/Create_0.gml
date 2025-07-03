event_inherited();
current_x = 0;
current_y = 0;
target_x = dx;
target_y = dy;
precision = 0.5;
movement_dx = 0;
movement_dy = 0;

function move(inst)
{
	var is_x_reached = abs(target_x - current_x) <= precision;
	var _dx = 0;
	var _dy = 0;
	if (!is_x_reached)
	{
		var old_x = current_x;
		current_x = lerp(current_x, target_x, amt);
		_dx = current_x - old_x;
		inst.x += _dx;
	}
	else
	{
		inst.x += target_x - current_x;
		current_x = target_x;
	}
	var is_y_reached = abs(target_y - current_y) <= precision;
	if (!is_y_reached)
	{
		var old_y = current_y;
		current_y = lerp(current_y, target_y, amt);
		_dy = current_y - old_y;
		inst.y += _dy;
	}
	else
	{
		inst.y += target_y - current_y;
		current_y = target_y;
	}
	if (is_x_reached && is_y_reached)
	{
		instance_destroy();
		exit;
	}
	movement_dx = _dx;
	movement_dy = _dy;
}

function get_distance_left_x()
{
	return target_x - current_x;
}

function get_distance_left_y()
{
	return target_y - current_y;
}

function get_movement_dx()
{
	return movement_dx;
}

function get_movement_dy()
{
	return movement_dy;
}
