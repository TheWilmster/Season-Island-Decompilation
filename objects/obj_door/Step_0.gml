door.z_rot += door_z_rot_spd;
door.x = door_x + ((sin(-door.z_rot) * door_width) / 2);
door.y = door_y - ((cos(door.z_rot) * door_width) / 2);
viewer_3d.camera_data.x += camera_x_speed;
if (door_z_rot_spd > 0)
	door_z_rot_spd -= 0.025 * RAD;
