function effect_create_dust(_x = x, _y = y, _depth = depth, _color = c_white)
{
	instance_create_depth(_x, _y, _depth, obj_effect_dust, 
	{
		image_blend: _color
	});
}
