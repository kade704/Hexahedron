if(IsTileOpening)
{
    if(Timeline[TileIndex] < current_time - TileOpenTime && TileIndex < DataLength - 2)
    {
        TileIndex++;
        
        TileVisible[TileIndex] = true;
    }
}

if(IsGamePlaying)
{
    if(Timeline[CubeIndex] < current_time - NoteStartTime && CubeIndex < DataLength - 1)
    {
		
        if(CubeIndex < DataLength - 2)
        {
            TileVisible[CubeIndex] = false;
        }
        
        CubeIndex++;
        
		
        if(CubeIndex < DataLength - 1)
        {
            CubeAngle = -NoteData[CubeIndex].beat * 90;
            CubeRotateSpeed = -CubeAngle / (OneBeatRate / (1000 / fps) * NoteData[CubeIndex].beat * NoteData[CubeIndex].changeSpeed);
        }
    }
}


///노트 판정

var timeFromNoteBegin = current_time - NoteStartTime;

var hit = keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_any);
if(hit && IsGamePlaying && TargetNoteIndex < DataLength - 1)
{
    var targetNoteTime = Timeline[TargetNoteIndex];
	var timeDiff = abs(timeFromNoteBegin - targetNoteTime);
    
    if (timeDiff <= PERFECT_WINDOW_MS) {
		HitPerfect(timeFromNoteBegin - targetNoteTime);
		TargetNoteIndex++;
	} else if (timeDiff <= GOOD_WINDOW_MS) {
		HitGood(timeFromNoteBegin - targetNoteTime);
		TargetNoteIndex++;
	} else if (timeDiff <= BAD_WINDOW_MS) {
		HitBad(timeFromNoteBegin - targetNoteTime);
		TargetNoteIndex++;
	} else {
		HitMiss();
	}
}

if (IsGamePlaying && TargetNoteIndex < DataLength - 1)
{
	var targetNoteTime = Timeline[TargetNoteIndex];
	if (timeFromNoteBegin > targetNoteTime + BAD_WINDOW_MS) 
	{
		HitMiss();
		TargetNoteIndex++;
	}
}

if(hit)
{
    obj_PostProcessing.VignetteRadiusMin = 0.3;
    obj_PostProcessing.VignetteRadiusMax = 1.1;
    obj_Camera.Scale = 60;
    audio_play_sound(snd_hihat, 0, false);
}


///타일 공개 시작

var timeFromSongStart = current_time - SongStartTime;

if(!IsTileOpening && Song.start_time - (OneBeatRate * 16) < timeFromSongStart)
{
    IsTileOpening = true;
    TileOpenTime = current_time;
}


///메트로놈

for(var i = 0; i < 4; i++)
{
    if(!IsTicked[i] && Song.start_time - (OneBeatRate * (3 - i)) < timeFromSongStart)
    {
        IsTicked[i] = true;
        if(i == 0) audio_play_sound(snd_tick1, 0, false);
        else audio_play_sound(snd_tick2, 0, false);
        
        obj_MainUI.showText(string(3 - i), c_white);
    }
}


///게임 시작

if(IsTileOpening && !IsGamePlaying && Song.start_time < timeFromSongStart)
{
    IsGamePlaying = true;
    NoteStartTime = current_time;
	TargetNoteIndex += 1;
}

///클리어

if(!IsGameFinished && CubeIndex == DataLength - 1)
{
    IsGameFinished = true;
}

