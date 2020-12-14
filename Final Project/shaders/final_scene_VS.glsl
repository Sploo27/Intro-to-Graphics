#version 450

layout (location = 0) in vec4 aPosition;

out vec2 vTexcoord;

void main()
{
	gl_Position = aPosition;
	vTexcoord = aPosition.xy * 0.5 + 0.5;
	// NDC -> screen : [-1, +1] -> [0,1]
}