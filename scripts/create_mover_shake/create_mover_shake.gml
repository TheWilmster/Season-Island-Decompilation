function create_mover_shake(x, y, shake_amt = 0, inst = self)
{
	return instance_create(obj_mover_shake, 
	{
		shake_x: x,
		shake_y: y,
		shake_step: shake_amt,
		moving_instance: inst
	});
}
