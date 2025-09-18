/// @description 큐브 이동

if(CubeAngle == 0 && !IsSongStarted)
{
    var dir = point_direction(window_get_width() / 2, window_get_height() / 2, mouse_x, mouse_y);    
    
	var cellChanged = false;
	
    if(keyboard_check(vk_up)) // +X
    {
		if (CubeCellX < obj_LobbyMap.MAP_SIZE_X - 1 && obj_LobbyMap.SongMap[CubeCellX + 1][CubeCellY] != -2)
		{
			CubeCellX += 1;
			CubePosition = vector3_create(CubeCellX * 10, CubeCellY * 10, 0);
			CubeRotation = quaternion_from_euler_angle(0, 0, 0);
			cellChanged = true;
		}
    }
    else if(keyboard_check(vk_left)) // -Y
    {
		if (CubeCellY > 0 && obj_LobbyMap.SongMap[CubeCellX][CubeCellY - 1] != -2)
		{
			CubeCellY -= 1;
			CubePosition = vector3_create(CubeCellX * 10 + 5, CubeCellY * 10 + 5, 0);
			CubeRotation = quaternion_from_angle_axis(vector3_z(), -90);
			cellChanged = true;
		}
    }
    else if(keyboard_check(vk_down)) // -X
    {
		if (CubeCellX > 0 && obj_LobbyMap.SongMap[CubeCellX - 1][CubeCellY] != -2)
		{
			CubeCellX -= 1;
			CubePosition = vector3_create(CubeCellX * 10 + 10, CubeCellY * 10, 0);
			CubeRotation = quaternion_from_angle_axis(vector3_z(), -180);
			cellChanged = true;
		}
    }
    else if(keyboard_check(vk_right)) // +Y
    {
		if (CubeCellY < obj_LobbyMap.MAP_SIZE_Y - 1 && obj_LobbyMap.SongMap[CubeCellX][CubeCellY + 1] != -2)
		{
			CubeCellY += 1;
			CubePosition = vector3_create(CubeCellX * 10 + 5, CubeCellY * 10 - 5, 0);
			CubeRotation = quaternion_from_angle_axis(vector3_z(), 90);
			cellChanged = true;
		}
    }
	
	if (cellChanged) 
	{
		CubeAngle = -90;
		
		SelectedSongIdx = obj_LobbyMap.SongMap[CubeCellX][CubeCellY];
		
		if (SelectedSongIdx != -1) 
		{
			obj_Camera.TargetScale = 50;
			if (SelectedSongIdx == 999) 
			{
				obj_LobbyUI.Text = "under construction..";
				with(obj_LobbyUI) event_user(0);
				with(obj_PostProcessing) event_user(0);
			}
			else
			{
				var song = obj_Jukebox.Songs[SelectedSongIdx];
	            obj_LobbyUI.Text = song.artist + " - " + song.name;
	            with(obj_LobbyUI) event_user(0);
				with(obj_PostProcessing) event_user(0);
            
	            audio_stop_all();
	            var snd = audio_play_sound(song.sound, 0, false);
	            audio_sound_set_track_position(snd, song.highlight_time);
            
	            IsSongPlaying = true;
			}
		}
		else 
		{
			with(obj_LobbyUI) event_user(1);
			with(obj_PostProcessing) event_user(1);
            obj_Camera.TargetScale = 65;
            IsSongPlaying = false;
		}
	}
}

///메인 룸으로 이동

if(keyboard_check_pressed(vk_enter))
{
    if (SelectedSongIdx != -1 && SelectedSongIdx != 999) 
	{
		obj_Jukebox.Selected = SelectedSongIdx;
		room_goto(room_Main)
	}
}


///볼륨 조정

if(IsSongPlaying)
{
    if(SongVolume < 1)
    {
        SongVolume += SongVolumeChagingSpeed;
    }
    else
    {
        SongVolume = 1;
    }
}
else
{
    if(0 < SongVolume)
    {
        SongVolume -= SongVolumeChagingSpeed;
    }
    else
    {
        SongVolume = 0;
    }
}

audio_master_gain(SongVolume);



