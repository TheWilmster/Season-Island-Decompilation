event_inherited();

initialize = function()
{
	var actor = obj_data.get_actor(actor_id);
	if (!actor)
	{
		show_debug_message(string("Could not initialize taksprite with actor id {0}: actor not found.", actor_id));
		instance_destroy();
		exit;
	}
	var sprite = actor.sprite_index;
	if (sprite == -1)
	{
		show_debug_message(string("Could not initialize taksprite with actor id {0}: sprite index not found.", actor_id));
		instance_destroy();
		exit;
	}
	sprite_index = sprite;
	image_index = emotion;
	x = 320 - (sprite_width / 2);
	y = 360 - sprite_height;
};

emote = function(emotion)
{
	self.emotion = (emotion < image_number) ? emotion : 0;
	image_index = emotion;
};

fade_spd = 0.02;

state_idle = function()
{
};

state_fade_in = function()
{
	if (image_alpha >= 1)
	{
		image_alpha = 1;
		state = state_idle;
		with (obj_textbox)
			unblock();
		exit;
	}
	image_alpha += fade_spd;
};

state_fade_out = function()
{
	if (image_alpha <= 0)
	{
		with (obj_textbox)
			unblock();
		instance_destroy();
		exit;
	}
	image_alpha -= fade_spd;
};

state = state_idle;

fade_in = function()
{
	with (obj_textbox)
		block();
	image_alpha = 0;
	state = state_fade_in;
};

fade_out = function()
{
	with (obj_textbox)
		block();
	state = state_fade_out;
};

image_speed = 0;
initialize();

draw = function()
{
	draw_self();
};
