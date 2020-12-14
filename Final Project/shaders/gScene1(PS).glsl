#version 450 //core

out vec4 FragColor;


void main()
{
    FragColor = vec4(0.5, 0.0, 0.5, 1.0);
}
/*
#ifdef GL_ES
precision highp float;
#endif //GL_ES

uniform sampler2D uTex;

in vec2 vTexcoord;

layout (location = 0) out vec4 rtFragColor;

void main()
{
	vec2 uv = vTexcoord;
	vec4 col = texture(uTex, uv);
	
	rtFragColor = col;	
}
*/