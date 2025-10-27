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

layout(location = 0) out vec3 outNormal;
layout(location = 1) out vec2 outUV;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    vec3 v0 = inV0[0].xyz;
    vec3 v1 = inV1[0].xyz;
    vec3 v2 = inV2[0].xyz;
    vec3 up = inUp[0].xyz;

    float orientation = inV0[0].w;
    float height = inV1[0].w;
    float width = inV2[0].w;
    float stiffness = inUp[0].w;

    
    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    //Point along bezier curve
    vec3 c = a + v * (b - a);
    
    //Tangent
    vec3 t0 = normalize(b - a);
    //Bitangent
    //For now, just assume up is always (0, 1, 0)
    vec3 t1 = vec3(cos(orientation), 0, sin(orientation));
    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;

    outNormal = normalize(cross(t0, t1));
    outUV = vec2(u, v);
    //Square shape

    //vec3 interpoPos = (1 - u) * c0 + u * c1;

    //TriangleTip

    float t = 0.5 + (u - 0.5) * (1 - max(v - 0.25, 0)/ (1 - 0.25));
    vec3 interpoPos = (1 - t) * c0 + t * c1;


    gl_Position = camera.proj * camera.view * vec4(interpoPos, 1); 


	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
}
