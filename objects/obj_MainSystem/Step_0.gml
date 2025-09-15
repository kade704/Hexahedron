/// @description  타일 인덱스 증가

if(IsTileOpening)
{
    if(Timeline[TileIndex] < current_time - TileOpenTime && TileIndex < DataLength - 2)
    {
        TileIndex++;
        
        TileVisible[TileIndex] = true;
    }
}



/// 큐브 인덱스 증가

if(IsGamePlaying)
{
    if(Timeline[CubeIndex] < current_time - GameStartTime && CubeIndex < DataLength - 1)
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

var hit = keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_any);
if(IsGamePlaying && CubeIndex > 0)
{
    var currentTime = current_time - GameStartTime;
    var lastNoteTime = Timeline[CubeIndex - 1];
    var currentNoteTime = Timeline[CubeIndex];
    
    if((lastNoteTime < currentTime) && (currentTime < lastNoteTime + JudgementRate) && CubeIndex > 1)
    {
        if(hit && IsHitted == false)
        {
            IsHitted = true;
        }
    }
    
    if((lastNoteTime + JudgementRate < currentTime) && (currentTime < currentNoteTime - JudgementRate))
    {
        if(!IsInMissJudgement)
        {
            if(IsHitted == false)
            {
                room_restart();
            }
            IsInMissJudgement = true;
            IsHitted = false;
        }
        
        if(hit)
        {
            room_restart();
        }
    }
    else
    {
        IsInMissJudgement = false;
    }
    
    if((currentNoteTime - JudgementRate < currentTime) && (currentTime < currentNoteTime))
    {
        if(hit && IsHitted == false)
        {
            IsHitted = true;
        }
    }
}

if(hit)
{
    obj_HUD.VignetteRadiusMin = 0.3;
    obj_HUD.VignetteRadiusMax = 1.1;
    obj_Camera.Scale = 57;
    audio_play_sound(snd_hihat, 0, false);
}


///타일 공개 시작

var currentTime = current_time - SongStartTime;

if(!IsTileOpening && Song.start_time - (OneBeatRate * 8) < currentTime)
{
    IsTileOpening = true;
    TileOpenTime = current_time;
}


///메트로놈

var currentTime = current_time - SongStartTime;

for(var i = 0; i < 4; i++)
{
    if(!IsTicked[i] && Song.start_time - (OneBeatRate * (3 - i)) < currentTime)
    {
        IsTicked[i] = true;
        if(i == 0) audio_play_sound(snd_tick1, 0, false);
        else audio_play_sound(snd_tick2, 0, false);
        
        if(i == 3) obj_HUD.AssistanceText = "START!";
        else obj_HUD.AssistanceText = string(3 - i);
    }
}

if(CubeIndex == 2) obj_HUD.AssistanceText = "";


///게임 시작

var currentTime = current_time - SongStartTime;

if(IsTileOpening && !IsGamePlaying && Song.start_time < currentTime)
{
    IsGamePlaying = true;
    GameStartTime = current_time;
}

///클리어

if(CubeIndex == DataLength - 1)
{
    obj_HUD.AssistanceText = "Clear!";
    IsGamePlaying = false;
}

