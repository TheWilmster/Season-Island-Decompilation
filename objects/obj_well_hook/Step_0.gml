angle_angle += angle_angle_spd;
angle = (angle_max * sin(angle_angle) * rope_length) / (rope_length + obj_well_handle.rope_length);
x = rope_x + (rope_length * sin(angle));
y = rope_y + (rope_length * cos(angle));
image_angle = (angle * 180) / pi;
if (state)
	state();
