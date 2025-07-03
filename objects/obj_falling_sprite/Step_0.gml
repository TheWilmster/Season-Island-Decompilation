x += xspeed;
y += yspeed;
yspeed += weight;
if (yspeed > 0 && y > (camera_get_view_y(view_camera[0]) + 360))
	instance_destroy();
