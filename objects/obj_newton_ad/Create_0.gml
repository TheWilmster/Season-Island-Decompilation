event_inherited();
ad_data = obj_data.newton_ads[type];
sprite_index = ad_data.sprite_index;
x = 320 - (sprite_width / 2);
y = 180 - (sprite_height / 2);
text_formatter_title = new TextFormatter(ad_data.title_font_name, c_white, 1, 1);
text_formatter_subtitle = new TextFormatter(ad_data.subtitle_font_name, c_white, 1, 1);

draw_self_sprite_transformed = function()
{
	var xscale = 1 + (0.1 * abs(sin(transformation_angle - pi)));
	var angle = 3 * sin(transformation_angle);
	var mat_transformation = matrix_build(0, 0, 0, 0, 0, angle, xscale, 1, 1);
	var mat_translation = matrix_build(x + (sprite_width / 2), y + (sprite_height / 2), 0, 0, 0, 0, 1, 1, 1);
	var mat = matrix_multiply(mat_transformation, mat_translation);
	matrix_set(2, mat);
	draw_sprite(sprite_index, image_index, -sprite_width / 2, -sprite_height / 2);
	matrix_set(2, matrix_build_identity());
};

draw = function()
{
	draw_self_sprite_transformed();
	if (title != "")
		text_formatter_title.get_formatted_text(title).transform(ad_data.title_xscale, ad_data.title_yscale, (ad_data.title_angle * 180) / pi).draw(x + ad_data.title_x, y + ad_data.title_y);
	if (subtitle != "")
		text_formatter_subtitle.get_formatted_text(subtitle).transform(ad_data.subtitle_xscale, ad_data.subtitle_yscale, (ad_data.subtitle_angle * 180) / pi).draw(x + ad_data.subtitle_x, y + ad_data.subtitle_y);
};

transformation_angle = 0;

state_idle = function()
{
	transformation_angle += 0.017453292519943295;
	if (transformation_angle >= (2 * pi))
		transformation_angle = 0;
};

state_jump = function()
{
	if ((x + sprite_width) < 0 || y > 360)
	{
		instance_destroy();
		exit;
	}
	x += xspd;
	y += yspd;
	yspd += yacc;
};

jump = function()
{
	state = state_jump;
};

xspd = -4;
yspd = -8;
yacc = 0.5;
state = state_idle;
