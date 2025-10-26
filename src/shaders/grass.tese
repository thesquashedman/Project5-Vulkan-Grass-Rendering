#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 inV0[];
layout(location = 1) in vec4 inV1[];
layout(location = 2) in vec4 inV2[];
layout(location = 3) in vec4 inUp[];

layout(location = 0) out vec4 outNormal;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    vec3 v0 = inV0[gl_InvocationID].xyz;
    vec3 v1 = inV1[gl_InvocationID].xyz;
    vec3 v2 = inV2[gl_InvocationID].xyz;
    vec3 up = inUp[gl_InvocationID].xyz;

    float orientation = inV0[gl_InvocationID].w;
    float height = inV1[gl_InvocationID].w;
    float width = = inV2[gl_InvocationID].w;
    float stiffness = = inUp[gl_InvocationID].w;

    
    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    //Point along bezier curve
    vec3 c = a + v * (b - a);
    
    //Tangent
    vec3 t0 = normalize(b - a);
    //Bitangent
    //For now, just assume up is always (0, 1, 0)
    vec3 t1 = vec3(cos(orientation), 0, sin(orientation));
    c0 = c - width * t1;
    c1 = c + width * t1;

    outNormal = normalize(cross(t0, t1));

    //Square shape

    vec3 interpoPos = (1 - u) * c0 + u * c1;

    gl_Position = proj * view * interpoPos; 


	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
}
