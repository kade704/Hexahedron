//  큐브 이동
CubeAngle += CubeRotateSpeed;
CubeAngle = min(CubeAngle, 0);
var angleRot = quaternion_from_angle_axis(vector3_y(), CubeAngle);
obj_Cube.Rotation = quaternion_multiply(CubeRotation, angleRot);
obj_Cube.Position = CubePosition;

//  카메라 이동
obj_Camera.TargetPosition = obj_Cube.Position;
