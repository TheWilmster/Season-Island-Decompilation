function instance_create(object, var_struct = {})
{
	return instance_create_depth(0, 0, 0, object, var_struct);
}
