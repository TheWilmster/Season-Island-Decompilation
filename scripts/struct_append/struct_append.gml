function struct_append(_struct1, _struct2)
{
	if (!_struct1 || !_struct2)
		exit;
	var _source_names = struct_get_names(_struct2);
	for (var _i = 0; _i < array_length(_source_names); _i++)
	{
		var _source_key = _source_names[_i];
		variable_struct_set(_struct1, _source_key, variable_struct_get(_struct2, _source_key));
	}
}
