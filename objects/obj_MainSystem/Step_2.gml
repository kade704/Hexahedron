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
    obj_Camera.TargetPosition = Positions[CubeIndex];
	obj_Camera.TargetRotation = Rotations[CubeIndex];
}

// 타일 모습 변경
for (var i = 0; i < DataLength; i++)
{
	if (TileVisible[i]) {
		TileAlpha[i] += 0.05;	
	} else {
		TileAlpha[i] -= 0.2;
	}
	
	TileAlpha[i] = clamp(TileAlpha[i], 0, 1);
}