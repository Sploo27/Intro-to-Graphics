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

- learned some kernal tequniques from:
 	-https://learnopengl.com/Advanced-OpenGL/Framebuffers
*/

#version 450

#ifdef GL_ES
precision highp float;
#endif //GL_ES


uniform sampler2D uTex;

out vec4 rtFragColor;

//VARYING
in vec2 vTexcoord;

float kernel1[] = float[] ( //sharpen
		-1.0, -1.0, -1.0,
        -1.0,  9.0, -1.0,
        -1.0, -1.0, -1.0);
      
       
 
float kernel2[] = float[] ( //edge detection
		1.0, 1.0, 1.0,
        1.0,  -8.0, 1.0,
        1.0, 1.0, 1.0);
 
 
 
float kernel3[] = float[] ( //blur
		1.0 / 16.0, 2.0 / 16.0, 1.0 / 16.0,
        2.0 / 16.0, 4.0 / 16.0, 2.0 / 16.0,
        1.0 / 16.0, 2.0 / 16.0, 1.0 / 16.0);            



float kernel4[] = float[] ( //custom
		 4.0,  -2.0,  4.0,
        -2.0,  -7.0, -2.0,
         4.0,  -2.0,  4.0);


const float offset = 1.0 / 300.0;  //controls intensity of the effect

vec2 offsets[] = vec2[]( //without these the effect would not work
        vec2(-offset,  offset), // top-left
        vec2( 0.0,    offset), // top-center
        vec2( offset,  offset), // top-right
        vec2(-offset,  0.0),   // center-left
        vec2( 0.0,    0.0),   // center-center
        vec2( offset,  0.0),   // center-right
        vec2(-offset, -offset), // bottom-left
        vec2( 0.0,   -offset), // bottom-center
        vec2( offset, -offset)  // bottom-right    
    );//using influence from  : https://learnopengl.com/Advanced-OpenGL/Framebuffers

void main()
{
	vec2 uv = vTexcoord;

	
       
	vec4 tempTex[offsets.length()];
	for(int i = 0; i < offsets.length(); i++)
		tempTex[i] = vec4(texture(uTex, uv + offsets[i])); //add the offsets to  
												//current texture coordinate
		
	vec4 sharp, edge, blur, custom = vec4(0.0);
	
	for(int i = 0; i < kernel1.length(); i++) //then we multiply the texture values by the kernel
	{
		sharp += tempTex[i] * kernel1[i];
		edge += tempTex[i] * kernel2[i];
		blur += tempTex[i] * kernel3[i];
		custom += tempTex[i] * kernel4[i];
	}//using influence from  : https://learnopengl.com/Advanced-OpenGL/Framebuffers
		


	
	
	rtFragColor = texture(uTex, uv);  //original image
	
	//rtFragColor = sharp;  //sharpen effect
	
	//rtFragColor = edge; //edge detection effect
	
	//rtFragColor = blur; //blur effect
	
	//rtFragColor = custom; //made up effect,
						  //kind of a combination of sharpen and edge detection
	
	
}