event_inherited();
name = "Apple";

on_click_without_item = function()
{
	create_textbox("apple");
};

looseness_max = 100;

on_click_with_item = function()
{
};

add_looseness = function(amt)
{
	looseness += amt;
	if (looseness >= looseness_max)
	{
		fall();
		exit;
	}
	var looseness_text_string = string("[c_yellow][wave]{0}% LOOSE!!", floor(looseness));
	instance_create_depth(x, y - 2, depth - 2, obj_text_disappearing, 
	{
		text: looseness_text_string
	});
};

fall = function()
{
	instance_destroy(obj_slingshot);
	state = state_falling;
	obj_menu_main.set_visibility(false);
	obj_sound_manager.global_sound_pause();
	global.can_click = false;
};

yspd = 0;
xspd = 0;
y_acceleration = 0.1;
did_bounce = false;

state_idle = function()
{
};

state_falling = function()
{
	yspd += y_acceleration;
	y += yspd;
	x += xspd;
	if (!did_bounce && place_meeting(x, y, obj_newton_holding_knife))
	{
		event_flag_set(Event.KillerDefeat);
		did_bounce = true;
		obj_newton_holding_knife.fall();
		yspd = -3;
		xspd = 1.5;
		depth--;
	}
	if (y > 360)
	{
		obj_spring_scared.move();
		instance_destroy();
	}
};

looseness = 0;
state = state_idle;

draw = function()
{
	draw_self();
};
