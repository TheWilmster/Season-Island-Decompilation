event_inherited();

draw = function()
{
	draw_self();
};

set_visibility(false);

spin_manually = function()
{
	spin_spd = spin_spd_manual;
	state = state_spin_manually;
};

spin_automatically = function()
{
	is_spinning_automatically = true;
	state = state_spin_automatically;
};

spin_spd = 0;
spin_spd_manual = 10;
spin_decc = 0.1;
spin_spd_auto = 4;
dir = 1;

on_click = function()
{
	if (!is_spinning_automatically)
		spin_manually();
};

state_idle = function()
{
};

state_spin_manually = function()
{
	if (spin_spd <= 0)
	{
		state = state_idle;
		exit;
	}
	image_angle += (spin_spd * dir);
	spin_spd -= spin_decc;
};

state_spin_automatically = function()
{
	image_angle += (spin_spd_auto * dir);
};

state = state_idle;
is_spinning_automatically = false;
