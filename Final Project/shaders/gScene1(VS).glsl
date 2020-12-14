#version 450 //core

layout (location = 0) in vec4 aPosition;

uniform mat4 uModelMat, uViewMat, uProjMat;



out VS_OUT {
    vec2 vTexcoord;
} vs_out;

void main()
{
    gl_Position = uProjMat * uViewMat * uModelMat * aPosition;
    //gl_Position = projection * view * aPos;  
    
     vs_out.vTexcoord = aPosition.xy * 0.5 + 0.5; 
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