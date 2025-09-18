/// @description 로고 그리기

var world = calc_world_matrix(Position, Rotation, Scale);
draw_model(world, obj_AssetManager.ControlModel, obj_AssetManager.LogoTexture, Alpha);