#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float2 position [[attribute(0)]];
    half3 color [[attribute(1)]];
};

struct VertexOut {
    float4 position [[position]];
    half3 color;
};

struct Uniforms {
    float4x4 mvp_matrix;
};

vertex VertexOut vertexShader(uint vid [[vertex_id]],
                              const device VertexIn *vertices [[buffer(0)]],
                              constant Uniforms& uniforms [[buffer(1)]]) {
    VertexOut out;
    VertexIn v = vertices[vid];
    out.position = uniforms.mvp_matrix * float4(v.position, 0.0, 1.0);
    out.color = v.color;
    return out;
}

fragment half4 fragmentShader(VertexOut in [[stage_in]]) {
    return half4(in.color, 1.0);
}
