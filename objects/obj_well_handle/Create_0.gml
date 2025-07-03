event_inherited();
name = "Handle";
init_x = x;
init_y = y;
rope_length = 0;
rope_length_previous = rope_length;

get_cursor_tooltip = function()
{
	return "";
};

draw = function()
{
	var mat_angle = matrix_build(0, 0, 0, 0, 0, (angle * 180) / pi, 1, 1, 1);
	var mat_translate = matrix_build(x, y, 0, 0, 0, 0, 1, 1, 1);
	var mat = matrix_multiply(mat_angle, mat_translate);
	matrix_set(2, mat);
	var i = rope_length - sprite_get_height(spr_well_rope);
	while (i > 0)
	{
		draw_sprite(spr_well_rope, 0, 0, i - rope_length);
		i -= sprite_get_height(spr_well_rope);
	}
	var rope_end_height = rope_length % sprite_get_height(spr_well_rope);
	draw_sprite_part(spr_well_rope, 0, 0, sprite_get_height(spr_well_rope) - rope_end_height, sprite_get_width(spr_well_rope), rope_end_height, -sprite_get_width(spr_well_rope) / 2, -rope_length);
	matrix_set(2, matrix_build_identity());
	draw_self();
};

get_rope_length = function()
{
	var distance_to_cursor = distance_2_points(init_x, init_y, x, y);
	return min(distance_to_cursor, rope_length + obj_well_hook.rope_length);
};

angle = ((image_angle * pi) / 180) - pi;
rope_x = x;
rope_y = y;
rope_animation_speed = 0.3;
