function create_popup(_text)
{
	return instance_create_depth(0, 0, Depth.Popup, obj_popup, 
	{
		text: _text
	});
}
