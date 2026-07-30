shader_type spatial;
render_mode cull_front;

uniform float outline_width = 0.03;
uniform vec4 outline_color = vec4(0.0,0.0,0.0,1.0);


void vertex() {
	VERTEX += NORMAL * outline_width;
}

void fragment() {
	ALBEDO = outline_color.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
