#version 330 core
out vec4 FragColor;

in vec3 Normal;
in vec3 FragPos;

uniform vec3 lightPos;
uniform vec3 viewPos;
uniform vec3 lightColor;
uniform vec3 objectColor;

void main(){
	float ambientStrength = 0.5f;
	vec3 ambient = ambientStrength * lightColor;
	
	float diffuseStrength = 1.3f;
	vec3 norm = normalize(Normal);
	vec3 lightDir = normalize(lightPos - FragPos);
	float diff = max(dot(norm, lightDir), 0.0f);
	vec3 diffuse = diffuseStrength*diff * lightColor;

	float specularStrength = 0.7f;
	vec3 viewDir = normalize(viewPos - FragPos);
	vec3 reflecDir = 2*norm*dot(norm, lightDir) - lightDir;
	float spec = pow(max(dot(viewDir, reflecDir), 0.0f), 64);
	vec3 specular = specularStrength*spec*lightColor;
	
	vec3 result = (ambient+diffuse+specular)*objectColor;
	FragColor = vec4(result, 1.0f);
} 