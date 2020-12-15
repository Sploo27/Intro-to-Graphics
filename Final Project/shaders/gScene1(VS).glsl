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

#version 450 //core

layout (location = 0) in vec4 aPosition;

uniform mat4 uModelMat, uViewMat, uProjMat;

out VS_OUT {
    vec2 vTexcoord;
    //LIGHTING PER-FRAGMENT
	vec4 vLightColor;
	bool vSmooth;
} vs_out;

//LIGHTING
struct pointLight
{
	vec4 center;
	vec4 color;
	float intensity;
};

void initPointLight(out pointLight pLight, in vec3 center, in vec4 color, in float intensity)
{
    pLight.center = vec4(center, 1.0);
    pLight.color = color;
    pLight.intensity = intensity;
}


//OPTIMIZATION
float power(in float base, in int ex)
{
    for(int i = 0; i < ex; ++i)
    {
        base *= base;
    }
    return base;
}


void main()
{
    
    
    //LIGHTING
	pointLight phongLight;
	initPointLight(phongLight, vec3(1.0, -1.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), 0.0);
	
	//diffuse intensity
	vec3 lightVector = phongLight.center.xyz - aPosition.xyz;
	
	//phong reflectance
	vec3 viewVector = normalize(aPosition.xyz);
    vec3 reflectedLightVector = reflect(-normalize(lightVector), vec3(0.0));
    float specularCoef = max(0.0, dot(viewVector, reflectedLightVector));
    
    int highlightExponent = 1;
    
    float specularFocus = power(specularCoef, highlightExponent);
    vec4 specularColor = vec4(1.0);
    //vec4 tex = texture(uTexture, aPosition.xy);
	
	vs_out.vLightColor = specularColor * specularFocus; 
				//this is how each triangle is given lighting
				//passed to geometry for each triangle then 
				//passed on to the fragment shader
	
	gl_Position = uProjMat * uViewMat * uModelMat * aPosition;
    
    //gl_Position = aPosition;  
    vs_out.vTexcoord = aPosition.xy * 0.5 + 0.5; 
	
	//vs_out.vLightVector = lightVector;
	
	
	//controls what the geometry shader does
	vs_out.vSmooth = false;
	
	//true just passes the triangles through the GS without change
	//false breaks up each triangle into three triangles
}






/*  //original vertex shader from the SHADERed example
layout (location = 0) in vec4 aPosition;
layout (location = 1) in vec3 aNormal;

out VS_OUT {
    vec3 normal;
} vs_out;

uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;

void main()
{
    mat3 normalMatrix = mat3(transpose(inverse(view * model)));
    vs_out.normal = vec3(projection * vec4(normalMatrix * aNormal, 0.0));
    gl_Position = projection * view * model * aPosition; 
    //gl_Position = projection * view * aPos;   
}
*/