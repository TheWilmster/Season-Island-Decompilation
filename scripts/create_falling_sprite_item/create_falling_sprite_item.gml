function create_falling_sprite_item(_x, _y, _depth, item)
{
	var xspeed_max = 4;
	return create_falling_sprite(arg3.sprite_index, 0, _x, _y, _depth, -xspeed_max + (2 * random(xspeed_max)), -random_range(1, 3), 0.1, 0.5, 0.5);
}
