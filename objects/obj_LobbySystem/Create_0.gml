/// @description 변수 초기화


IsCubeRotating = false;
IsSongStarted = false;

CameraScale = 65;
CameraSmoothSpeed = 0.02;

SelectedSongIdx = -1;
IsSongPlaying = false;

SongVolume = 0;
SongVolumeChagingSpeed = 0.02;

///큐브 초기화

CubeCellX = 0;
CubeCellY = 3;

CubeRotateSpeed = 3;
CubeAngle = 0;
CubePosition =  vector3_create(CubeCellX * 10, CubeCellY * 10, 0);
CubeRotation = quaternion_identity();

///카메라 초기화

obj_Camera.Position = CubePosition;
obj_Camera.Rotation = quaternion_identity();
obj_Camera.TargetPosition = CubePosition;
obj_Camera.TargetRotation = quaternion_identity();
obj_Camera.SmoothSpeed = 0.02;
obj_Camera.Scale = 65;
obj_Camera.TargetScale = 65;

///HUD 초기화

obj_LobbyUI.Text = "";

obj_PostProcessing.TargetVignetteRadiusMin = 1.2;
obj_PostProcessing.TargetVignetteRadiusMax = 1.2;



