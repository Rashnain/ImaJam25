shader_type sky;

uniform sampler2D skybox;

void sky() {
	// Called for every visible pixel in the sky background, as well as all pixels
	// in the radiance cubemap.
	COLOR = texture(skybox, SKY_COORDS).xyz;
}
