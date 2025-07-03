function create_falling_sprites_shatter(_sprite_index, _x, _y, _depth, _radius)
{
	for (var i = 0; i < _radius; i++)
	{
		var xspd = random_range(2, 4) * cos((i * pi) / _radius);
		var yspd = -random_range(2, 4) * sin((i * pi) / _radius);
		var falling_sprite = create_falling_sprite(_sprite_index, irandom_range(0, sprite_get_number(_sprite_index) - 1), _x, _y, _depth, xspd, yspd, 0.1);
		with (falling_sprite)
		{
			_x -= (sprite_width / 2);
			_y -= (sprite_height / 2);
		}
	}
}
