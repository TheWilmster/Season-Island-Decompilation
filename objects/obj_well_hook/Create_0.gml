event_inherited();
name = "Hook";
attached_item_id = ItemType.None;
rope_length = 100;

is_holding_item = function()
{
	return attached_item_id != ItemType.None;
};

on_click_with_item = function()
{
	if (attached_item_id == ItemType.None)
	{
		attached_item_id = global.inventory.get_selected_item();
		global.inventory.item_rmv_selected();
	}
	else
	{
		retrieve_attached_item();
	}
};

retrieve_attached_item = function()
{
	audio_play_sound(snd_bonus, 1, false);
	add_inventory_item_floating(attached_item_id);
	attached_item_id = ItemType.None;
	state = state_idle;
};

on_click_without_item = function()
{
	if (attached_item_id == ItemType.None)
		create_textbox("well hook");
	else
		retrieve_attached_item();
};

draw_attached_item = function()
{
	var item = obj_data.get_item(attached_item_id);
	if (!item)
		exit;
	var attached_item_sprite = item.sprite_index;
	draw_sprite(attached_item_sprite, 0, x - (sprite_get_width(attached_item_sprite) / 2), (y - (sprite_get_height(attached_item_sprite) / 2)) + (sprite_height / 2));
};

draw = function()
{
	var mat_angle = matrix_build(0, 0, 0, 0, 0, (angle * 180) / pi, 1, 1, 1);
	var mat_translate = matrix_build(x, y, 0, 0, 0, 0, 1, 1, 1);
	var mat = matrix_multiply(mat_angle, mat_translate);
	matrix_set(2, mat);
	var i = rope_length - sprite_get_height(spr_well_rope);
	while (i > 0)
	{
		draw_sprite(spr_well_rope, 0, 0, i - rope_length);
		i -= sprite_get_height(spr_well_rope);
	}
	var rope_end_height = rope_length % sprite_get_height(spr_well_rope);
	draw_sprite_part(spr_well_rope, 0, 0, sprite_get_height(spr_well_rope) - rope_end_height, sprite_get_width(spr_well_rope), rope_end_height, -sprite_get_width(spr_well_rope) / 2, -rope_length);
	matrix_set(2, matrix_build_identity());
	draw_self();
	draw_attached_item();
};

angle = 0;
angle_max = 22.5 * RAD;
angle_angle = 0;
angle_angle_spd = RAD;
rope_x = x;
rope_y = y;

get_cursor_tooltip_with_item = function()
{
	if (is_holding_item())
		return "";
	return string("Attach [{0}]", sprite_get_name(obj_data.get_item(global.inventory.get_selected_item()).sprite_index));
};

get_cursor_tooltip_without_item = function()
{
	if (is_holding_item())
		return string("Retrieve {0}", obj_data.get_item(attached_item_id).name);
	return string("Check {0}", name);
};

state_idle = function()
{
	if (attached_item_id != ItemType.None && ceil(rope_length) >= 90)
	{
		state = state_wet;
		audio_play_sound(snd_water, 1, false);
		wet_attached_item();
	}
};

state_wet = function()
{
	if (alarm_is_expired(0))
		alarm_set(0, water_drop_delay);
};

state = state_idle;
water_drop_delay = 6;

wet_attached_item = function()
{
	switch (attached_item_id)
	{
		case ItemType.WateringCan:
			attached_item_id = ItemType.WateringCanFull;
			break;
		case ItemType.LoveLetter:
			attached_item_id = ItemType.LoveLetterWet;
			break;
	}
};
