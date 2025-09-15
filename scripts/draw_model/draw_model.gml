function draw_model(matrix, model, texture, alpha){
	shader_set(shd_Lighting);
	
	shader_set_uniform_matrix4(shd_Lighting, "_world", matrix)
	shader_set_uniform_float(shd_Lighting, "_alpha", alpha);
	
	vertex_submit(model, pr_trianglelist, texture);
	shader_reset();
}