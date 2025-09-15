/// @description 변수 초기화

TileIndex = 0;
CubeIndex = 0;

CubeAngle = 0;
CubeRotateSpeed = 0;

SongStartTime = 0;
IsTileOpening = false;
TileOpenTime = 0;
IsGamePlaying = false;
GameStartTime = 0;

IsHitted = true;
IsInMissJudgement = false;
JudgementRate = 120;

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

obj_Camera.Position = vector3_zero();
obj_Camera.Rotation = quaternion_identity();

obj_Camera.SmoothSpeed = 0.1;
obj_Camera.TargetScale = 50;

///큐브 초기화

obj_Cube.Position = vector3_zero();
obj_Cube.Rotation = quaternion_identity();

///HUD 초기화

obj_HUD.AssistanceText = "";

///노래 시작

audio_stop_all();

audio_master_gain(1.0);
audio_play_sound(Song.sound, 0, false);

SongStartTime = current_time;



