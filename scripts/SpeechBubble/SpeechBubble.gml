function SpeechBubble() constructor
{
	is_shocked = false;
	tail_is_visible = true;
	outline_shader = sh_outline_black_2px;
	shake_x = 0;
	shake_y = 0;
	shake_step = 0;
	
	function shake(x = 3, y = 3, amt = 0.2)
	{
		shake_x = x;
		shake_y = y;
		shake_step = amt;
	}
	
	function set_tail_visibility(flag)
	{
		tail_is_visible = flag;
	}
	
	function set_visibility(flag)
	{
		is_visible = flag;
	}
	
	text_formatter = new TextFormatter(font_get_name(global.font_textbox), 0, 1, 1);
	uniform_handle = shader_get_uniform(sh_outline_red, "texture_Pixel");
	draw_space_width = 32;
	draw_space_height = 32;
	
	function draw(x, y, width, height, tail_xscale, tail_yscale)
	{
		var speech_bubble_sprite = (shake_step > 0 || is_shocked) ? spr_speech_bubble_shock : spr_speech_bubble;
		var speech_bubble_sprite_width = sprite_get_width(speech_bubble_sprite);
		var speech_bubble_sprite_height = sprite_get_height(speech_bubble_sprite);
		var _image_xscale = max(1, width / draw_space_width);
		var _image_yscale = max(1, height / draw_space_height);
		var speech_bubble_x = x - (((speech_bubble_sprite_width - draw_space_width) / 2) * _image_xscale);
		var speech_bubble_y = y - (((speech_bubble_sprite_height - draw_space_height) / 2) * _image_yscale);
		if (shake_step > 0)
		{
			speech_bubble_x += irandom_range(-shake_y, shake_y);
			speech_bubble_y += irandom_range(-shake_y, shake_y);
			shake_x = max(0, shake_x - shake_step);
			shake_y = max(0, shake_y - shake_step);
			if (shake_x == 0 && shake_y == 0)
				shake_step = 0;
		}
		shader_set_sprite(outline_shader, uniform_handle, speech_bubble_sprite, 0);
		draw_sprite_ext(speech_bubble_sprite, 0, speech_bubble_x, speech_bubble_y, _image_xscale, _image_yscale, 0, c_white, 1);
		shader_reset();
		if (tail_is_visible)
		{
			var _speech_bubble_tail_sprite_index = spr_speech_bubble_tail;
			var center_x = speech_bubble_x + ((sprite_get_width(speech_bubble_sprite) * _image_xscale) / 2);
			var center_y = speech_bubble_y + ((sprite_get_height(speech_bubble_sprite) * _image_yscale) / 2);
			var _speech_bubble_tail_xscale = distance_2_points(center_x, center_y, tail_xscale, tail_yscale) / sprite_get_width(_speech_bubble_tail_sprite_index);
			var _speech_bubble_tail_angle = array_get(coords_get_polar(center_x - tail_xscale, center_y - tail_yscale), DIR);
			shader_set_sprite(outline_shader, uniform_handle, _speech_bubble_tail_sprite_index, 0);
			draw_sprite_ext(_speech_bubble_tail_sprite_index, 0, tail_xscale, tail_yscale, _speech_bubble_tail_xscale, 1, (1 / RAD) * _speech_bubble_tail_angle, c_white, 1);
			shader_reset();
		}
		draw_sprite_ext(speech_bubble_sprite, 0, speech_bubble_x, speech_bubble_y, _image_xscale, _image_yscale, 0, c_white, 1);
	}
	
	function draw_centered(x, y, width, height, tail_xscale, tail_yscale)
	{
		draw(x - (width / 2), y - (height / 2), width, height, tail_xscale, tail_yscale);
	}
	
	function draw_centered_with_text(x, y, str, tail_xscale, tail_yscale)
	{
		var text_width = max(draw_space_width, text_formatter.text_width(str));
		var text_height = max(draw_space_height, text_formatter.text_height(str));
		draw_centered(x, y, text_width, text_height, tail_xscale, tail_yscale);
		text_formatter.get_formatted_text(str).draw(x + irandom_range(-shake_x, shake_x), y + irandom_range(-shake_y, shake_y));
	}
}
