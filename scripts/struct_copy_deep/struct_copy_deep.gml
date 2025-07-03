function struct_copy_deep(_struct)
{
	var copy = {};
	var keys = struct_get_names(_struct);
	for (var i = 0; i < array_length(keys); i++)
	{
		var key = keys[i];
		var value = variable_struct_get(_struct, key);
		if (is_struct(value))
			variable_struct_set(copy, key, struct_copy_deep(value));
		else if (is_array(value))
			variable_struct_set(copy, key, array_copy_deep(value));
		else
			variable_struct_set(copy, key, value);
	}
	return copy;
}
