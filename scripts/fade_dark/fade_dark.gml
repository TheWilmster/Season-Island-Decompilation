function fade_dark(_function = undefined, _arguments = undefined)
{
	with (instance_create_depth(0, 0, Depth.Fade, obj_fade_dark))
	{
		if (undefined != _function)
		{
			callback = _function;
			args = _arguments;
		}
	}
}
