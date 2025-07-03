function create_falling_sprite(_sprite_index, _image_index, _x, _y, _depth, _xspeed, _yspeed, _weight, _image_xscale = 1, _image_yscale = 1, _image_angle = 0, _image_blend = c_white)
{
	return instance_create_depth(_x, _y, _depth, obj_falling_sprite, 
	{
		yspeed: _yspeed,
		weight: _weight,
		xspeed: _xspeed,
		image_speed: 0,
		sprite_index: _sprite_index,
		image_index: _image_index,
		image_xscale: _image_xscale,
		image_yscale: _image_yscale,
		image_angle: _image_angle,
		image_blend: _image_blend
	});
}
