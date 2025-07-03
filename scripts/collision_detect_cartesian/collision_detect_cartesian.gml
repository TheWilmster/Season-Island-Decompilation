function collision_detect_cartesian(xsp, ysp, object)
{
	if (xsp == 0 && ysp == 0)
		return [false, false];
	var _detected_axes = [false, false];
	if (place_meeting(x + xsp, y, object))
	{
		_detected_axes[0] = true;
		while (!place_meeting(x + sign(xsp), y, object) && is_between(x, 0, room_width))
			x += sign(xsp);
		x -= xsp;
	}
	if (place_meeting(x, y + ysp, object))
	{
		_detected_axes[1] = true;
		while (!place_meeting(x, y + sign(ysp), object) && is_between(y, 0, room_height))
			y += sign(ysp);
		y -= ysp;
	}
	return _detected_axes;
}
