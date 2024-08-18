#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;

out vec3 FragPos;
out vec3 Normal;

out vec3 color;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform vec3 lightPos;
uniform vec3 viewPos;
uniform vec3 lightColor;
uniform vec3 objectColor;

void main(){
	FragPos = vec3(model*vec4(aPos, 1.0f));
	Normal = mat3(transpose(inverse(model)))*aNormal;
	gl_Position = projection * view * model* vec4(aPos, 1.0f);

	float ambientStrength = 0.1f;
	vec3 ambient = ambientStrength*lightColor;

	vec3 norm = normalize(Normal);
	vec3 lightDir = normalize(lightPos - FragPos);
	float diff = max(dot(norm, lightDir), 0.0f);
	vec3 diffuse = diff * lightColor;

	float specularStrength = 0.9f;
	vec3 viewDir = normalize(viewPos - FragPos);
	vec3 reflectDir = 2*norm*dot(norm, lightDir) - lightDir;
	float spec = pow(max(dot(viewDir, reflectDir), 0.0f), 64);
	vec3 specular = specularStrength*spec*lightColor;

	vec3 result = (ambient+diffuse+specular)*objectColor;
	color = result;
}