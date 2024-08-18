shader_type spatial;

uniform sampler2D noise;
uniform sampler2D normalmap;
uniform float height_scale = 0.5;

uniform vec4 albedo : source_color = vec4(1.0);
uniform vec4 wire_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float wire_width : hint_range(0.0, 40.0) = 5.0;
uniform float wire_smoothness : hint_range(0.0, 0.1) = 0.01;

uniform float modelOpacity : hint_range(0.0, 1.0) = 1.;
const vec3 vectors[3] = {
	vec3(1.0, 0.0 ,0.0),
	vec3(0.0, 1.0 ,0.0),
	vec3(0.0, 0.0 ,1.0)
};

varying vec3 barys;

float height(vec2 position, float time) {
    vec2 offset = 0.05 * cos(position + time);
    return texture(noise, position / 32.0 + 0.5 - offset).x;
}

void vertex() {
    vec2 pos = VERTEX.xz;
    float k = height(pos, TIME);
    VERTEX.y = k;

    NORMAL = normalize(vec3(k - height(pos + vec2(0.1, 0.0), TIME),
        0.1, k - height(pos + vec2(0.0, 0.1), TIME)));
        barys = vectors[VERTEX_ID % 3];
}

void fragment() {
    vec3 deltas = fwidth(barys);
	vec3 barys_s = smoothstep(deltas * wire_width - wire_smoothness, deltas * wire_width + wire_smoothness, barys);
	float wires = min(barys_s.x, min(barys_s.y, barys_s.z));

	ALBEDO = mix(wire_color.rgb, albedo.rgb, wires);
    ALPHA = mix(1., modelOpacity, wires);

}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
