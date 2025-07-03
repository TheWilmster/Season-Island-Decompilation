event_inherited();

talksprite_create = function(actor_name, emotion)
{
	var actor_id = actor_get_from_string(actor_name);
	if (actor_id == undefined)
		exit;
	var talksprite_type;
	switch (actor_id)
	{
		case Actor.Newton:
			talksprite_type = obj_talksprite_newton;
			break;
		case Actor.Spring:
			talksprite_type = obj_talksprite_spring;
			break;
		default:
			talksprite_type = obj_talksprite_default;
			break;
	}
	talksprite = instance_create_depth(x, y, Depth.Actor, talksprite_type, 
	{
		actor_id: actor_id,
		emotion: emotion
	});
};

talksprite_destroy = function()
{
	instance_destroy(talksprite);
};

talksprite_fade_in = function(actor_name, emotion)
{
	if (instance_exists(talksprite))
	{
		talksprite.emote(emotion);
		exit;
	}
	talksprite_create(actor_name, emotion);
	if (!instance_exists(talksprite))
		exit;
	talksprite.fade_in();
};

talksprite_fade_out = function()
{
	if (!instance_exists(talksprite))
		exit;
	talksprite.fade_out();
};

talksprite_emote = function(emotion)
{
	if (!instance_exists(talksprite))
		exit;
	talksprite.emote(emotion);
};

text_color = c_white;
text_font_name = "fnt_textbox_shadow";
text_formatter = new TextFormatter(text_font_name, text_color, 0, 0);
text_formatter_arrow = new TextFormatter(text_font_name, text_color, 0, 1);
text_formatter_label = new TextFormatter(font_get_name(fnt_pixel_operator_8), text_color, 0, 0);
textbox_alpha = 0.8;
textbox_color = 0;
text_spd = 0.4;
talking_actor_id = -1;
was_main_menu_visible = instance_exists(obj_menu_main) ? obj_menu_main.is_visible : false;
with (obj_menu_main)
	set_visibility(false);
textbox_arrow_offset_x = 4;
arrow_sprite = spr_dialogue_arrow;
arrow_sprite_name = sprite_get_name(arrow_sprite);
text_width_max = 380;
text_height_max = 68;
margin = 2;
textbox_area_width = text_width_max + (2 * margin) + sprite_get_width(spr_dialogue_arrow) + textbox_arrow_offset_x;
textbox_area_height = text_height_max + (2 * margin);
textbox_area_x = 320 - (textbox_area_width / 2);
textbox_area_y = 360 - textbox_area_height;
x = textbox_area_x;
y = textbox_area_y;
text_x = textbox_area_x + margin;
text_y = textbox_area_y + margin;

cursor_meeting = function(x, y)
{
	return point_in_rectangle(x, y, textbox_area_x, textbox_area_y, textbox_area_x + textbox_area_width, textbox_area_y + textbox_area_height);
};

can_be_clicked = function()
{
	return !is_blocked() && !instance_exists(obj_menu_textbox_options);
};

get_width = function()
{
	return textbox_area_width;
};

get_height = function()
{
	return textbox_area_height;
};

typist = scribble_typist().in(text_spd, 0);
display_sprite = noone;
text_speed_default = 0.5;
text_speed_fast = 2;

emote_all_actors_from_string = function(key)
{
	var emotion = variable_struct_get(emote_strings, key);
	if (emotion == undefined)
	{
		show_debug_message("WARNING: Unrecognized emotion \"" + key + "\".");
		exit;
	}
	emote_all_actors(emotion);
};

create_display_sprite = function(_sprite_index, _image_index = -1)
{
	if (instance_exists(display_sprite))
		instance_destroy(display_sprite);
	display_sprite = instance_create_depth(0, 0, Depth.TBDisplay, obj_textbox_display_sprite, 
	{
		sprite_index: _sprite_index,
		display_image_index: _image_index
	});
	return display_sprite;
};

frame_display_sprite = function(_sprite_index, _image_index = -1, _margin = 0)
{
	display_sprite.frame_with(_sprite_index, _image_index, _margin);
};

textbox_area_angle = 0;
textbox_area_angle_angle = 0;

destroy_display_sprite = function()
{
	instance_destroy(display_sprite);
};

set_text_speed = function(speed)
{
	if (speed > 0)
		typist.in(speed, 0);
};

draw_ellipse_angle = function(x, y, width, height, angle)
{
	var ellipse_r1 = width / sqrt(2);
	var ellipse_r2 = height / sqrt(2);
	var ellipse_x1 = x - (ellipse_r1 - (width / 2));
	var ellipse_y1 = y - (ellipse_r2 - (height / 2));
	var mat_trf_rot_z = matrix_build(0, 0, 0, 0, 0, (angle * 180) / pi, 1, 1, 1);
	var mat_trf_translation_x_y = matrix_build(ellipse_x1 + ellipse_r1, ellipse_y1 + ellipse_r2, 0, 0, 0, 0, 1, 1, 1);
	var mat = matrix_multiply(mat_trf_rot_z, mat_trf_translation_x_y);
	matrix_set(2, mat);
	draw_ellipse_color(-ellipse_r1, -ellipse_r2, ellipse_r1, ellipse_r2, c_black, c_black, false);
	matrix_set(2, matrix_build_identity());
};

function draw_textbox()
{
	textbox_area_angle_angle += 0.25 * RAD;
	textbox_area_angle = (sin(textbox_area_angle_angle) * pi) / 180;
	var alpha = draw_get_alpha();
	draw_set_alpha(textbox_alpha);
	draw_ellipse_angle(textbox_area_x, textbox_area_y, textbox_area_width, textbox_area_height, textbox_area_angle);
	draw_set_alpha(alpha);
}

typist_page = 0;

function draw_textbox_arrow()
{
	text_formatter_arrow.get_formatted_text(string("[{0}]", arrow_sprite_name)).draw(textbox_area_x + text_width_max + textbox_arrow_offset_x, textbox_area_y + (textbox_area_height / 2));
}

draw_label = function()
{
	if (speaker == "")
		exit;
	var label_scale = 1.2;
	var label_text = array_contains(hidden_actors, talking_actor_id) ? "???" : speaker;
	var label_width = label_scale * text_formatter_label.text_width(label_text);
	var label_height = label_scale * text_formatter_label.text_height(label_text);
	var label_x = textbox_area_x - 30;
	var label_y = textbox_area_y - 14;
	var label_angle = 6 * RAD;
	var alpha = draw_get_alpha();
	draw_set_alpha(textbox_alpha);
	draw_ellipse_angle(label_x, label_y, label_width, label_height, label_angle);
	draw_set_alpha(alpha);
	text_formatter_label.get_formatted_text(label_text).transform(label_scale, label_scale, (label_angle * 180) / pi).draw(label_x, label_y + 3);
};

scribble_text_element = undefined;

function state_typing()
{
	draw_textbox();
	draw_label();
	scribble_text_element = text_formatter.get_formatted_text(text).wrap(text_width_max, text_height_max);
	scribble_text_element.page(typist_page).draw(text_x, text_y, typist);
	if (is_done_typing())
	{
		if (ChatterboxIsStopped(chatterbox))
		{
			draw_textbox_arrow();
		}
		else if (ChatterboxIsWaiting(chatterbox))
		{
			draw_textbox_arrow();
		}
		else if (ChatterboxGetOptionCount(chatterbox) > 0)
		{
			initialize_options();
			state = state_options;
		}
	}
}

function initialize_options()
{
	instance_create_depth(x, y, depth, obj_menu_textbox_options);
}

function state_options()
{
	draw_textbox();
	draw_label();
	text_formatter.get_formatted_text(text).wrap(text_width_max, text_height_max).page(typist_page).draw(textbox_area_x + margin, textbox_area_y + margin, typist);
}

function page_flip()
{
	ChatterboxContinue(chatterbox);
	if (ChatterboxIsStopped(chatterbox))
	{
		instance_destroy();
		exit;
	}
	typist_page = 0;
	page_read();
}

is_current_talksprite_talking = false;

get_mini_talking_sprite = function(char_name)
{
	switch (char_name)
	{
		case "flowra":
			return spr_npc_flowra_talk;
		case "flowrie":
			return spr_npc_flowrie_talk;
		case "follen":
			return spr_npc_follen_talk;
		case "fleur":
			return spr_npc_fleur_talk;
		case "florn":
			return spr_npc_florn_talk;
		case "flowiel":
			return spr_npc_flowiel_talk;
	}
};

function page_read()
{
	text = ChatterboxGetContentSpeech(chatterbox, 0);
	if (ChatterboxIsStopped(chatterbox))
	{
		instance_destroy();
		exit;
	}
	speaker = ChatterboxGetContentSpeaker(chatterbox, 0);
	label_read(actor_get_from_string(string_lower(speaker)));
	typist.reset();
	if (instance_exists(talksprite))
	{
		var actor_id = actor_get_from_string(speaker);
		is_current_talksprite_talking = actor_id == talksprite.actor_id;
	}
	var actor_name_lowercase = string_lower(speaker);
	var mini_talking_sprite = get_mini_talking_sprite(actor_name_lowercase);
	if (sprite_exists(mini_talking_sprite))
		text = string("[{0}]{1}", sprite_get_name(mini_talking_sprite), text);
}

function type_all()
{
	typist.skip();
}

function set_typist_sound(sound, pitchMin, pitchMax)
{
	if (sound == snd_text_default)
	{
		typist.sound_per_char([sound], 1, 1, undefined, 0.4);
		exit;
	}
	typist.sound_per_char([sound], pitchMin, pitchMax, undefined, 0.4);
}

function label_read(actor_type)
{
	if (-1 == actor_type)
	{
		talking_actor_id = -1;
		set_typist_sound(snd_text_default, 1, 1);
	}
	else if (talking_actor_id != actor_type)
	{
		talking_actor_id = actor_type;
		var actor = obj_data.get_actor(actor_type);
		if (actor)
			set_typist_sound(actor.talksound, actor.talksound_pitch_min, actor.talksound_pitch_max);
		else
			set_typist_sound(snd_text_default, 1, 1);
	}
}

is_done_typing = function()
{
	return typist.get_state() == 1;
};

function actor_hide(actor)
{
	array_push(hidden_actors, actor);
}

function actor_show(actor)
{
	var hidden_actor_index = array_find_index(hidden_actors, method(
	{
		actor_id: actor
	}, function(actor)
	{
		return actor == actor_id;
	}));
	if (hidden_actor_index < 0)
		exit;
	array_delete(hidden_actors, hidden_actor_index, 1);
}

actor_hide_from_string = function(actor_name)
{
	var actor = actor_get_from_string(actor_name);
	if (actor == -1)
	{
		show_debug_message(string("Error: Could not hide actor \"{0}\". Unrecognized actor.", actor_name));
		exit;
	}
	actor_hide(actor);
};

actor_show_from_string = function(actor_name)
{
	var actor = actor_get_from_string(actor_name);
	if (actor == -1)
	{
		show_debug_message(string("Error: Could not show actor \"{0}\". Unrecognized actor.", actor_name));
		exit;
	}
	actor_show(actor);
};

actor_get_from_string = function(_actor_name)
{
	return array_find_index(obj_data.actors, method(
	{
		actor_name: _actor_name
	}, function(actor)
	{
		if (!actor)
			return false;
		return actor.name == string_lower(actor_name);
	}));
};

on_click = function()
{
	if (is_blocked())
		exit;
	if (is_done_typing())
	{
		if (ChatterboxIsStopped(chatterbox))
		{
			instance_destroy();
		}
		else if (ChatterboxIsWaiting(chatterbox))
		{
			if (!scribble_text_element.on_last_page())
				typist_page++;
			else
				page_flip();
		}
	}
	else
	{
		type_all();
	}
};

blocker = new Blocker();

block = function()
{
	if (!blocker.is_blocked())
	{
		if (!ChatterboxIsWaiting(chatterbox))
			ChatterboxWait(chatterbox);
		typist.in(0, 0);
	}
	blocker.block();
};

unblock = function()
{
	blocker.unblock();
	if (!blocker.is_blocked())
	{
		if (ChatterboxIsWaiting(chatterbox))
		{
			ChatterboxContinue(chatterbox);
			if (ChatterboxIsStopped(chatterbox))
			{
				instance_destroy();
				exit;
			}
		}
		typist.in(text_spd, 0);
		page_read();
	}
};

is_blocked = function()
{
	return blocker.is_blocked();
};

draw = function()
{
	if (state && !is_blocked())
		state();
};

delay = function(_time)
{
	block();
	create_timeout(_time, self.unblock);
};

talksprite = noone;
hidden_actors = [];
typist.sound_per_char([snd_text_default], 1, 1);
chatterbox = ChatterboxCreate(chatterbox_alias);
global.is_game_paused = true;
state = undefined;
ChatterboxJump(chatterbox, dialogue_node);
if (ChatterboxIsStopped(chatterbox))
{
	show_debug_message(string("Could not read contents of chatterbox node \"{0}\". Had to stop on the first line.", dialogue_node));
	instance_destroy();
	exit;
}
state = state_typing;
page_read();
