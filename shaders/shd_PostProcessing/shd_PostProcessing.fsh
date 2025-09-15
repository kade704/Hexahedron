varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float _minRadius;
uniform float _maxRadius;

void main()
{
    vec3 _baseColour = (v_vColour * texture2D( gm_BaseTexture, v_vTexcoord)).rgb;
    
    //Vignette
    float _radius = smoothstep(_minRadius, _maxRadius, distance(vec2(0.5), v_vTexcoord));
    vec3 _vignette = _baseColour * (1.0 - _radius);
    
    gl_FragColor = vec4(_vignette, 1.0);
}
