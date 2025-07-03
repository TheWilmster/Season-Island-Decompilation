function create_mover_oscillate(_x_radius, _y_radius, _speed, _angle, _targetx, _targety, _inst = self)
{
	return instance_create(obj_mover_oscillate, 
	{
		moving_instance: _inst,
		radius_x: _x_radius,
		radius_y: _y_radius,
		angle_spd: _speed,
		angle: _angle,
		amplitude_dx: _targetx,
		amplitude_dy: _targety
	});
}
