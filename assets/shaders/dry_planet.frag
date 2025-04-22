#version 460 core
precision mediump float;
#include <flutter/runtime_effect.glsl>

uniform vec2 iResolution;
uniform float iTime;
uniform float seed;
uniform float size;
uniform float pixels;

uniform vec4 lighterColor;
uniform vec4 lightColor;
uniform vec4 midColor;
uniform vec4 darkColor;
uniform vec4 darkerColor;

// Configuration
float rotation = 0.0;
vec2 light_origin = vec2(0.4, 0.6);
float light_dist1 = 0.362;
float light_dist2 = 0.525;
float time_speed = 0.1;
float dither_size = 2.0;
int octaves = 3;
bool should_dither = true;

// Planet colors
vec4 colors[5] = vec4[5](
    lighterColor,
    lightColor,
    midColor,
    darkColor,
    darkerColor
);

out vec4 fragColor;

float rand(vec2 coord) {
    coord = mod(coord, vec2(2.0,1.0)*round(size));
    return fract(sin(dot(coord.xy, vec2(12.9898,78.233))) * 43758.5453 * seed);
}

float noise(vec2 coord) {
    vec2 i = floor(coord);
    vec2 f = fract(coord);
    float a = rand(i);
    float b = rand(i + vec2(1.0, 0.0));
    float c = rand(i + vec2(0.0, 1.0));
    float d = rand(i + vec2(1.0, 1.0));
    vec2 cubic = f * f * (3.0 - 2.0 * f);
    return mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0 - cubic.x) + (d - b) * cubic.x * cubic.y;
}

float fbm(vec2 coord) {
    float value = 0.0;
    float scale = 0.5;
    for(int i = 0; i < octaves; i++) {
        value += noise(coord) * scale;
        coord *= 2.0;
        scale *= 0.5;
    }
    return value;
}

bool dither(vec2 uv1, vec2 uv2) {
    return mod(uv1.x+uv2.y, 2.0/pixels) <= 1.0 / pixels;
}

vec2 rotate(vec2 coord, float angle) {
    coord -= 0.5;
    coord *= mat2(vec2(cos(angle),-sin(angle)), vec2(sin(angle),cos(angle)));
    return coord + 0.5;
}

vec2 spherify(vec2 uv) {
    vec2 centered = uv * 2.0 - 1.0;
    float z = sqrt(1.0 - dot(centered.xy, centered.xy));
    vec2 sphere = centered/(z + 1.0);
    return sphere * 0.5 + 0.5;
}

void main() {
    vec2 uv = FlutterFragCoord().xy / iResolution;
    uv.x *= iResolution.x / iResolution.y;
    
    // Pixelize and flip Y-axis
    uv = floor(uv * pixels)/pixels;
    uv.y = 1.0 - uv.y;
    
    // Create perfect circle mask with anti-aliasing
    float d_circle = distance(uv, vec2(0.5));
    float circle_alpha = smoothstep(0.5, 0.495, d_circle);
    
    // Early exit for pixels outside planet
    if (circle_alpha <= 0.0) {
        fragColor = vec4(0.0);
        return;
    }
    
    // Apply planet effects only inside the circle
    uv = spherify(uv);
    uv = rotate(uv, rotation);
    
    // Calculate lighting and noise
    float d_light = smoothstep(-0.3, 1.2, distance(uv, light_origin));
    if (d_light < light_dist1) d_light *= 0.9;
    if (d_light < light_dist2) d_light *= 0.9;
    
    float f = fbm(uv * size + vec2(iTime * time_speed, 0.0));
    float c = d_light * pow(f, 0.8) * 3.5;
    
    // Apply dithering if enabled
    if (should_dither && dither(uv, FlutterFragCoord().xy/iResolution.xy)) {
        c += 0.02;
        c *= 1.05;
    }
    
    // Select color with full opacity
    float posterized = floor(c * 4.0)/4.0;
    vec4 col = colors[int(clamp(posterized, 0.0, 1.0) * 4.0)];
    
    // Final output with guaranteed full opacity inside planet
    fragColor = vec4(col.rgb, circle_alpha);
}