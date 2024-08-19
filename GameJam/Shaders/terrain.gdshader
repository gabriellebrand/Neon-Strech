shader_type spatial;

uniform sampler2D noise;
uniform sampler2D normalmap;
uniform float amplitude = 0.5;

uniform vec4 albedo : source_color = vec4(1.0);
uniform vec4 wire_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float wire_width : hint_range(0.0, 40.0) = 5.0;
uniform float wire_smoothness : hint_range(0.0, 0.1) = 0.01;

uniform int mesh_id = 0;

uniform float modelOpacity : hint_range(0.0, 1.0) = 1.;
const vec3 vectors[3] = {
    vec3(1.0, 0.0 ,0.0),
    vec3(0.0, 1.0 ,0.0),
    vec3(0.0, 0.0 ,1.0)
};
const float MESH_SIZE = 99.0;
const float VELOCITY = 3.0;
const float ROAD_WIDTH = 4.;
const float LIMIT = 8.;

varying vec3 barys;

float height(vec2 position, float time) {
    float no_road = (1.0 - smoothstep(-LIMIT, -ROAD_WIDTH, position.x)) + smoothstep(ROAD_WIDTH, LIMIT, position.x);
    //float no_road = (1.-step(-4,position.x)) + step(4, position.x);
    vec2 uv = position/99. + 0.5;
    float h = texture(noise, uv).x*no_road;
    return h;
}


void vertex() {
    vec2 pos = VERTEX.xz;
    float k = amplitude*height(pos, TIME);
    VERTEX.y = k;

    if (mesh_id == 0)
        VERTEX.z = VERTEX.z + VELOCITY*mod(TIME+MESH_SIZE/VELOCITY, 2.0*MESH_SIZE/VELOCITY);
    else
        VERTEX.z = VERTEX.z + VELOCITY*mod(TIME, 2.0*MESH_SIZE/VELOCITY);


    NORMAL = normalize(vec3(k - height(pos + vec2(0.1, 0.0), TIME),
        0.1, k - height(pos + vec2(0.0, 0.8), TIME)));
        barys = vectors[VERTEX_ID % 3];

    //COLOR = VERTEX
}

void fragment() {
    vec3 deltas = fwidth(barys);
    vec3 barys_s = smoothstep(deltas * wire_width - wire_smoothness, deltas * wire_width + wire_smoothness, barys);
    float wires = min(barys_s.x, min(barys_s.y, barys_s.z));

    ALBEDO = mix(wire_color.rgb, albedo.rgb, wires);
    //ALPHA = mix(1., modelOpacity, wires);
}

//void light() {
    // Called for every pixel for every light affecting the material.
    // Uncomment to replace the default light processing function with this one.
//}
