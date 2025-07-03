function array_get_last(array)
{
	var _array_len = array_length(array);
	if (0 == _array_len)
		return noone;
	return array[_array_len - 1];
}
