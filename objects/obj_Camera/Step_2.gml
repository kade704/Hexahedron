/// @description  위치 업데이트

Scale = lerp(Scale, TargetScale, SmoothSpeed);
Position = vector3_lerp(Position, TargetPosition, SmoothSpeed);
Rotation = quaternion_slerp(Rotation, TargetRotation, SmoothSpeed);
