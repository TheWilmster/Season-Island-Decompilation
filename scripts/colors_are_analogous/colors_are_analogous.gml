function colors_are_analogous(_color1, _color2, _range = 1)
{
	return abs(array_get_index(COLOR_WHEEL, _color1, 0, 1) - array_get_index(COLOR_WHEEL, _color2, 0, 1)) <= _range;
}
