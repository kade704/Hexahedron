function shader_set_uniform_float(shader, name, value){
	shader_set_uniform_f(shader_get_uniform(shader, name), value);
}

function shader_set_uniform_vec3(shader, name, vec3) {
	shader_set_uniform_f(shader_get_uniform(shader, name), vec3.x, vec3.y, vec3.z);
}

function shader_set_uniform_vec4(shader, name, vec4) {
	shader_set_uniform_f(shader_get_uniform(shader, name), vec4.x, vec.y, vec4.z, vec4.w);
}

function shader_set_uniform_matrix4(shader, name, mat4) {
	shader_set_uniform_matrix_array(shader_get_uniform(shader, name), mat4);
}