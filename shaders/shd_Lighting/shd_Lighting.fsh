varying vec2 v_vTexcoord;
varying vec3 v_vNormal;

uniform float _alpha;

void main()
{
    vec3 _lightDir = vec3(-10, -30, -20);
    
    vec3 _baseCol = texture2D(gm_BaseTexture, v_vTexcoord).rgb;
    
    float _minIntensity = 0.85;
    float _maxIntensity = 1.0;
    
    float _intensity = abs(dot(normalize(v_vNormal), normalize(_lightDir)));
    
    vec3 _colour = _baseCol * mix(_minIntensity, _maxIntensity, _intensity);
    gl_FragColor = vec4(_colour, _alpha);
}
