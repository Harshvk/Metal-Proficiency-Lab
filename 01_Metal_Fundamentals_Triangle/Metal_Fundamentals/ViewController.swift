//
//  ViewController.swift
//  Metal_Fundamentals
//
//  Created by Harsh Vardhan Kushwaha on 16/12/25.
//

import UIKit
import Metal
import MetalKit
import simd

class ViewController: UIViewController, MTKViewDelegate {

    var mtkView: MTKView!
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    var pipelineState: MTLRenderPipelineState!
    var vertexBuffer: MTLBuffer!
    var uniformBuffer: MTLBuffer!
    private var startTime = CACurrentMediaTime()

    struct Uniforms {
        var mvp_matrix: simd_float4x4
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMetal()
        mtkView.delegate = self
        mtkView.preferredFramesPerSecond = 60
    }

    func setupMetal() {
        device = MTLCreateSystemDefaultDevice()
        mtkView = MTKView(frame: view.bounds, device: device)
        mtkView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mtkView.colorPixelFormat = .bgra8Unorm
        mtkView.clearColor = MTLClearColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        view.addSubview(mtkView)

        commandQueue = device.makeCommandQueue()

        guard let library = device.makeDefaultLibrary(),
              let vFunc = library.makeFunction(name: "vertexShader"),
              let fFunc = library.makeFunction(name: "fragmentShader") else {
            fatalError("Failed to load shaders from default library")
        }

        let desc = MTLRenderPipelineDescriptor()
        desc.vertexFunction = vFunc
        desc.fragmentFunction = fFunc
        desc.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat

        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: desc)
        } catch {
            fatalError("Failed to create pipeline state: \(error)")
        }

        struct Vertex { var position: SIMD2<Float>; var color: simd_half3 }
        let vertices: [Vertex] = [
            Vertex(position: SIMD2<Float>( 0.0,  0.6), color: simd_half3(1, 0, 0)),
            Vertex(position: SIMD2<Float>(-0.6, -0.6), color: simd_half3(0, 1, 0)),
            Vertex(position: SIMD2<Float>( 0.6, -0.6), color: simd_half3(0, 0, 1)),
        ]
        vertexBuffer = device.makeBuffer(bytes: vertices,
                                         length: MemoryLayout<Vertex>.stride * vertices.count,
                                         options: [.storageModeShared])
        
        var u = Uniforms(mvp_matrix: matrix_identity_float4x4)
        uniformBuffer = device.makeBuffer(bytes: &u,
                                          length: MemoryLayout<Uniforms>.stride,
                                          options: [.storageModeShared])
    }

    // MTKViewDelegate
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }

    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let descriptor = view.currentRenderPassDescriptor else { return }

        let t = Float(CACurrentMediaTime() - startTime)
        let angle = t * 1.0
        let c = cosf(angle)
        let s = sinf(angle)
        let rotationZ = simd_float4x4(
            SIMD4<Float>( c,  s, 0, 0),
            SIMD4<Float>(-s,  c, 0, 0),
            SIMD4<Float>( 0,  0, 1, 0),
            SIMD4<Float>( 0,  0, 0, 1)
        )
        let aspect = Float(view.drawableSize.width / max(view.drawableSize.height, 1))
        let scale = simd_float4x4(
            SIMD4<Float>(1/aspect, 0, 0, 0),
            SIMD4<Float>(0,        1, 0, 0),
            SIMD4<Float>(0,        0, 1, 0),
            SIMD4<Float>(0,        0, 0, 1)
        )
        let mvp = scale * rotationZ
        let ptr = uniformBuffer.contents().bindMemory(to: Uniforms.self, capacity: 1)
        ptr.pointee.mvp_matrix = mvp

        let commandBuffer = commandQueue.makeCommandBuffer()
        let encoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
        encoder?.setRenderPipelineState(pipelineState)
        encoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        encoder?.setVertexBuffer(uniformBuffer, offset: 0, index: 1)
        encoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
        encoder?.endEncoding()

        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}
