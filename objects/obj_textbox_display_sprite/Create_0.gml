if (display_image_index != -1)
{
	image_speed = 0;
	image_index = display_image_index;
}
frame_nineslice = noone;

frame_with = function(_sprite_index, _image_index, _margin)
{
	self.frame_sprite_index = _sprite_index;
	self.frame_image_index = _image_index;
	frame_margin = _margin;
	frame_nineslice = sprite_get_nineslice(_sprite_index);
	return self;
};
