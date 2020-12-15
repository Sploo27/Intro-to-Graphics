/*
Author: Mitko Ivanov
Class: GPR-200-01/02/03: Introduction to Modern Graphics Programming
Assignment: Lab 7: Vertex Shaders
Date Assigned: 11/10/2020
Due Date: 12/15/2020
Description: Use SHADERed to demonstrate what I have learned throughout the semester
Certification of Authenticity:
I certify that this is entirely my own work, except where I have given
fully-documented references to the work of others. I understand the
definition and consequences of plagiarism and acknowledge that the assessor
of this assignment may, for the purpose of assessing this assignment:
- Reproduce this assignment and provide a copy to another member of
academic staff; and/or
- Communicate a copy of this assignment to a plagiarism checking
service (which may then retain a copy of this assignment on its
database for the purpose of future plagiarism checking)

Using influence from:

- Given code from the SHADERed example of geometry shaders

- leared further about geometry shaders from: 
	- https://learnopengl.com/Advanced-OpenGL/Geometry-Shader
	- https://www.lighthouse3d.com/tutorials/glsl-tutorial/geometry-shader-examples/


*/

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



/*original fragment shader from SHADERed example
out vec4 FragColor;


void main()
{
    FragColor = vec4(0.5, 0.0, 0.5, 1.0);
}*/