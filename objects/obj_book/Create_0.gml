event_inherited();
left_page_number = 0;
is_open = false;
open_book_sprites = [spr_book_spring, spr_book_summer, spr_book_fall, spr_book_winter];
last_left_page_number = 6;
is_dusty = true;
commented_cover = false;
commented_left_page_numbers = [];
comment_delay = 300;

get_cursor_tooltip = function()
{
	if (is_open)
	{
		if (is_cursor_on_left_page())
			return "Previous page";
		return "Next page";
	}
	return "Open";
};

can_flip_pages = true;

begin_story = function()
{
	alarm_set(0, -1);
	obj_sound_manager.textbox_sound_stop();
	obj_sound_manager.textbox_sound_fade_in(snd_cabin_rain);
	can_flip_pages = false;
	var fade = instance_create_depth(0, 0, Depth.Fade, obj_fade_manual, 
	{
		image_blend: c_black
	});
	fade.image_alpha_spd = 0.005;
	fade.fade_in();
	
	fade.callback_when_fade_in = function()
	{
		obj_menu_main.set_visibility(true);
		create_textbox("intro", function()
		{
			if (instance_exists(obj_fade_manual))
				obj_fade_manual.image_alpha_spd = 0.02;
		});
	};
};

go_forward = function()
{
	if (!is_open)
	{
		is_open = true;
		sprite_index = open_book_sprites[0];
		center();
		if (is_dusty)
		{
			is_dusty = false;
			dust();
			audio_play_sound(snd_dust, 1, false);
		}
		exit;
	}
	left_page_number += 2;
	sprite_index = open_book_sprites[(left_page_number / 2) % 4];
	if (left_page_number == last_left_page_number)
		begin_story();
};

center = function()
{
	x = 320 - (sprite_width / 2);
	y = 180 - (sprite_height / 2);
};

go_backward = function()
{
	if (left_page_number == 0)
	{
		is_open = false;
		sprite_index = spr_book_closed;
		center();
		exit;
	}
	left_page_number -= 2;
};

is_cursor_on_left_page = function()
{
	return obj_cursor.x < (x + (sprite_width / 2));
};

on_click = function()
{
	audio_play_sound(snd_page_turn, 1, false);
	if (is_open)
	{
		if (is_cursor_on_left_page())
			go_backward();
		else
			go_forward();
		if (!commented_cover)
			alarm_set(0, comment_delay);
	}
	else
	{
		go_forward();
	}
	if (!array_contains(commented_left_page_numbers, left_page_number))
		alarm_set(0, comment_delay);
	else
		alarm_set(0, -1);
};

can_be_clicked = function()
{
	return !global.is_game_paused && can_flip_pages;
};

text_formatter_cover_title = new TextFormatter(font_get_name(global.font_title), 47871, 1, 0);
text_formatter_cover_subtitle = new TextFormatter(font_get_name(fnt_pixel_operator_8), 47871, 1, 2);
text_formatter_page_number = new TextFormatter(font_get_name(fnt_pixel_operator_8), 3355511, 0, 2);
text_formatter_text = new TextFormatter(font_get_name(fnt_pixel_operator_8), 3355511, 0, 0);
cover_width = sprite_width - 20;
cover_height = sprite_height - 20;
seasonglobe_sprite_index = spr_seasonglobe;
margin = 4;

draw = function()
{
	draw_self();
	if (!is_open)
	{
		text_formatter_cover_title.get_formatted_text("Season Island").wrap(cover_width).draw(x + (cover_width / 2), y + 50);
		draw_sprite(seasonglobe_sprite_index, 0, (x + (cover_width / 2)) - (sprite_get_width(seasonglobe_sprite_index) / 2), (y + (cover_height / 2)) - (sprite_get_height(seasonglobe_sprite_index) / 2));
		exit;
	}
	var left_page_x = x + 68;
	var left_page_y = y + 50;
	var right_page_x = x + (sprite_width / 2) + 3;
	var right_page_y = left_page_y;
	var left_number = left_page_number;
	var right_number = left_page_number + 1;
	if (left_number > 0)
		text_formatter_page_number.get_formatted_text(string(left_number)).draw(left_page_x, left_page_y + 216);
	if (right_number > 0)
		text_formatter_page_number.get_formatted_text(string(right_number)).draw((right_page_x + 160) - text_formatter_page_number.text_width(string(right_number)), right_page_y + 216);
	switch (left_page_number)
	{
		case 0:
			text_formatter_text.get_formatted_text("[fa_center][fa_middle]Season Island").draw(right_page_x + 80, right_page_y + 108);
			break;
		case 2:
			text_formatter_text.get_formatted_text("[fa_center][fa_middle]A book about the nature of people\n[spr_seasonglobe_sketch]\nAnd the   seasons").wrap(160).draw(left_page_x + 80, left_page_y + 108);
			text_formatter_text.get_formatted_text("[fa_center][fa_middle]Season Island\n\nA story without an end.").draw(right_page_x + 80, right_page_y + 108);
			break;
		case 4:
			text_formatter_text.get_formatted_text("[fa_center][fa_middle][spr_sketch_dead_leaf]").wrap(160).draw(left_page_x + 80, left_page_y + 108);
			text_formatter_text.get_formatted_text("[fa_center][fa_middle]The moment you turn this page, you will be transported into a fictional world. As much as I'd have wished for its genuine existence, it is important you remember that this world is nothing but an illusion.\n\nThank you for understanding.").wrap(160 - (2 * margin)).draw(right_page_x + 80 + margin, right_page_y + 108);
			break;
		case 6:
			text_formatter_text.get_formatted_text("[fa_center][fa_middle][fnt_pixel_operator]Chapter 1\n\n[/f]Doomsday bouquet").draw(right_page_x + 80, right_page_y + 108);
			break;
	}
};

dust = function()
{
	repeat (6)
		instance_create_depth(x + random(sprite_width), y + random(sprite_height), depth - 1, obj_effect_dust);
};

center();
