function angle_fix(angle)
{
	if (angle > (2 * pi))
		angle -= (2 * pi);
	else if (angle < 0)
		angle += (2 * pi);
	return angle;
}
