event_inherited();

function move(inst)
{
	inst.y += yspd;
	yspd += (weight * 0.98);
}
