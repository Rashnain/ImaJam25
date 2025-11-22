shader_type sky;

uniform vec4 northSkyColor;
uniform vec4 southSkyColor;
uniform sampler2D skybox;

void sky() {
	if (EYEDIR.z < 0.0) {COLOR = northSkyColor.xyz;}
	else {COLOR = southSkyColor.xyz;}
}
