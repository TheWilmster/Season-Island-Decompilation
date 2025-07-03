function array_copy_deep(array)
{
	var copy = [];
	for (var i = 0; i < array_length(array); i++)
	{
		var value = array[i];
		if (is_struct(value))
			array_push(copy, struct_copy_deep(value));
		else if (is_array(value))
			array_push(copy, array_copy_deep(value));
		else
			array_push(copy, value);
	}
	return copy;
}
