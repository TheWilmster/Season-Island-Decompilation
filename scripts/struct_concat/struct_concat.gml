function struct_concat(_struct_1, _struct_2 = {})
{
	var _struct_3 = {};
	var _struct_1_names = struct_get_names(_struct_1);
	for (var _i = 0; _i < array_length(_struct_1_names); _i++)
	{
		var _source_key = _struct_1_names[_i];
		variable_struct_set(_struct_3, _source_key, variable_struct_get(_struct_1, _source_key));
	}
	var _struct_2_names = struct_get_names(_struct_2);
	for (var _i = 0; _i < array_length(_struct_2_names); _i++)
	{
		var _source_key = _struct_2_names[_i];
		variable_struct_set(_struct_3, _source_key, variable_struct_get(_struct_2, _source_key));
	}
	return _struct_3;
}
