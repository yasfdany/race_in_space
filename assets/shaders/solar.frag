#version 460 core
precision highp float;
#include <flutter/runtime_effect.glsl>

uniform vec2 iResolution;
uniform float iTime;
uniform float pixels;
uniform vec4 darkColor;
uniform vec4 midColor;
uniform vec4 lightColor;
uniform vec4 lightestColor;

out vec4 fragColor;

vec2 hash22(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.xx+p3.yz)*p3.zy);
}

float cellular(vec2 p, float numCells) {
    p *= numCells;
    vec2 ip = floor(p);
    vec2 fp = fract(p);
    float d = 1.0;
    
    for(int y = -1; y <= 1; y++) {
        for(int x = -1; x <= 1; x++) {
            vec2 neighbor = vec2(float(x), float(y));
            vec2 point = hash22(mod(ip + neighbor, numCells));
            point = 0.5 + 0.5*sin(iTime + 6.2831*point);
            vec2 diff = neighbor + point - fp;
            d = min(d, dot(diff, diff));
        }
    }
    return sqrt(d);
}

void main() {
    vec2 uv = FlutterFragCoord().xy / iResolution.y;
    uv.x *= iResolution.x / iResolution.y;
    
    // Pixelization
    vec2 pixelized = floor(uv * pixels) / pixels;
    
    // Circle mask - using step() for crisp edges
    float dist = distance(pixelized, vec2(0.5));
    float a = step(dist, 0.5);
    
    // Only calculate colors if inside circle
    if (a > 0.0) {
        float n = cellular(pixelized - vec2(iTime*0.1, 0), 10.0);
        n *= cellular(pixelized - vec2(iTime*0.05, 0), 20.0);
        n = clamp(n * 2.0, 0.0, 1.0);
        
        vec4 col = mix(mix(darkColor, midColor, n*2.0), 
                   mix(lightColor, lightestColor, (n-0.5)*2.0), 
                   step(0.5, n));
        
        fragColor = vec4(col.rgb, col.a); // Use original color alpha
    } else {
        fragColor = vec4(0.0); // Fully transparent outside
    }
}