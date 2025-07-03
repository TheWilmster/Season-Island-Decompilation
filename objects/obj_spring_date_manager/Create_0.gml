heart_x = 70;
heart_y = 100;
depth = Depth.Particle;
instance_create_depth(heart_x, heart_y, depth, obj_spring_date_heart_container, 
{
	meter_percentage: meter_percentage_init
});
border_sprite_index = spr_spring_date_border;
border_offset = 60;

draw_border = function()
{
	var w = sprite_get_width(border_sprite_index);
	var h = sprite_get_height(border_sprite_index);
	draw_sprite_stretched(spr_spring_date_border, 0, -border_offset, -border_offset, 640 + (border_offset * 2), 360 + (border_offset * 2));
};

stop_date = function()
{
	var meter_percentage = obj_spring_date_heart_container.meter_percentage;
	obj_spring_date_heart_container.destroy();
	obj_save_file_manager.data.spring_date_score = meter_percentage;
	state = state_removing_border;
};

destroy = function()
{
	state = state_removing_border;
};

border_lerp_amount = 0.1;

state_show_border = function()
{
	border_offset = lerp(border_offset, 0, border_lerp_amount);
	if (border_offset <= border_lerp_amount)
	{
		border_offset = 0;
		state = state_idle;
	}
};

state_idle = function()
{
};

state_removing_border = function()
{
	if (border_offset == (sprite_get_width(border_sprite_index) / 3))
		state = state_idle;
	border_offset++;
};

state = state_show_border;

fill_meter = function(amt)
{
	obj_spring_date_heart_container.fill_meter(amt);
};
