#version 460 core

precision highp float;

#include <flutter/runtime_effect.glsl>

uniform vec2 iResolution;
uniform float iTime;
uniform float seed;
uniform float size;
uniform float pixels;

uniform vec4 dustColor;
uniform vec4 lightColor;
uniform vec4 midColor;
uniform vec4 darkColor;

float cloud_cover = 0.5;
vec2 light_origin = vec2(0.4, 0.6);
float time_speed = 0.2;
float stretch = 1.0;
float cloud_curve = 1.0;
float light_border_1 = 0.42;
float light_border_2 = 0.62;
float rotation = 9.0;
const int octaves = 2;

// Colors array - converted to Shadertoy's style
vec4 colors[] = {
    dustColor,
    lightColor,
    midColor,
    darkColor
};

out vec4 fragColor;

// Noise functions
float rand(vec2 coord) {
    coord = mod(coord, vec2(1.0,1.0)*round(size));
    return fract(sin(dot(coord.xy ,vec2(12.9898,78.233))) * 15.5453 * seed);
}

float noise(vec2 coord){
    vec2 i = floor(coord);
    vec2 f = fract(coord);
    
    float a = rand(i);
    float b = rand(i + vec2(1.0, 0.0));
    float c = rand(i + vec2(0.0, 1.0));
    float d = rand(i + vec2(1.0, 1.0));

    vec2 cubic = f * f * (3.0 - 2.0 * f);

    return mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0 - cubic.x) + (d - b) * cubic.x * cubic.y;
}

float fbm(vec2 coord){
    float value = 0.0;
    float scale = 0.5;

    for(int i = 0; i < octaves; i++){
        value += noise(coord) * scale;
        coord *= 2.0;
        scale *= 0.5;
    }
    return value;
}

float circleNoise(vec2 uv) {
    float uv_y = floor(uv.y);
    uv.x += uv_y*.31;
    vec2 f = fract(uv);
    float h = rand(vec2(floor(uv.x),floor(uv_y)));
    float m = (length(f-0.25-(h*0.5)));
    float r = h*0.25;
    return smoothstep(0.0, r, m*0.75);
}

float cloud_alpha(vec2 uv) {
    float c_noise = 0.0;
    
    for (int i = 0; i < 9; i++) {
        c_noise += circleNoise((uv * size * 0.3) + (float(i+1)+10.) + (vec2(iTime*time_speed, 0.0)));
    }
    float fbm = fbm(uv*size+c_noise + vec2(iTime*time_speed, 0.0));
    
    return fbm;
}

bool dither(vec2 uv_pixel, vec2 uv_real) {
    return mod(uv_pixel.x+uv_real.y,2.0/pixels) <= 1.0 / pixels;
}

vec2 spherify(vec2 uv) {
    vec2 centered= uv *2.0-1.0;
    float z = sqrt(1.0 - dot(centered.xy, centered.xy));
    vec2 sphere = centered/(z + 1.0);
    return sphere * 0.5+0.5;
}

vec2 rotate(vec2 coord, float angle){
    coord -= 0.5;
    coord *= mat2(vec2(cos(angle),-sin(angle)),vec2(sin(angle),cos(angle)));
    return coord + 0.5;
}

void main() {
    vec2 uv = FlutterFragCoord().xy / iResolution;
    uv.x *= iResolution.x / iResolution.y;
    uv.y = 1.0 - uv.y;
    
    // Pixelize uv
    uv = floor(uv * pixels) / pixels;
    
    // Distance to light source (restore light origin effect)
    vec2 light_origin = vec2(0.4, 0.6);
    float d_light = distance(uv, light_origin);
    
    // Cut out a solid circle with sharp edges
    float d_circle = distance(uv, vec2(0.5));
    float circle_alpha = step(d_circle, 0.5); // Use step for hard edges
    
    // Early exit for pixels outside planet
    if (circle_alpha <= 0.0) {
        fragColor = vec4(0.0);
        return;
    }
    
    uv = rotate(uv, rotation);
    uv = spherify(uv);
    uv.y += smoothstep(0.0, cloud_curve, abs(uv.x - 0.4));
    
    float c = cloud_alpha(uv * vec2(1.0, stretch));
    
    // Restore light source effect with stronger contrast
    vec4 col = colors[0];
    if (c < cloud_cover + 0.03) {
        col = colors[1];
    }
    // Make light borders more pronounced
    if (d_light + c * 0.3 > light_border_1) {  // Increased from 0.2 to 0.3
        col = colors[2];
    }
    if (d_light + c * 0.3 > light_border_2) {
        col = colors[3];
    }
    
    // Make clouds fully opaque where they exist
    float cloud_alpha = step(cloud_cover - 0.05, c); // Slightly lowered threshold
    
    // Final alpha should be either full cloud or full planet
    float final_alpha = max(circle_alpha, cloud_alpha);
    
    // Boost color intensity to compensate for any remaining transparency
    fragColor = vec4(col.rgb * final_alpha * 1.2, final_alpha);
}