

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
	//gl_Position = uProjMat * uViewMat * uModelMat * gl_Position;
	EmitVertex();
	
	for(int i = 0; i < gl_in.length(); i++)
	{	
		gl_Position.xyz = (gl_in[i].gl_Position.xyz * 0.5) + offset;
		gTexcoord = gs_in[i].vTexcoord;
		gLightColor = gs_in[i].vLightColor;
		//gl_Position = uProjMat * uViewMat * uModelMat * gl_Position;
		EmitVertex();
	}
	//gl_Position = uProjMat * uViewMat * uModelMat * gl_Position;
	
}

void main() {
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
    */
    
    float temp0x = gl_in[0].gl_Position.x - (gl_in[0].gl_Position.x * 0.5);//calculations for where each new triangle should be positioned
    float temp1x = gl_in[1].gl_Position.x - (gl_in[1].gl_Position.x * 0.5);
    float temp2x = gl_in[2].gl_Position.x - (gl_in[2].gl_Position.x * 0.5);
    
    float temp0y = gl_in[0].gl_Position.y - (gl_in[0].gl_Position.y * 0.5);
    float temp1y = gl_in[1].gl_Position.y - (gl_in[1].gl_Position.y * 0.5);
    float temp2y = gl_in[2].gl_Position.y - (gl_in[2].gl_Position.y * 0.5);
    
    createTriangle(vec3(temp0x, temp0y, 0));   //need to do the math to find where each line should go based on triangle verticies given by vertex shader   
   	
   	EndPrimitive();
   	
   	createTriangle(vec3(temp1x, temp1y, 0)); 
   	  
   	EndPrimitive();
   	
   	createTriangle(vec3(temp2x, temp2y, 0));   
   	
   	EndPrimitive();
    
    
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

