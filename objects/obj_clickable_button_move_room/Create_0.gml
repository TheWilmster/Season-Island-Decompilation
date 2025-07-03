event_inherited();

on_click = function()
{
	if (room == target_room)
	{
		show_debug_message("Player is already in this room.");
		exit;
	}
	obj_menu_manager.close_current_menu();
	audio_play_sound(snd_enter_level, 1, false);
	fade_dark(function()
	{
		obj_menu_main.set_visibility(true);
		room_goto(target_room);
		global.is_game_paused = false;
	});
};

text_formatter.font_color = 0;
var rm = obj_data.get_room(target_room);
if (!rm)
{
	set_label("???");
	exit;
}
background_sprite_scale = 0.2;
text_width = 640 * background_sprite_scale;

get_target_room_background = function()
{
	var rm_info = room_get_info(target_room);
	var rm_layers = rm_info.layers;
	var rm_background_layer_index = array_find_index(rm_layers, function(_layer)
	{
		return _layer.name == "Background";
	});
	if (rm_background_layer_index == -1)
		return -1;
	var rm_background_layer = rm_layers[rm_background_layer_index];
	if (array_length(rm_background_layer.elements) == 0)
		return -1;
	return rm_background_layer.elements[0].sprite_index;
};

var background_sprite_index = get_target_room_background();
if (!sprite_exists(background_sprite_index))
{
	set_label(string("{0}\n[c_white][scale,{1}][{2}]", rm.name, background_sprite_scale, sprite_get_name(spr_background_empty)));
	exit;
}
set_label(string("{0}\n[c_white][scale,{1}][{2}]", rm.name, background_sprite_scale, sprite_get_name(background_sprite_index)));
