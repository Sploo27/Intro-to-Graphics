#version 450 //core


#ifdef GL_ES
precision highp float;
#endif //GL_ES

layout (location = 0) out vec4 rtFragColor;

uniform sampler2D uTex;

in vec2 gTexcoord;

//Lighting PER-FRAGMENT
in vec4 gLightColor;


void main()
{
	vec2 uv = gTexcoord;
	vec4 col = texture(uTex, uv);
	
	
	rtFragColor = col * gLightColor;	
	//rtFragColor = specularFocus * specularColor;
}



/*
out vec4 FragColor;


void main()
{
    FragColor = vec4(0.5, 0.0, 0.5, 1.0);
}*/