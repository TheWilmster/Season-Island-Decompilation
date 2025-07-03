draw = virtual_method;
child_nodes = [];

set_visibility = function(flag)
{
	self.is_visible = flag;
	array_foreach(child_nodes, function(node)
	{
		node.set_visibility(is_visible);
	});
};

get_width = virtual_method;
get_height = virtual_method;

cursor_meeting = function(x, y)
{
	return position_meeting(x, y, self);
};

is_visible = true;
