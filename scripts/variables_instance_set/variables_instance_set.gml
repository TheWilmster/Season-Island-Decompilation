function variables_instance_set(inst, vars)
{
	var _keys = variable_struct_get_names(vars);
	for (var _i = 0; _i < array_length(_keys); _i++)
	{
		var _key = _keys[_i];
		variable_instance_set(inst, _key, variable_struct_get(vars, _key));
	}
}
