/// @description 타일 그리기

if (Alpha > 0) {
	var world = calc_world_matrix(Position, Rotation, Scale);
	draw_model(world, obj_AssetManager.TileFaseModel, obj_AssetManager.TileFastTexture, Alpha);
}
