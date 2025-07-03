event_inherited();
cursor_distance_start_chase = 10;
cursor_distance_no_movement = 5;
shock_delay = 90;
chase_delay = 30;
pet_delay = 120;
yawn_delay_min = 180;
yawn_delay_max = 600;
spd_min = 0.01;
spd_max = 2;
pet_counter = 0;
pet_value_blush = 50;
pet_value_max = 80;
meow_chance = 0.4;
var body = self;
head = instance_create_depth(x, y, depth - 2, obj_tere_head, 
{
	body: body
});

state_chase = function()
{
	var distance_to_cursor = distance_to_object(obj_cursor);
	if (distance_to_cursor < cursor_distance_no_movement)
	{
		state = state_idle;
		image_speed = 0;
		image_index = 0;
		exit;
	}
	var spd = clamp((0.2 * distance_to_cursor) / cursor_distance_start_chase, spd_min, spd_max);
	image_speed = 1 + (spd / spd_max);
	var target_x = obj_cursor.x - (sprite_width / 2);
	var target_y = obj_cursor.y - (sprite_height / 2);
	var angle = arctan2(target_x - x, target_y - y) + (90 * RAD);
	x -= (cos(angle) * spd);
	y += (sin(angle) * spd);
	if (obj_cursor.x < x && image_xscale > 0)
	{
		image_xscale = -image_xscale;
		x -= sprite_width;
		head.image_xscale = -head.image_xscale;
	}
	else if (obj_cursor.x > (x + sprite_width) && image_xscale < 0)
	{
		image_xscale = -image_xscale;
		x -= sprite_width;
		head.image_xscale = -head.image_xscale;
	}
};

state_idle = function()
{
	if (distance_to_object(obj_cursor) < cursor_distance_start_chase)
	{
		if (alarm_is_expired(2))
			alarm_set(2, pet_delay);
	}
	else
	{
		alarm_set(2, -1);
		state = state_chase;
		image_index = 0;
		image_speed = 1;
	}
};

state_shocked = function()
{
	if (alarm_is_expired(1))
		alarm_set(1, chase_delay);
	if (distance_to_object(obj_cursor) < cursor_distance_start_chase)
	{
		if (!alarm_is_expired(1))
		{
			alarm_set(1, -1);
			state = state_pet;
			head.sprite_index = spr_tere_head_blush;
			sprite_index = spr_tere_body_loafing;
			image_speed = 1;
		}
	}
};

state_pet = function()
{
	if (distance_to_object(obj_cursor) >= cursor_distance_start_chase)
	{
		if (alarm_is_expired(0))
			alarm_set(0, shock_delay);
	}
	else if (!alarm_is_expired(0))
	{
		alarm_set(0, -1);
	}
	if (obj_cursor.get_dx() != 0 || (obj_cursor.get_dy() != 0 && pet_counter < pet_value_max))
	{
		pet_counter++;
		if (pet_counter == pet_value_blush)
		{
			head.sprite_index = spr_tere_head_blush;
			audio_sound_gain(snd_purr, 1, 1000);
		}
	}
	else if (pet_counter > 0)
	{
		pet_counter--;
		if (pet_counter < pet_value_blush)
		{
			head.sprite_index = spr_tere_head_eyes_closed;
			audio_sound_gain(snd_purr, 0, 1000);
		}
	}
	if (pet_counter == 0)
	{
		if (alarm_is_expired(3))
			alarm_set(3, irandom_range(yawn_delay_min, yawn_delay_max));
	}
};

state_yawning = function()
{
	if (floor(head.image_index) == (head.image_number - 1))
	{
		head.sprite_index = (pet_counter >= pet_value_blush) ? spr_tere_head_blush : spr_tere_head_eyes_closed;
		state = state_pet;
	}
};

state = state_idle;
cursor_sprite_arrow_default = obj_cursor.sprite_arrow;
cursor_sprite_hand_default = obj_cursor.sprite_hand;
obj_cursor.sprite_arrow = spr_cursor_mouse_arrow;
obj_cursor.sprite_hand = spr_cursor_mouse_hand;

draw = function()
{
	draw_self();
};

do_follow_mouse = false;
mouse_follow_offset_x = 0;
mouse_follow_offset_y = 0;

on_mouse_pressed = function()
{
	sfx_play(snd_mouse_squeak, random_range(0.9, 1.1));
	do_follow_mouse = true;
	alarm_set(0, -1);
	alarm_set(1, -1);
	alarm_set(2, -1);
	alarm_set(3, -1);
	mouse_follow_offset_x = x - obj_cursor.x;
	mouse_follow_offset_y = y - obj_cursor.y;
	image_speed = 1;
	sprite_index = spr_tere_body_picked_up;
	head.sprite_index = spr_tere_head;
};

on_mouse_released = function()
{
	do_follow_mouse = false;
	sprite_index = spr_tere_body;
	image_speed = 0;
	image_index = 0;
	state = state_idle;
};

sfx_play(snd_meow);
