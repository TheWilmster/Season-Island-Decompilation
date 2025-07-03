state_idle = function()
{
};

image_blend = c_white;
image_alpha = 0;
image_alpha_spd = 0.005;

state_fade_out = function()
{
	image_alpha -= image_alpha_spd;
	if (image_alpha <= 0)
		instance_destroy();
};

state_fade_in = function()
{
	image_alpha += image_alpha_spd;
	if (image_alpha >= 1)
	{
		if (callback_when_fade_in)
			callback_when_fade_in();
		state = state_idle;
	}
};

state = state_idle;

fade_out = function()
{
	state = state_fade_out;
};

fade_in = function()
{
	state = state_fade_in;
};

callback_when_fade_in = undefined;
