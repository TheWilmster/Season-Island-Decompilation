event_inherited();
name = "Buttermantis";

talk = function(_node)
{
	state = state_idle;
	create_mover_shake(2, 2, 0.1);
	create_textbox(_node, function()
	{
		state = state_move_8;
	});
};

on_click_without_item = function()
{
	talk(obj_stepladder.is_visible ? "buttermantis" : "buttermantis stepladder");
};

on_click_with_item = function()
{
	switch (global.inventory.get_selected_item())
	{
		case ItemType.Crinoid:
			talk("buttermantis crinoid");
			break;
		case ItemType.BigCrinoid:
			talk("buttermantis crinoid big");
			break;
		case ItemType.LoveLetter:
			talk("buttermantis newton love letter");
			break;
		case ItemType.LoveLetterWet:
			talk("buttermantis newton love letter wet");
			break;
		default:
			talk("buttermantis wrong item");
			break;
	}
};

angle = 0;
angle_spd = 4 * RAD;
init_x = x;
init_y = y;
move_radius_x = 35;
move_radius_y = 20;

state_move_8 = function()
{
	angle += angle_spd;
	if (angle > (4 * pi))
		angle -= (4 * pi);
	x = init_x + (move_radius_x * cos(angle / 2));
	y = init_y + (move_radius_y * sin(angle));
};

state_idle = function()
{
};

state = state_move_8;
