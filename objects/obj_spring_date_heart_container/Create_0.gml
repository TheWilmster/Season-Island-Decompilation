heart_liquid_sprite_index = spr_spring_date_heart_liquid;
heart_draw_scale_min = 0.5;
heart_draw_scale = heart_draw_scale_min;
heart_draw_scale_max = 0.8;
heart_draw_scale_angle = 0;
heart_draw_scale_angle_spd = 2 * RAD;
heart_particle_weight_min = 0.1;
heart_particle_weight_max = 0.2;
heart_draw_angle = 20;
heart_draw_scale_meter_bonus_max = 1;
text_formatter = new TextFormatter("fnt_pixel_operator_hbsc_outline_8dir", c_white, 1, 1);

create_falling_sprite_heart = function(_sprite_index)
{
	var xspeed_max = 3;
	var heart_particle_weight = random_range(heart_particle_weight_min, heart_particle_weight_max);
	create_falling_sprite(_sprite_index, 0, x, y, depth - 2, random_range(-xspeed_max, xspeed_max), noone, heart_particle_weight);
};

fill_meter = function(amt)
{
	if (amt == 0)
		exit;
	meter_percentage += amt;
	if (amt > 0)
	{
		repeat (ceil(amt/ 10))
			create_falling_sprite_heart(spr_spring_date_heart_falling);
	}
	else
	{
		create_mover_shake(6, 6, 0.4);
		repeat (ceil(abs(amt) / 10))
			create_falling_sprite_heart(spr_spring_date_heart_falling_broken);
	}
};

get_heart_liquid_image_index = function()
{
	if (meter_percentage < 20)
		return 0;
	else if (meter_percentage < 40)
		return 1;
	else if (meter_percentage < 60)
		return 2;
	else if (meter_percentage < 100)
		return 3;
	return 4;
};

draw_heart_liquid = function()
{
	draw_sprite_ext(heart_liquid_sprite_index, get_heart_liquid_image_index(), x, y, heart_draw_scale, heart_draw_scale, heart_draw_angle, c_white, 1);
};

draw_heart = function()
{
	if (meter_percentage > 0)
		draw_heart_liquid();
	var sprite_index_heart_container = (meter_percentage < 0) ? spr_spring_date_heart_container_broken : spr_spring_date_heart_container;
	draw_sprite_ext(sprite_index_heart_container, 0, x, y, heart_draw_scale, heart_draw_scale, heart_draw_angle, c_white, 1);
	heart_draw_scale = (heart_draw_scale_meter_bonus_max * clamp(meter_percentage / 100, 0, 1)) + heart_draw_scale_min + ((heart_draw_scale_max - heart_draw_scale_min) * abs(sin(heart_draw_scale_angle)));
	heart_draw_scale_angle += heart_draw_scale_angle_spd;
	if (heart_draw_scale_angle > (2 * pi))
		heart_draw_scale_angle -= (2 * pi);
};

meter_text_scale = 1.4;

draw_meter = function()
{
	text_formatter.get_formatted_text(string("{0}%", meter_percentage)).transform(meter_text_scale, meter_text_scale, heart_draw_angle).draw(x, y);
};

yspd_rising = -2;

destroy = function()
{
	state = state_rising;
};

state_idle = function()
{
};

state_rising = function()
{
	y += yspd_rising;
	if (y < (-sprite_get_height(spr_spring_date_heart_container) * heart_draw_scale))
		instance_destroy();
};

state = state_idle;
