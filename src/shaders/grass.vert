
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
// Position and direction
layout(location = 0) in vec4 v0;
// Bezier point and height
layout(location = 1) in vec4 v1;
// Physical model guide and width
layout(location = 2) in vec4 v2;
// Up vector and stiffness coefficient
layout(location = 3) in vec4 up;


out gl_PerVertex {
    vec4 gl_Position;
};

layout(location = 0) out vec4 outV0;
layout(location = 1) out vec4 outV1;
layout(location = 2) out vec4 outV2;
layout(location = 3) out vec4 outUp;


void main() {
	// TODO: Write gl_Position and any other shader outputs


    outV0 = model * vec4(v0.xyz, 1);
    outV1 = model * vec4(v1.xyz, 1);
    outV2 = model * vec4(v2.xyz, 1);
    outUp = model * vec4(up.xyz, 0);

    //Save the w values
    outV0.w = v0.w;
    outV1.w = v1.w;
    outV2.w = v2.w;
    outUp.w = up.w;


    gl_Position = model * vec4(v0.xyz, 1);


}
