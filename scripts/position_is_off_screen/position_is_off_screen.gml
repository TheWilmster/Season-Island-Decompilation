function position_is_off_screen(x, y, width = 0, height = 0)
{
	return !position_is_on_screen(x, y, width, height);
}
