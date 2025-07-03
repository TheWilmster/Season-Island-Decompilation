rope_sprite_index = spr_well_stick_rope;
rope_image_index = 0;

change_rope_image_index = function(_speed)
{
	rope_image_index += _speed;
	if (rope_image_index < 0)
		rope_image_index += sprite_get_number(rope_sprite_index);
	if (rope_image_index > sprite_get_number(rope_sprite_index))
		rope_image_index -= sprite_get_number(rope_sprite_index);
};
