attribute vec3 in_Position;
attribute vec2 in_TextureCoord;
attribute vec3 in_Normal;

varying vec2 v_vTexcoord;
varying vec3 v_vNormal;

uniform mat4 _world;

void main()
{
	v_vTexcoord = in_TextureCoord;
	v_vNormal = mat3(_world) * in_Normal;   
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * _world * vec4(in_Position, 1.0);
}
