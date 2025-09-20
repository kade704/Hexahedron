// Tiles fade in

if(IsTileOpening)
{
    if(Timeline[TileIndex - 1] < CurrentTime + TileOpenOffset && TileIndex < DataLength)
    {
		TileVisible[TileIndex] = true;
        TileIndex += 1;
    }
}

if(IsGamePlaying)
{
    if(Timeline[CubeIndex - 1] < CurrentTime && CubeIndex < DataLength)
    {
        TileVisible[CubeIndex] = false;
		
        CubeAngle = -NoteData[CubeIndex].beat * 90;
        CubeRotateSpeed = -CubeAngle / (OneBeatRate / (1000 / fps) * NoteData[CubeIndex].beat * NoteData[CubeIndex].changeSpeed);
		
		CubeIndex += 1;
    }
}


///노트 판정

var hit = keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_any);
if(hit && IsGamePlaying && TargetNoteIndex < DataLength)
{
    var targetNoteTime = Timeline[TargetNoteIndex];
	var timeDiff = abs(CurrentTime - targetNoteTime);
    
    if (timeDiff <= PERFECT_WINDOW_MS) {
		HitPerfect(CurrentTime - targetNoteTime);
		TargetNoteIndex++;
	} else if (timeDiff <= GOOD_WINDOW_MS) {
		HitGood(CurrentTime - targetNoteTime);
		TargetNoteIndex++;
	} else if (timeDiff <= BAD_WINDOW_MS) {
		HitBad(CurrentTime - targetNoteTime);
		TargetNoteIndex++;
	} else {
		HitMiss();
	}
}

if (IsGamePlaying && TargetNoteIndex < DataLength)
{
	var targetNoteTime = Timeline[TargetNoteIndex];
	if (CurrentTime > targetNoteTime + BAD_WINDOW_MS) 
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

if(!IsTileOpening && Song.start_time - TileOpenOffset < CurrentTime)
{
    IsTileOpening = true;
	TileIndex += 1;
}


///메트로놈

for(var i = 0; i < 4; i++)
{
    if(!IsTicked[i] && Song.start_time - (OneBeatRate * (3 - i)) < CurrentTime)
    {
        IsTicked[i] = true;
        if(i == 0) audio_play_sound(snd_tick1, 0, false);
        else audio_play_sound(snd_tick2, 0, false);
        
        obj_MainUI.showText(string(3 - i), c_white);
		IsSkipped = true;
    }
}


///게임 시작

if(IsTileOpening && !IsGamePlaying && Song.start_time < CurrentTime)
{
    IsGamePlaying = true;
	
	CubeAngle = -NoteData[CubeIndex].beat * 90;
    CubeRotateSpeed = -CubeAngle / (OneBeatRate / (1000 / fps) * NoteData[CubeIndex].beat * NoteData[CubeIndex].changeSpeed);
	CubeIndex += 1;
	
	TileVisible[0] = false
}

///클리어

if(!IsGameFinished && CubeIndex == DataLength - 1)
{
    IsGameFinished = true;
}

CurrentTime += delta_time / 1000;
