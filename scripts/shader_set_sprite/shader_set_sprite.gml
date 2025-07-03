function shader_set_sprite(shader, texel_uniform, sprite_index, image_index)
{
	shader_set(shader);
	var _texture = sprite_get_texture(sprite_index, image_index);
	var _texture_width = texture_get_texel_width(_texture);
	var _texture_height = texture_get_texel_height(_texture);
	shader_set_uniform_f(texel_uniform, _texture_width, _texture_height);
}
