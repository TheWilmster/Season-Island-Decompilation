function Sprite3D(_3d_viewer, _sprite) constructor
{
	self.viewer_3d = _3d_viewer;
	x = 0;
	y = 0;
	z = 0;
	x_rot = 0;
	y_rot = 0;
	z_rot = 0;
	vertex_format = noone;
	self.sprite_index = _sprite;
	image_index = 0;
	sprite_width = sprite_get_width(_sprite);
	sprite_height = sprite_get_height(_sprite);
	image_alpha = 1;
	image_blend = c_white;
	
	function dist_player()
	{
		return distance_2_points(x, y, viewer_3d.camera_data.x, viewer_3d.camera_data.y);
	}
	
	function add_rectangle(_point1, _point2, _point3, _point4)
	{
		viewer_3d.vertex_buffer_add_rectangle(buffer, _point1, _point2, _point3, _point4, sprite_index, image_index, image_blend, image_alpha);
	}
	
	function get_texture()
	{
		return sprite_get_texture(sprite_index, image_index);
	}
	
	function get_cropped_width()
	{
		return sprite_width * array_get(sprite_get_uvs(sprite_index, image_index), 6);
	}
	
	function get_cropped_height()
	{
		return sprite_height * array_get(sprite_get_uvs(sprite_index, image_index), 7);
	}
	
	function place_on_ground()
	{
		z = -(get_cropped_height() / 2);
	}
	
	vertex_format = viewer_3d.vertex_format;
	buffer = vertex_create_buffer();
	vertex_begin(buffer, vertex_format);
	var _cropped_width = get_cropped_width();
	var _cropped_height = get_cropped_height();
	add_rectangle([0, _cropped_width / 2, _cropped_height / 2], [0, _cropped_width / 2, _cropped_height / -2], [0, _cropped_width / -2, _cropped_height / 2], [0, _cropped_width / -2, _cropped_height / -2]);
	vertex_end(buffer);
	array_push(viewer_3d.sprites_3d, self);
	
	function transformation_matrix()
	{
		return matrix_build(x, y, z, (x_rot * 180) / pi, (y_rot * 180) / pi, (z_rot * 180) / pi, 1, 1, 1);
	}
	
	function destroy()
	{
		vertex_delete_buffer(buffer);
	}
}
