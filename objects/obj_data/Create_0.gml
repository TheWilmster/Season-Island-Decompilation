function unload_chatterbox_chapter()
{
	ChatterboxUnload("chapter");
}

function load_chatterbox_chapter(chapter)
{
	unload_chatterbox_chapter();
	ChatterboxLoadFromFile("dialogue_files/english/chapter" + string(chapter) + ".yarn", "chapter");
}

items = [];
items[ItemType.WateringCan] = 
{
	name: "Watering can",
	sprite_index: spr_item_watering_can
};
items[ItemType.TopiaryShears] = 
{
	name: "Regular topiary shears",
	sprite_index: spr_item_topiary_shears
};
items[ItemType.WateringCanFull] = 
{
	name: "Full watering can",
	sprite_index: spr_item_watering_can_full
};
items[ItemType.WoodenBranch] = 
{
	name: "Wooden branch",
	sprite_index: spr_item_wooden_branch_y
};
items[ItemType.Slingshot] = 
{
	name: "Slingshot",
	sprite_index: spr_item_slingshot
};
items[ItemType.WateringCanBroken] = 
{
	name: "Mysterious broken object",
	sprite_index: spr_item_watering_can_broken
};
items[ItemType.Vine] = 
{
	name: "Springflower vine",
	sprite_index: spr_item_springflower_vine
};
items[ItemType.Crinoid] = 
{
	name: "Crinoid",
	sprite_index: spr_item_crinoid
};
items[ItemType.BigCrinoid] = 
{
	name: "Big crinoid",
	sprite_index: spr_item_crinoid_big
};
items[ItemType.Stepladder] = 
{
	name: "Stepladder",
	sprite_index: spr_item_stepladder
};
items[ItemType.SuperiorShears] = 
{
	name: "[c_lime]Superior[/c] topiary shears",
	sprite_index: spr_item_topiary_shears_superior
};
items[ItemType.LegendaryShears] = 
{
	name: "[rainbow]Legendary[/rainbow] topiary shears",
	sprite_index: spr_item_topiary_shears_legendary
};
items[ItemType.StepladderBroken] = 
{
	name: "Strange broken object",
	sprite_index: spr_item_stepladder_broken
};
items[ItemType.Hammer] = 
{
	name: "Hammer",
	sprite_index: spr_item_hammer
};
items[ItemType.Nails] = 
{
	name: "Nails",
	sprite_index: spr_item_nails
};
items[ItemType.SmallCogs] = 
{
	name: "Small cogs",
	sprite_index: spr_item_small_cogs
};
items[ItemType.GiantCog] = 
{
	name: "Giant cog",
	sprite_index: spr_item_giant_cog
};
items[ItemType.WateringCanOil] = 
{
	name: "Oil can",
	sprite_index: spr_item_watering_can_full_oil
};
items[ItemType.Pipe] = 
{
	name: "Pipe",
	sprite_index: spr_item_pipe
};
items[ItemType.LoveLetter] = 
{
	name: "Newton's love letter",
	sprite_index: spr_item_newton_love_letter
};
items[ItemType.LoveLetterWet] = 
{
	name: "Mistake",
	sprite_index: spr_item_newton_love_letter_wet
};
actors = [];
actors[Actor.Spike] = 
{
	name: "spike",
	talksound: snd_text_spike,
	sprite_index: spr_talksprites_spike,
	talksound_pitch_min: 0.9,
	talksound_pitch_max: 1.1
};
actors[Actor.Newton] = 
{
	name: "newton",
	talksound: snd_text_newton,
	sprite_index: spr_talksprites_newton,
	talksound_pitch_min: 1,
	talksound_pitch_max: 1
};
actors[Actor.Spring] = 
{
	name: "spring",
	talksound: snd_text_spring,
	sprite_index: spr_talksprites_spring,
	talksound_pitch_min: 0.9,
	talksound_pitch_max: 1.1
};
actors[Actor.Tere] = 
{
	name: "tere",
	talksound: snd_text_tere,
	talksound_pitch_min: 1,
	talksound_pitch_max: 1
};
chapters = [];
chapters[Chapters.Spring] = 
{
	dialogue_filename: "chapter1",
	spawn_room: rm_spring
};
rooms = [];
rooms[rm_spring] = 
{
	name: "Spring paradise 1",
	sound_type: SoundType.Multiple,
	sound_channel_volumes: [1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0],
	neighbor_rooms: [
	{
		rm: rm_treehouse_entrance,
		
		cond: function()
		{
			return event_flag_get(Event.MetSpring);
		}
	}, 
	{
		rm: rm_spring_2
	}],
	season: Seasons.Spring
};
rooms[rm_spring_2] = 
{
	name: "Spring paradise 2",
	sound_type: SoundType.Multiple,
	sound_channel_volumes: [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1],
	neighbor_rooms: [
	{
		rm: rm_spring
	}, 
	{
		rm: rm_spring_newton_shop,
		
		cond: function()
		{
			return event_flag_get(Event.MetNewton);
		}
	}],
	season: Seasons.Spring
};
rooms[rm_treehouse_entrance] = 
{
	name: "Treehouse entrance",
	sound_type: SoundType.Multiple,
	sound_channel_volumes: [1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0],
	neighbor_rooms: [
	{
		rm: rm_treehouse,
		
		cond: function()
		{
			return event_flag_get(Event.TreehouseBranchesCut);
		}
	}, 
	{
		rm: rm_spring
	}],
	season: Seasons.Spring
};
rooms[rm_spring_newton_shop] = 
{
	name: "Newton's shop",
	sound_type: SoundType.Single,
	sound: snd_newton_shop,
	neighbor_rooms: [
	{
		rm: rm_spring_2
	}],
	season: Seasons.Spring
};
rooms[rm_treehouse] = 
{
	name: "Treehouse main room",
	sound_type: SoundType.Single,
	sound: snd_treehouse,
	neighbor_rooms: [
	{
		rm: rm_treehouse_3,
		
		cond: function()
		{
			return obj_treehouse_ladder_manager.is_ladder_fixed;
		}
	}, 
	{
		rm: rm_teahouse,
		
		cond: function()
		{
			return obj_teahouse_door_area.can_be_opened();
		}
	}, 
	{
		rm: rm_treehouse_2
	}],
	season: Seasons.Spring
};
rooms[rm_treehouse_2] = 
{
	name: "Treehouse storage room",
	sound_type: SoundType.Single,
	sound: snd_treehouse,
	neighbor_rooms: [
	{
		rm: rm_treehouse
	}],
	season: Seasons.Spring
};
rooms[rm_treehouse_3] = 
{
	name: "Treehouse top room",
	sound_type: SoundType.Single,
	sound: snd_treehouse,
	neighbor_rooms: [
	{
		rm: rm_treehouse
	}],
	season: Seasons.Spring
};
rooms[rm_teahouse] = 
{
	name: "Teahouse",
	sound_type: SoundType.Single,
	sound: snd_teahouse,
	neighbor_rooms: [
	{
		rm: rm_chapter_end,
		
		cond: function()
		{
			return event_flag_get(Event.SpringDateStart);
		}
	}],
	season: Seasons.Spring
};
rooms[rm_titlescreen] = 
{
	sound_type: SoundType.Single,
	sound: snd_story
};
rooms[rm_cabin] = 
{
	name: "Cabin"
};
rooms[rm_chapter_end] = 
{
	name: "Chapter end"
};
seasons = [];
seasons[Seasons.Spring] = 
{
	sound: snd_level_spring,
	sound_channels: [snd_spring_paradise_channel0, snd_spring_paradise_channel1, snd_spring_paradise_channel2, snd_spring_paradise_channel3, snd_spring_paradise_channel4, snd_spring_paradise_channel5, snd_spring_paradise_channel6, snd_spring_paradise_channel7, snd_spring_paradise_channel8, snd_spring_paradise_channel9, snd_spring_paradise_channel10]
};
newton_ads = [];
newton_ads[NewtonAd.Apple] = 
{
	sprite_index: spr_newton_ad_background_apple,
	title_x: 150,
	title_y: 50,
	title_angle: 4 * RAD,
	title_xscale: 3,
	title_yscale: 3,
	title_font_name: "fnt_pixel_operator_8_outline_8dir",
	subtitle_x: 300,
	subtitle_y: 200,
	subtitle_angle: -2 * RAD,
	subtitle_xscale: 0.9,
	subtitle_yscale: 1.1,
	subtitle_font_name: "fnt_pixel_operator_hbsc_outline_8dir"
};

function get_item(itemtype)
{
	if (itemtype < 0 || itemtype >= array_length(items))
		return undefined;
	return items[itemtype];
}

function get_actor(actortype)
{
	if (actortype < 0 || actortype >= array_length(actors))
		return undefined;
	return actors[actortype];
}

function get_room(_room)
{
    var _id = real(_room); // calms down feather
	if (_id < 0 || _id >= array_length(rooms))
		return undefined;
	return rooms[_id];
}

function get_item_name(itemtype)
{
	var item = get_item(itemtype);
	if (!item)
		exit;
	return item.name;
}

function get_item_sprite_index(itemtype)
{
	var item = get_item(itemtype);
	if (!item)
		return asset_unknown;
	return item.sprite_index;
}

function get_item_sprite_name(itemtype)
{
	var _sprite_index = get_item_sprite_index(itemtype);
	if (!_sprite_index)
		return asset_unknown;
	return sprite_get_name(_sprite_index);
}
