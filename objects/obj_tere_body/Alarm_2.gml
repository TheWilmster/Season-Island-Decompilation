state = state_pet;
head.sprite_index = spr_tere_head_eyes_closed;
sprite_index = spr_tere_body_loafing;
image_speed = 1;
if (random(1) < meow_chance)
	sfx_play(snd_meow);
audio_play_sound(snd_purr, 1, true);
audio_sound_gain(snd_purr, 0, 0);
pet_counter = 0;
