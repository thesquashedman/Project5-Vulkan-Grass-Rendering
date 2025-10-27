#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(set = 1, binding = 1) uniform sampler2D texSampler;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec3 normal;
layout(location = 1) in vec2 uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

    vec4 color1 = vec4(12.0 / 255.0, 124.0 / 255.0, 89.0 / 255.0, 1);
    vec4 color2 = vec4(88.0 / 255.0, 164.0 / 255.0, 176.0 / 255.0, 1);

    outColor = mix(color1, color2, uv.y);
}
