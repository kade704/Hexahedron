if (!IsGamePlaying && !IsSkipped) {
	CurrentTime = Song.start_time - OneBeatRate * 4;
	audio_stop_all();
	audio_play_sound(Song.sound, 0, false, 1, CurrentTime / 1000);
	IsSkipped = true;
}