event_inherited();
var option_count = ChatterboxGetOptionCount(obj_textbox.chatterbox);
options = [];
option_separation = 16;
x = 320;
var cursor_y = obj_textbox.y / 2;
for (var i = 0; i < option_count; i++)
{
	if (!ChatterboxGetOptionConditionBool(obj_textbox.chatterbox, i))
		continue;
	var option = instance_create_depth(x, cursor_y, Depth.Textbox, obj_textbox_option, 
	{
		option_index: i
	});
	cursor_y += (option.get_height() + option_separation);
	array_push(options, option);
}
child_nodes = options;

get_width = function()
{
	return options[0].get_width();
};

get_height = function()
{
	var sum = 0;
	for (var i = 0; i < array_length(options); i++)
		sum += options[i].get_height();
	sum += ((array_length(options) - 1) * option_separation);
	return sum;
};

for (var i = 0; i < array_length(options); i++)
{
	var option = options[i];
	option.x -= option.get_width() / 2;
	option.y -= get_height() / 2;
}
selected_option_index = -1;

select_current_option = function()
{
	options[selected_option_index].is_selected = true;
};

deselect_current_option = function()
{
	options[selected_option_index].is_selected = false;
};
