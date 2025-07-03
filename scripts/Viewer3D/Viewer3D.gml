function Viewer3D(_x, _y, _width, _height) constructor
{
	self.surface_x = _x;
	self.surface_y = _y;
	self.surface_width = _width;
	self.surface_height = _height;
	surface = -1;
	slide_spd = 8;
	camera = -1;
	wall_sprite_index = noone;
	vertex_buffer_data_array = [];
	fov = 0;
	default_fov = 60;
	min_fov = 20;
	sprites_3d = [];
	x = 0;
	y = 0;
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_colour();
	vertex_format_add_texcoord();
	vertex_format = vertex_format_end();
	camera = camera_create();
	camera_data = 
	{
		x: 0,
		y: 0,
		z: 0,
		a: 0,
		p: 0
	};
	var _ = self;
	fov = default_fov;
	
	function fov_zoom(amount)
	{
		fov = clamp(fov, min_fov, fov - amount);
	}
	
	function fov_reset()
	{
		fov = default_fov;
	}
	
    function vertex_buffer_add_point(_buffer, _point, _color, _alpha, _u, _v) {
        vertex_position_3d(_buffer, _point[0], _point[1], _point[2]);
		vertex_colour(_buffer, _color, _alpha);
		vertex_texcoord(_buffer, _u, _v);
    }
    
	function vertex_buffer_add_rectangle(_buffer, _point1, _point2, _point3, _point4, _sprite_index, _image_index, _color = c_white, _alpha = 1)
	{
		var _sprite_uvs = sprite_get_uvs(_sprite_index, _image_index);
        
        vertex_buffer_add_point(_buffer, _point1, _color, _alpha, _sprite_uvs[UV_Data.Left], _sprite_uvs[UV_Data.Bottom]);
        vertex_buffer_add_point(_buffer, _point2, _color, _alpha, _sprite_uvs[UV_Data.Left], _sprite_uvs[UV_Data.Top]);
        vertex_buffer_add_point(_buffer, _point3, _color, _alpha, _sprite_uvs[UV_Data.Right], _sprite_uvs[UV_Data.Bottom]);
        vertex_buffer_add_point(_buffer, _point2, _color, _alpha, _sprite_uvs[UV_Data.Left], _sprite_uvs[UV_Data.Top]);
        vertex_buffer_add_point(_buffer, _point4, _color, _alpha, _sprite_uvs[UV_Data.Right], _sprite_uvs[UV_Data.Top]);
        vertex_buffer_add_point(_buffer, _point3, _color, _alpha, _sprite_uvs[UV_Data.Right], _sprite_uvs[UV_Data.Bottom]);
	}
	
	function vertex_buffer_add_prism(_buffer, _point1, _point2, _point3, _point4, _point5, _point6, _point7, _point8, _sprite_index, _image_index)
	{
		vertex_buffer_add_rectangle(_buffer, _point1, _point2, _point3, _point4, _sprite_index, _image_index);
		vertex_buffer_add_rectangle(_buffer, _point3, _point4, _point7, _point8, _sprite_index, _image_index);
		vertex_buffer_add_rectangle(_buffer, _point7, _point8, _point5, _point6, _sprite_index, _image_index);
		vertex_buffer_add_rectangle(_buffer, _point5, _point6, _point1, _point2, _sprite_index, _image_index);
		vertex_buffer_add_rectangle(_buffer, _point6, _point8, _point2, _point4, _sprite_index, _image_index);
		vertex_buffer_add_rectangle(_buffer, _point5, _point7, _point1, _point3, _sprite_index, _image_index);
	}
	
	function vertex_buffer_data(_viewer, _buffer, _vformat, _sprite_index, _image_index, _color, _alpha) constructor
	{
		buffer = _buffer;
		vertex_format = _vformat;
		sprite_index = _sprite_index;
		image_index = _image_index;
		image_blend = _color;
		image_alpha = _alpha;
		active = true;
		transformation_matrix = matrix_build_identity();
		viewer = _viewer;
		array_push(viewer.vertex_buffer_data_array, self);
		
		function add_rectangle(_point1, _point2, _point3, _point4)
		{
			viewer.vertex_buffer_add_rectangle(buffer, _point1, _point2, _point3, _point4, sprite_index, image_index, image_blend, image_alpha);
		}
		
		function buffer_begin()
		{
			vertex_begin(buffer, vertex_format);
		}
		
		function buffer_end()
		{
			vertex_end(buffer);
		}
		
		function get_texture()
		{
			return sprite_get_texture(sprite_index, image_index);
		}
	}
	
	function destroy()
	{
		surface_free(surface);
		camera_destroy(camera);
	}
	
	function draw()
	{
		if (!surface_exists(surface)) {
			surface = surface_create(surface_width, surface_height);
        }
		var _ztestenable = gpu_get_ztestenable();
		var _zwriteenable = gpu_get_zwriteenable();
		var _alphatestenable = gpu_get_alphatestenable();
		var _alphatestref = gpu_get_alphatestref();
        gpu_set_ztestenable(true);
		gpu_set_zwriteenable(true);
		gpu_set_alphatestenable(true);
		gpu_set_alphatestref(10);
        
		surface_set_target(surface);
		draw_clear_alpha(c_black, 0);
        
		camera_set_view_mat(camera, matrix_build_lookat(camera_data.x, camera_data.y, camera_data.z, camera_data.x + cos(camera_data.a), camera_data.y - sin(camera_data.a), camera_data.z - sin(camera_data.p), 0, 0, 1));
		camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(fov, surface_width / surface_height, 1, 32000));
		camera_apply(camera);
        
		array_foreach(sprites_3d, function(_vertex_data)
		{
			var transformation_matrix = _vertex_data.transformation_matrix();
			matrix_set(2, transformation_matrix);
			vertex_submit(_vertex_data.buffer, pr_trianglelist, _vertex_data.get_texture());
			matrix_set(2, matrix_build_identity());
		});
		array_foreach(vertex_buffer_data_array, function(_vertex_data, _unused)
		{
			if (!_vertex_data.active)
				exit;
			matrix_set(2, _vertex_data.transformation_matrix);
			vertex_submit(_vertex_data.buffer, pr_trianglelist, _vertex_data.get_texture());
			matrix_set(2, matrix_build_identity());
		});
		surface_reset_target();
        
		gpu_set_ztestenable(_ztestenable);
		gpu_set_zwriteenable(_zwriteenable);
		gpu_set_alphatestenable(_alphatestenable);
		gpu_set_alphatestref(_alphatestref);
        
        draw_surface(surface, x + surface_x, y + surface_y);
	}
}
