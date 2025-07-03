function create_mover_fall(_yspeed, _weight, _inst = self)
{
	return instance_create(obj_mover_fall, 
	{
		yspd: _yspeed,
		weight: _weight,
		moving_instance: _inst
	});
}
