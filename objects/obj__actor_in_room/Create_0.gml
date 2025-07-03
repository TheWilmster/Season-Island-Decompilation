event_inherited();
next_dialogue_node = "";

talk = function(node)
{
	self.next_dialogue_node = node;
	fade_out();
};

talk_immediate = function(node)
{
	image_alpha = 0;
	create_textbox(node, fade_in);
};

fade_spd = 0.05;

state_idle = function()
{
};

state_fade_in = function()
{
	if (image_alpha >= 1)
	{
		image_alpha = 1;
		state = state_idle;
		exit;
	}
	image_alpha += fade_spd;
};

state_fade_out = function()
{
	if (image_alpha <= 0)
	{
		global.can_click = true;
		obj_menu_main.set_visibility(true);
		create_textbox(next_dialogue_node, self.fade_in);
		state = state_idle;
		exit;
	}
	image_alpha -= fade_spd;
};

state = state_idle;

fade_in = function()
{
	state = state_fade_in;
};

fade_out = function()
{
	global.can_click = false;
	obj_menu_main.set_visibility(false);
	state = state_fade_out;
};
