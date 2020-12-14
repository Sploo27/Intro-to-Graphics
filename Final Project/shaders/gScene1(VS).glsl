#version 450 //core

layout (location = 0) in vec4 aPosition;

uniform mat4 uModelMat, uViewMat, uProjMat;

out VS_OUT {
    vec2 vTexcoord;
    //LIGHTING PER-FRAGMENT
	vec4 vLightColor;
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
    
    int highlightExponent = 2;
    
    float specularFocus = power(specularCoef, highlightExponent);
    vec4 specularColor = vec4(1.0);
    //vec4 tex = texture(uTexture, aPosition.xy);
	
	vs_out.vLightColor = specularColor * specularFocus;
	
	gl_Position = uProjMat * uViewMat * uModelMat * aPosition;
    //gl_Position = aPosition;  
    vs_out.vTexcoord = aPosition.xy * 0.5 + 0.5; 
	
	//vs_out.vLightVector = lightVector;
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