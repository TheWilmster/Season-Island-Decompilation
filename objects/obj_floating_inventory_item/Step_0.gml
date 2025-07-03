x = lerp(x, target_x, lerp_amount);
y = lerp(y, target_y, lerp_amount);
if (abs(x - target_x) <= 1 && abs(y - target_y) <= 1)
{
	instance_destroy();
	global.inventory.item_add(item_id);
}
