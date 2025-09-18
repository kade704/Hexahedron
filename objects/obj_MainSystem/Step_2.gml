//  큐브 이동
CubeAngle += CubeRotateSpeed;
CubeAngle = min(CubeAngle, 0);
var angleRot = quaternion_from_angle_axis(vector3_y(), CubeAngle);

if(CubeIndex < DataLength - 1)
{
	obj_Cube.Position = Positions[CubeIndex];
	obj_Cube.Rotation = quaternion_multiply(Rotations[CubeIndex], angleRot);
}


//  카메라 이동
if(CubeIndex < DataLength - 1)
{
	var camRot = Rotations[CubeIndex];
	var camPos = vector3_add(Positions[CubeIndex], vector3_multiply_scalar(quaternion_vector3_forward(camRot), 5));
    obj_Camera.TargetPosition = camPos;
	obj_Camera.TargetRotation = camRot;
}

// 타일 모습 변경
for (var i = 0; i < DataLength; i++)
{
	if (TileVisible[i]) {
		TileAlpha[i] += 0.01;	
	} else {
		TileAlpha[i] -= 0.1;
	}
	
	TileAlpha[i] = clamp(TileAlpha[i], 0, 1);
}

for (var i = 0; i < array_length(HitOffsetAlphas); i++)
{
	if (HitOffsetAlphas[i] >= 0.01)
		HitOffsetAlphas[i] -= 0.01;
}