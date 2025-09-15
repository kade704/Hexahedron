/// @description 변수 초기화

Scale = 65;
TargetScale = 65;

SmoothSpeed = 0.02;



///위치 초기화

Position = vector3_create(0, 0, 0);
Rotation = quaternion_identity();

TargetPosition = vector3_zero();
TargetRotation = quaternion_identity();


///d3d 초기화

//anti-aliasing, v-sync 설정
display_reset(4, true);

//d3d 시작
d3d_start();

//perspective 사용 
d3d_set_perspective(true);

//depth test 수행
d3d_set_hidden(true);

//양면 렌더링 끄기
d3d_set_culling(true);

//
d3d_set_zwriteenable(true);

