function create_mover_slide(_targetx, _targety, _amt, _inst = self)
{
	return instance_create(obj_mover_slide, 
	{
		dx: _targetx,
		dy: _targety,
		amt: _amt,
		moving_instance: _inst
	});
}
