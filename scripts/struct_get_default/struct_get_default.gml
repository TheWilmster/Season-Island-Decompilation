function struct_get_default(_struct, _key, _default)
{
	if (struct_exists(_struct, _key))
		return variable_struct_get(_struct, _key);
	return _default;
}
