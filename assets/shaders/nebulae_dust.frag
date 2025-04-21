#version 460 core

precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 iResolution;
uniform float iTime;
uniform float seed;
uniform float size;
uniform float pixels;
int octaves = 5;
float should_tile = 1.0;
float reduce_background = 0.0;
vec2 uv_correct = vec2(1.0);

out vec4 fragColor;

vec3 colorscheme(float x) {
    // Example: warm dust colors
    vec3 dark = vec3(0.0, 0.0, 0.1);
    vec3 light = vec3(0.0, 1.0, 1.0);
    return mix(dark, light, x);
}

float rand(vec2 coord, float tilesize) {
    if (should_tile == 1.0) {
        coord = mod(coord / uv_correct, tilesize);
    }
    return fract(sin(dot(coord.xy ,vec2(12.9898,78.233))) * (15.5453 + seed));
}

float noise(vec2 coord, float tilesize) {
    vec2 i = floor(coord);
    vec2 f = fract(coord);

    float a = rand(i, tilesize);
    float b = rand(i + vec2(1.0, 0.0), tilesize);
    float c = rand(i + vec2(0.0, 1.0), tilesize);
    float d = rand(i + vec2(1.0, 1.0), tilesize);

    vec2 cubic = f * f * (3.0 - 2.0 * f);

    return mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0 - cubic.x) + (d - b) * cubic.x * cubic.y;
}

float fbm(vec2 coord, float tilesize) {
    float value = 0.0;
    float scale = 0.5;

    for(int i = 0; i < octaves; i++) {
        value += noise(coord, tilesize) * scale;
        coord *= 2.0;
        scale *= 0.5;
    }
    return value;
}

bool dither(vec2 uv1, vec2 uv2) {
    return mod(uv1.y+uv2.x,2.0/pixels) <= 1.0 / pixels;
}

float circleNoise(vec2 uv, float tilesize) {
    if (should_tile == 1.0) {
        uv = mod(uv, tilesize);
    }

    float uv_y = floor(uv.y);
    uv.x += uv_y*.31;
    vec2 f = fract(uv);
    float h = rand(vec2(floor(uv.x),floor(uv_y)), tilesize);
    float m = (length(f-0.25-(h*0.5)));
    float r = h*0.25;
    return smoothstep(0.0, r, m*0.75);
}

vec2 rotate(vec2 vec, float angle) {
    vec -=vec2(0.5);
    vec *= mat2(vec2(cos(angle),-sin(angle)), vec2(sin(angle),cos(angle)));
    vec += vec2(0.5);
    return vec;
}

float cloud_alpha(vec2 uv, float tilesize) {
    float c_noise = 0.0;

    // more iterations for more turbulence
    int iters = 2;
    for (int i = 0; i < iters; i++) {
        c_noise += circleNoise(uv * 0.5 + (float(i+1)) + vec2(-0.3, 0.0), ceil(tilesize * 0.5));
    }
    float fbm = fbm(uv+c_noise, tilesize);

    return fbm;
}

void main() {
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = FlutterFragCoord().xy / iResolution;
    uv.x *= iResolution.x / iResolution.y;
    uv.y = 1.0 - uv.y;
    
    // pixelizing and dithering
    vec2 pixelUV = floor(uv * pixels) / pixels * uv_correct;
    bool dith = dither(pixelUV, uv);

    // noise for the dust
    float n_alpha = fbm(pixelUV * ceil(size * 0.5) + vec2(2,2), ceil(size * 0.5));
    float n_dust = cloud_alpha(pixelUV * size + vec2(iTime*0.1), size);
    float n_dust2 = fbm(pixelUV * ceil(size * 0.2) - vec2(2,2), ceil(size * 0.2));
    float n_dust_lerp = n_dust2 * n_dust;

    // apply dithering
    if (dith) {
        n_dust_lerp *= 0.95;
    }

    // choose alpha value
    float a_dust = smoothstep(0.3, 0.7, n_dust_lerp * 1.8);
    n_dust_lerp = pow(n_dust_lerp, 3.2) * 56.0;
    if (dith) {
        n_dust_lerp *= 1.1;
    }

    // choose & apply colors
    if (reduce_background == 1.0) {
        n_dust_lerp = pow(n_dust_lerp, 0.8) * 0.7;
    }

    float col_value = floor(n_dust_lerp) / 7.0;
    vec3 col = colorscheme(col_value);

    fragColor = vec4(col, a_dust);
}
