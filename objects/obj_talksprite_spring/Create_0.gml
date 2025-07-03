event_inherited();

emotion_effect = function()
{
};

anime_effect = undefined;
anime_effect_objects = [];
anime_effect_objects[AnimeEffect.Blush] = obj_talksprite_spring_anime_effect_blush;
anime_effect_objects[AnimeEffect.Hearts] = obj_talksprite_spring_anime_effect_hearts;
anime_effect_objects[AnimeEffect.Anger] = obj_talksprite_spring_anime_effect_anger;
anime_effect_objects[AnimeEffect.Worry] = obj_talksprite_spring_anime_effect_worry;
anime_effect_objects[AnimeEffect.Sweat] = obj_talksprite_spring_anime_effect_sweat;

anime_effect_get_object = function(effect)
{
	return anime_effect_objects[effect];
};

anime_effect_create = function(effect)
{
	var anime_effect_object = anime_effect_get_object(effect);
	anime_effect_destroy();
	anime_effect = instance_create_depth(x, y, depth - 2, anime_effect_object);
};

anime_effect_destroy = function()
{
	if (instance_exists(anime_effect))
		anime_effect.destroy();
};
