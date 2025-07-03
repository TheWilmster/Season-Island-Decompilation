function fade_light(_function = undefined, _arguments = undefined)
{
	with (instance_create_depth(0, 0, Depth.Fade, obj_fade_light))
	{
		if (undefined != _function)
		{
			callback = _function;
			args = _arguments;
		}
	}
}
