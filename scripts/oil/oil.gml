function oil(x, y)
{
	sfx_play(snd_oil);
	instance_create_depth(x, y, Depth.Particle, obj_watering_can_animation, 
	{
		waterdrop_color: 0
	});
}
