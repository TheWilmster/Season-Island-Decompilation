var draw_x = 320 - (sprite_width / 2);
var draw_y = (obj_textbox.y / 2) - (sprite_height / 2);
if (frame_sprite_index)
	draw_sprite_stretched(frame_sprite_index, frame_image_index, draw_x - (frame_margin + frame_nineslice.left), draw_y - (frame_margin + frame_nineslice.top), sprite_get_width(sprite_index) + (2 * frame_margin) + frame_nineslice.left + frame_nineslice.right, sprite_get_height(sprite_index) + (2 * frame_margin) + frame_nineslice.top + frame_nineslice.bottom);
draw_sprite(sprite_index, image_index, draw_x, draw_y);
