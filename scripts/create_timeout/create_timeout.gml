function create_timeout(_time, _callback)
{
	return instance_create(obj_timeout, 
	{
		time: _time,
		callback: _callback
	});
}
