shader_type spatial;
uniform sampler2D fracture_texture : filter_nearest_mipmap;
uniform vec3 primary: source_color = vec3(0.53, 0.369, 0.185);
uniform int bpm = 120;
uniform float time_offset = 0.0;
uniform int seed = 0;

vec3 shift_hue(in vec3 color, in float shift) {
	// The unit gray vector in RGB color space.
	vec3 gray = vec3(0.57735);
	// Project color onto gray axis.
	vec3 projection = gray * dot(gray, color.rgb);
	// Vector from gray axis to original color.
	vec3 U = color.rgb - projection;
	// Vector perpendicular to gray axis and U.
	vec3 V = cross(gray, U);
	// Rotate U and V around the gray axis.
	vec3 shifted = U * cos(shift * 2.0 * PI) + V * sin(shift * 2.0 * PI) + projection;
	return shifted;
}


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float beat = abs(cos((TIME + time_offset) * (float(bpm) / 60.0) * PI));
	float seed_power = (7.0 - float(seed%7)) / 7.0;
	vec4 base = texture(fracture_texture, (UV + (vec2(float(seed%1024) * 1.61803398874989484820459))) * (seed_power + 0.5));
	float shift = base.g;
	vec3 cracks = primary * clamp(base.r * (beat + 0.1), 0.0, 1.0);

	ALBEDO = clamp(shift_hue( primary * ( 1.0 - (base.g)), -base.g * 0.25 ), vec3(0.0), vec3(1.0)) + cracks;
	EMISSION = cracks * 2.5 * (seed_power + 1.1);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
