function calc_world_matrix(position, rotation, scale){
	return matrix4_multiply(matrix4_translation(position), matrix4_multiply(matrix4_from_quat(rotation), matrix4_scale(scale)));
}