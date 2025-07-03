event_inherited();

advertise = function(_ad_type, _title, _subtitle)
{
	advertisement = instance_create_depth(0, 0, depth + 2, obj_newton_ad, 
	{
		type: _ad_type,
		title: _title,
		subtitle: _subtitle
	});
	advertisement.set_visibility(false);
	sprite_index = spr_newton_spinning;
	state = state_spinning;
	xspd = xspd_spin;
	image_speed = 1;
	image_xscale = 0.6;
	image_yscale = 0.6;
	x = 320 - (sprite_width / 2);
	y = 360 - sprite_height;
	obj_textbox.block();
};

xspd = 0;
xspd_spin = 7;
advertisement = undefined;

state_spinning = function()
{
	if ((x + sprite_width) >= 640)
	{
		image_speed = 0;
		sprite_index = spr_talksprites_newton_ad;
		emotion = 0;
		image_index = 0;
		state = state_idle;
		image_xscale = 0.6;
		image_yscale = 0.6;
		x = 640 - sprite_width;
		y = 360 - sprite_height;
		advertisement.set_visibility(true);
		obj_textbox.unblock();
		mover_shake = create_mover_shake(1, 1, 0);
		camera_shake(4, 4, 0.5);
		sfx_play(snd_punch);
		exit;
	}
	x += xspd;
};

advertise_stop = function()
{
	sprite_index = spr_newton_spinning;
	state = state_reverse_spinning;
	xspd = -xspd_spin;
	image_speed = 1;
	image_xscale = 0.6;
	image_yscale = 0.6;
	y = 360 - sprite_height;
	obj_textbox.block();
};

state_reverse_spinning = function()
{
	if (x <= (320 - (sprite_width / 2)))
	{
		image_speed = 0;
		sprite_index = spr_talksprites_newton;
		emotion = 0;
		image_index = 0;
		state = state_idle;
		image_xscale = 1;
		image_yscale = 1;
		x = 320 - (sprite_width / 2);
		y = 360 - sprite_height;
		obj_textbox.unblock();
		instance_destroy(mover_shake);
		advertisement.jump();
		camera_shake(4, 4, 0.5);
		audio_play_sound(snd_page_turn, 1, false);
		exit;
	}
	x += xspd;
};

mover_shake = undefined;
