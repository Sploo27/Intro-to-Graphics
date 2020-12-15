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

#version 450

#ifdef GL_ES
precision highp float;
#endif //GL_ES


uniform sampler2D uTex;

out vec4 rtFragColor;

//VARYING
in vec2 vTexcoord;


void main()
{
	vec2 uv = vTexcoord;

	/*float kernel[9] = 
	{
		-1.0, -1.0, -1.0,
        -1.0,  9.0, -1.0,
        -1.0, -1.0, -1.0
	};
       
	vec4 sampleTex[9];
	for(int i = 0; i < 9; i++)
		sampleTex[i] = vec4(texture(uTex, uv));
		
	vec4 col = vec4(1.0);
	for(int i = 0; i < 9; i++)
		col += sampleTex[i] * kernal[i];*/


	
	
	rtFragColor = texture(uTex, uv); 
	
}