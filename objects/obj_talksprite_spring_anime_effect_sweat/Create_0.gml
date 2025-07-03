event_inherited();

destroy = function()
{
	instance_destroy(spring_mover_shake);
	instance_destroy();
};

sweat_delay_min = 12;
sweat_delay_max = 48;
shake_delay = 90;
spring_mover_shake = undefined;

spring_shake = function()
{
	spring_mover_shake = create_mover_shake(2, 2, 0.1, obj_talksprite_spring);
};

spring_shake();
