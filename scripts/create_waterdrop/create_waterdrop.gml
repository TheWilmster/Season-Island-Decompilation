function create_waterdrop(_x, _y, _depth, _min_range, _max_range, _color)
{
	var water_drop_scale = random_range(0.2, 1);
	var water_drop_xspeed = random_range(_min_range, _max_range);
	return create_falling_sprite(spr_water_drop, 0, _x, _y, _depth, water_drop_xspeed, 0, 0.2, water_drop_scale, water_drop_scale, water_drop_xspeed * 12, _color);
}
