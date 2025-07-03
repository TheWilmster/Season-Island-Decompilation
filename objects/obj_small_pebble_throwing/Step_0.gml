event_inherited();
if (can_loosen_apple)
{
	if (place_meeting(x + xspeed, y, obj_falling_apple))
	{
		loosen_apple();
		xspeed = -xspeed;
	}
	else if (place_meeting(x, y + yspeed, obj_falling_apple))
	{
		loosen_apple();
		yspeed = -yspeed;
	}
}
