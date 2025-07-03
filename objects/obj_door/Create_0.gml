event_inherited();
viewer_3d = new Viewer3D(0, 0, 640, 360);
viewer_3d.camera_data.y = 0;
viewer_3d.camera_data.a = 0;
door_height = sprite_get_height(spr_wooden_door);
door_width = sprite_get_width(spr_wooden_door);
viewer_3d.camera_data.z = -48;
door = new Sprite3D(viewer_3d, spr_wooden_door);
door_frame = new Sprite3D(viewer_3d, spr_wooden_door_frame);
distance_from_door = 200;
door_x = viewer_3d.camera_data.x + distance_from_door;
door.x = door_x;
door_y = viewer_3d.camera_data.y - (door_width / 2);
door.y = door_y;
door.z -= door_height;
door.z_rot = pi;
door_frame.x = door.x;
door_frame.y = door.y + (door_width / 2);
door_frame.z = door.z - 2;
array_push(viewer_3d.sprites_3d, door);
array_push(viewer_3d.sprites_3d, door_frame);

draw = function()
{
	viewer_3d.draw();
};

on_click = function()
{
	open_door();
};

door_z_rot_spd = 0;
is_door_open = false;
camera_x_speed = 0;

open_door = function()
{
	obj_sound_manager.room_music_fade_out();
	audio_play_sound(snd_box, 1, false);
	door_z_rot_spd = 2 * RAD;
	is_door_open = true;
	alarm_set(0, 60);
};

can_be_clicked = function()
{
	return !is_door_open && !global.is_game_paused;
};

get_cursor_tooltip = function()
{
	return "Open";
};
