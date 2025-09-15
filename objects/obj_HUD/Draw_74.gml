/// @description 포스트 프로세싱

shader_set(shd_PostProcessing);
shader_set_uniform_float(shd_PostProcessing, "_minRadius", VignetteRadiusMin);
shader_set_uniform_float(shd_PostProcessing, "_maxRadius", VignetteRadiusMax);
draw_surface(application_surface, 0, 0);
shader_reset();

