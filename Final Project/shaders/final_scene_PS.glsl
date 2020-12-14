#version 450

#ifdef GL_ES
precision highp float;
#endif //GL_ES


uniform sampler2D uTex;

//VARYING
in vec2 vTexcoord;

out vec4 rtFragColor;

void main()
{
	//texturing
	//sampler, uv
	// 1) uv  = fragCoord / resolution
	// 2) texture coordinate
	
	//vec2 uv = gl_FragCoord.xy / uResolution;
	vec2 uv = vTexcoord;
	
	
	rtFragColor = texture(uTex, uv);
}