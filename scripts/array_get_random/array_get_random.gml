function array_get_random(array)
{
	return array[irandom_range(0, array_length(array) - 1)];
}
