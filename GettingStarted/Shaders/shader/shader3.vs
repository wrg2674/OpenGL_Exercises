#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aColor;

uniform float move;
out vec3 ourColor;
out vec3 position;

void main(){
	gl_Position = vec4(aPos.x+move, -(aPos.y), aPos.z, 1.0f);
	position = vec3(aPos.x, aPos.y, aPos.z);
	ourColor = aColor;
}