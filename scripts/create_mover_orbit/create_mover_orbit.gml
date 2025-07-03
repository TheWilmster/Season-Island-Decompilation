function create_mover_orbit(_x_radius, _y_radius, _speed, _angle, _inst = self)
{
	return instance_create(obj_mover_orbit, 
	{
		moving_instance: _inst,
		radius_x: _x_radius,
		radius_y: _y_radius,
		angle_spd: _speed,
		angle: _angle
	});
}
