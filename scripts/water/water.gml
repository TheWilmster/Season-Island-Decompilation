function water(_x, _y)
{
	sfx_play(snd_water);
	instance_create_depth(_x, _y, Depth.Particle, obj_watering_can_animation, 
	{
		waterdrop_color: #00FFFF
	});
}
