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

//PRIMITIVE INPUT
layout (triangles) in; 
//input primitives: (# in parenthesis is the number of verticies per primitive))
//points (1)
//lines (2)
//lines_adjacency (4)
//triangles (3)
//triangles_adjacency (6)

//PRIMITIVE OUTPUT
layout (triangle_strip, max_vertices = 12) out; 
//output primitives:
//points
//line_strip
//triangle_strip

in VS_OUT {
    vec2 vTexcoord;
    vec4 vLightColor;
    bool vSmooth;
} gs_in[];

out vec2 gTexcoord;
out vec4 gLightColor;

//out GS_OUT {
//	vec2 gTexcoord;
//} gs_out;



uniform mat4 uModelMat, uViewMat, uProjMat;


void createTriangle(vec3 offset)
{
	gl_Position = (gl_in[2].gl_Position * 0.5) + vec4(offset, 0.0);
	gTexcoord = gs_in[2].vTexcoord;
	gLightColor = gs_in[2].vLightColor;
	EmitVertex();
	
	for(int i = 0; i < gl_in.length(); i++)
	{	
		gl_Position = (gl_in[i].gl_Position * 0.5) + vec4(offset, 0.0);
		gTexcoord = gs_in[i].vTexcoord;
		gLightColor = gs_in[i].vLightColor;
		EmitVertex();
	}
	
	
}

void main() {

	if(gs_in[0].vSmooth == true)
	{
		gl_Position = gl_in[0].gl_Position; 
		gTexcoord = gs_in[0].vTexcoord;
		gLightColor = gs_in[0].vLightColor;
	    EmitVertex();
	    
	    gl_Position = gl_in[1].gl_Position; 
	    gTexcoord = gs_in[1].vTexcoord;
	    gLightColor = gs_in[1].vLightColor;
	    EmitVertex();
	    
	    gl_Position = gl_in[2].gl_Position; 
	    gTexcoord = gs_in[2].vTexcoord;
	    gLightColor = gs_in[2].vLightColor;
	    EmitVertex();
	    
	    
	    gl_Position = gl_in[0].gl_Position; 
	    gTexcoord = gs_in[0].vTexcoord;
	    gLightColor = gs_in[0].vLightColor;
	    EmitVertex();		//I found this last one makes it viewable on both sides
	    
	    
	    EndPrimitive(); //this prints out each triangle in the geometry
	
	}
	
	else
	{
		float temp0x = gl_in[0].gl_Position.x - (gl_in[0].gl_Position.x * 0.5);//calculations for where each new triangle should be positioned
	    float temp1x = gl_in[1].gl_Position.x - (gl_in[1].gl_Position.x * 0.5);
	    float temp2x = gl_in[2].gl_Position.x - (gl_in[2].gl_Position.x * 0.5);
	    
	    float temp0y = gl_in[0].gl_Position.y - (gl_in[0].gl_Position.y * 0.5);
	    float temp1y = gl_in[1].gl_Position.y - (gl_in[1].gl_Position.y * 0.5);
	    float temp2y = gl_in[2].gl_Position.y - (gl_in[2].gl_Position.y * 0.5);
	    
	    createTriangle(vec3(temp0x, temp0y, 0));   //need to do the math to find where each line should go based on triangle verticies given by vertex shader   
	   	//gl_Position = uProjMat * uViewMat * uModelMat * gl_Position;
	   	EndPrimitive();
	   	
	   	createTriangle(vec3(temp1x, temp1y, 0)); 
	   	//gl_Position = uProjMat * uViewMat * uModelMat * gl_Position;
	   	EndPrimitive();
	   	
	   	createTriangle(vec3(temp2x, temp2y, 0));   
	   	//gl_Position = uProjMat * uViewMat * uModelMat * gl_Position;
	   	EndPrimitive();
	
	}
/*
	gl_Position = gl_in[0].gl_Position; 
	gTexcoord = gs_in[0].vTexcoord;
	gLightColor = gs_in[0].vLightColor;
    EmitVertex();
    
    gl_Position = gl_in[1].gl_Position; 
    gTexcoord = gs_in[1].vTexcoord;
    gLightColor = gs_in[1].vLightColor;
    EmitVertex();
    
    gl_Position = gl_in[2].gl_Position; 
    gTexcoord = gs_in[2].vTexcoord;
    gLightColor = gs_in[2].vLightColor;
    EmitVertex();
    
    
    gl_Position = gl_in[0].gl_Position; 
    gTexcoord = gs_in[0].vTexcoord;
    gLightColor = gs_in[0].vLightColor;
    EmitVertex();		//I found this last one makes it viewable on both sides
    
    
    EndPrimitive(); //this prints out each triangle in the geometry
    
    
    float temp0x = gl_in[0].gl_Position.x - (gl_in[0].gl_Position.x * 0.5);//calculations for where each new triangle should be positioned
    float temp1x = gl_in[1].gl_Position.x - (gl_in[1].gl_Position.x * 0.5);
    float temp2x = gl_in[2].gl_Position.x - (gl_in[2].gl_Position.x * 0.5);
    
    float temp0y = gl_in[0].gl_Position.y - (gl_in[0].gl_Position.y * 0.5);
    float temp1y = gl_in[1].gl_Position.y - (gl_in[1].gl_Position.y * 0.5);
    float temp2y = gl_in[2].gl_Position.y - (gl_in[2].gl_Position.y * 0.5);
    
    createTriangle(vec3(temp0x, temp0y, 0));   //need to do the math to find where each line should go based on triangle verticies given by vertex shader   
   	//gl_Position = uProjMat * uViewMat * uModelMat * gl_Position;
   	EndPrimitive();
   	
   	createTriangle(vec3(temp1x, temp1y, 0)); 
   	//gl_Position = uProjMat * uViewMat * uModelMat * gl_Position;
   	EndPrimitive();
   	
   	createTriangle(vec3(temp2x, temp2y, 0));   
   	//gl_Position = uProjMat * uViewMat * uModelMat * gl_Position;
   	EndPrimitive();
    */
    
}  


/*
gl_Position = gl_in[0].gl_Position + vec4(0.0, 0.0, 0.0, 0.0);
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();
    
    gl_Position = gl_in[2].gl_Position;
    EmitVertex();
    
    gl_Position = gl_in[0].gl_Position; 
    EmitVertex();		//I found this last one makes it viewable on both sides
    
    
    EndPrimitive();
   */ 


/* original geometry shader example from SHADERed
layout (triangles) in;
layout (line_strip, max_vertices = 12) out;

in VS_OUT {
    vec3 normal;
} gs_in[];

void GenerateLine(int i)
{
    gl_Position = gl_in[i].gl_Position;
    EmitVertex();
    gl_Position = gl_in[i].gl_Position + vec4(gs_in[i].normal, 1.0) * MAGNITUDE;
    EmitVertex();
    EndPrimitive();
}

void main()
{
    GenerateLine(0); // first vertex normal
    GenerateLine(1); // second vertex normal
    GenerateLine(2); // third vertex normal
}*/

