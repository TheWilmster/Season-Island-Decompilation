function create_mover_linear(_xspeed, _yspeed, _inst = self)
{
	var _mover = instance_create(obj_mover_linear);
	with (_mover)
	{
		xspd = _xspeed;
		yspd = _yspeed;
		moving_instance = _inst;
	}
	return _mover;
}
