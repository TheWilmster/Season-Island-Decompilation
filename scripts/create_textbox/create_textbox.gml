function create_textbox(_node, _on_destroy = undefined, _alias = "chapter")
{
	show_debug_message(string("Creating textbox. node = {0}, alias = {1}.", _node, _alias));
	return instance_create_depth(0, 0, Depth.Textbox, obj_textbox, 
	{
		dialogue_node: _node,
		chatterbox_alias: _alias,
		action_destroyed: _on_destroy
	});
}
