event_inherited();

value_update_effect = function()
{
	audio_group_set_gain(audiogroup_sfx, value, 0);
};

value_set(audio_group_get_gain(audiogroup_sfx));
label = "Sfx volume";
