/// @description 변수 초기화

Model = load_model("Model/TileSlow.obj");
Texture = sprite_get_texture(spr_TileSlow, 0);

Alpha = 1;

///위치 초기화

Position = vector3_zero();
Rotation = quaternion_identity();
Scale = vector3_create(5, 5, 5);

