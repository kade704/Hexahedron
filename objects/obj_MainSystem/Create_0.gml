/// @description 변수 초기화

PERFECT_WINDOW_MS = 40;
GOOD_WINDOW_MS = 80;
BAD_WINDOW_MS = 120;

PERFECT_SCORE = 200;
GOOD_SCORE = 130;
BAD_SCORE = 60;

TileIndex = 0;
CubeIndex = 0;
TargetNoteIndex = 0;

CubeAngle = 0;
CubeRotateSpeed = 0;

SongStartTime = 0;
NoteStartTime = 0;
IsTileOpening = false;
TileOpenTime = 0;
IsGamePlaying = false;
IsGameFinished = false;

Score = 0;

HitOffsets = [];
HitOffsetAlphas = [];

PerfectCount = 0;
GoodCount = 0;
BadCount = 0;
MissCount = 0;

for(var i = 0; i < 4; i++)
{
    IsTicked[i] = false;
}

/// 파일에서 데이터 불러오기

Song = obj_Jukebox.Songs[obj_Jukebox.Selected];

NoteData = load_note_data(Song.note_path);
DataLength = array_length(NoteData);

/// 데이터를 기반으로 위치, 포워드, 라이트, 업 벡터 생성하기

Positions[0] = vector3_zero();
Rotations[0] = quaternion_identity();

for(var i = 1; i < DataLength; i++)
{
	
    if(NoteData[i].rotation == -1) //좌회전 진행
    {   
        var angle = (90 * NoteData[i].beat) - 90;

		var forward = quaternion_vector3_forward(Rotations[i - 1]);
		forward = vector3_multiply_scalar(forward, 5);
		
		var right = quaternion_vector3_right(Rotations[i - 1]);
		right = vector3_multiply_scalar(right, -5);
	
		var offset = vector3_add(forward, right);
		Positions[i] = vector3_add(Positions[i - 1], offset);
		
		var rotationAxis =  quaternion_from_angle_axis(vector3_z(), -90);
		var rotationAngle = quaternion_from_angle_axis(vector3_y(), angle);
		var rotation = quaternion_multiply(rotationAxis, rotationAngle);
		rotation = quaternion_multiply(Rotations[i - 1], rotation);
		Rotations[i] = rotation;
    }
    else if(NoteData[i].rotation == 0) //직진 진행 
    {   
        var angle = (90 * NoteData[i].beat) - 90;

		var forward = quaternion_vector3_forward(Rotations[i - 1]);
		forward = vector3_multiply_scalar(forward, 10);
	
		Positions[i] = vector3_add(Positions[i - 1], forward);
		
		var rotationAngle = quaternion_from_angle_axis(vector3_y(), angle);
		var rotation = quaternion_multiply(Rotations[i - 1], rotationAngle);
		Rotations[i] = rotation;
    
    }
    else if(NoteData[i].rotation == 1) //우회전 진행
    {
        var angle = (90 * NoteData[i].beat) - 90;

		var forward = quaternion_vector3_forward(Rotations[i - 1]);
		forward = vector3_multiply_scalar(forward, 5);
		
		var right = quaternion_vector3_right(Rotations[i - 1]);
		right = vector3_multiply_scalar(right, 5);
	
		var offset = vector3_add(forward, right);
		Positions[i] = vector3_add(Positions[i - 1], offset);
		
		var rotationAxis =  quaternion_from_angle_axis(vector3_z(), 90);
		var rotationAngle = quaternion_from_angle_axis(vector3_y(), angle);
		var rotation = quaternion_multiply(rotationAxis, rotationAngle);
		rotation = quaternion_multiply(Rotations[i - 1], rotation);
		Rotations[i] = rotation;
    }
}

/// 데이터를 기반으로 노래 타임라인 생성하기

OneBeatRate = (1 / (Song.bpm / 60)) * 1000;

var currentTime = 0;

Timeline[0] = 0;
for(var i = 1; i < DataLength; i++)
{
    currentTime += (OneBeatRate * NoteData[i].beat * NoteData[i].changeSpeed);
    Timeline[i] = currentTime;
}

/// 타일 모습 배열
TileVisible = array_create(DataLength, false);
TileVisible[0] = true;

TileAlpha = array_create(DataLength, 0);
TileAlpha[0] = 1;

///카메라 초기화

obj_Camera.Position = vector3_create(5, 5, 0);
obj_Camera.TargetPosition = vector3_create(5, 5, 0);
obj_Camera.Rotation = quaternion_identity();
obj_Camera.TargetPosition = vector3_create(5, 5, 0);

obj_Camera.SmoothSpeed = 0.1;
obj_Camera.TargetScale = 50;
obj_Camera.Scale = 50;

///큐브 초기화

obj_Cube.Position = vector3_zero();
obj_Cube.Rotation = quaternion_identity();

///HUD 초기화

obj_MainUI.Text = "";

obj_PostProcessing.TargetVignetteRadiusMin = 0.2;
obj_PostProcessing.TargetVignetteRadiusMax = 0.9;

///노래 시작

audio_stop_all();

audio_master_gain(1.0);
audio_play_sound(Song.sound, 0, false);

SongStartTime = current_time;

HitPerfect = function(offset) {
	obj_MainUI.showText("Perfect!", c_aqua)
	array_push(HitOffsets, offset);
	array_push(HitOffsetAlphas, 1);
	PerfectCount += 1;
	Score += PERFECT_SCORE;
}

HitGood = function(offset) {
	obj_MainUI.showText("Good!", c_green)
	array_push(HitOffsets, offset);
	array_push(HitOffsetAlphas, 1);
	GoodCount += 1;
	Score += GOOD_SCORE;
}

HitBad = function(offset) {
	obj_MainUI.showText("Bad", c_yellow);
	array_push(HitOffsets, offset);
	array_push(HitOffsetAlphas, 1);
	BadCount += 1;
	Score += BAD_SCORE;
}

HitMiss = function() {
	obj_MainUI.showText("Miss.", c_red);
	MissCount += 1;
}


