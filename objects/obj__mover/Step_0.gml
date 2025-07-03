if (!instance_exists(moving_instance))
{
	instance_destroy();
	exit;
}

if (!active)
    exit;

move(moving_instance);
