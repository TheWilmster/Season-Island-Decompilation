event_inherited();
sfx_sound = snd_spring_anime_blush;
image_alpha = 0;
image_alpha_spd = 0.01;

state_idle = function()
{
};

state_fade_in = function()
{
	if (image_alpha >= 1)
	{
		image_alpha = 1;
		state = state_idle;
	}
	image_alpha += image_alpha_spd;
};

state_fade_out = function()
{
	if (image_alpha < 0)
	{
		instance_destroy();
		exit;
	}
	image_alpha -= image_alpha_spd;
};

create_mover_shake(1, 1, 0);
state = state_fade_in;

destroy = function()
{
	state = state_fade_out;
};
