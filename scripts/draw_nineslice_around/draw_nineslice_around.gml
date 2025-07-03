function draw_nineslice_around(sprite_index, image_index, left, up, right, down, rot = 0, color = c_white, alpha = 1)
{
	var w = right - left;
	var h = down - up;
	var nineslice = sprite_get_nineslice(sprite_index);
	draw_sprite_ext(
    sprite_index,
    image_index,
    left - nineslice.left,
    up - nineslice.right,
    (w + nineslice.left + nineslice.right) / sprite_get_width(sprite_index),
    (h + nineslice.top + nineslice.bottom) / sprite_get_height(sprite_index),
    rot, color, alpha);
}
