/// @description 로고 그리기

var world = calc_world_matrix(Position, Rotation, Scale);
draw_model(world, Model, sprite_get_texture(spr_Logo, 0), Alpha);