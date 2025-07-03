event_inherited();

draw = function()
{
	draw_self();
};

xspd = -1;
shake_delays = [24, 24, 180];
shake_delay_index = 0;

state_idle = function()
{
	if (alarm_get(0) == -1)
	{
		alarm_set(0, shake_delays[shake_delay_index]);
		shake_delay_index = (shake_delay_index + 1) % array_length(shake_delays);
	}
};

state_moving = function()
{
	x += xspd;
	if ((x + sprite_width) < 0)
	{
		obj_menu_main.set_visibility(true);
		instance_destroy();
		obj_sound_manager.global_sound_stop();
		global.can_click = true;
	}
};

move = function()
{
	sprite_index = spr_spring_shocked;
	alarm_set(0, -1);
	state = state_moving;
};

state = state_idle;
name = "???";
on_click_with_item();
on_click_without_item();
