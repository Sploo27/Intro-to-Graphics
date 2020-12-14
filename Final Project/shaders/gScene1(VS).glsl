#version 450 //core

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