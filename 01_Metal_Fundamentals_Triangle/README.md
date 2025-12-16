# Metal Fundamentals — Rotating Triangle

This module demonstrates the **core fundamentals of Metal rendering** by implementing a rotating triangle using the Metal render pipeline and Metal Shading Language (MSL).

It serves as the **foundational building block** for the broader *Metal Proficiency Lab* repository.

---

## Purpose of This Module

The goal of this module is not visual complexity, but **conceptual correctness**.

It focuses on:
- Understanding how Metal drives the GPU
- Making the CPU → GPU data flow explicit
- Avoiding high-level abstractions that hide Metal internals

This mirrors how Metal is used in real production pipelines.

---

## Concepts Demonstrated

- Metal device and command queue creation
- Command buffers and render command encoders
- Render pipeline state configuration
- Vertex and fragment shaders written in MSL
- Vertex buffers and memory layout
- Passing uniform data from CPU to GPU
- Applying rotation via transformation matrices
- Frame-by-frame rendering using a render loop

---

## Rendering Flow

```
CPU (Swift)
 ├─ Create command buffer
 ├─ Encode render commands
 ├─ Update rotation matrix
 ↓
GPU (Metal)
 ├─ Vertex shader (apply transformation)
 ├─ Rasterization
 ├─ Fragment shader (color output)
 ↓
Drawable (Screen)
```

---

## Project Structure

```
01_Metal_Fundamentals_Triangle/
├── ViewController.swift
├── Shaders.metal
```

---

## Tools & Technologies

- Metal
- Metal Shading Language (MSL)
- Swift
- MTKView
- Xcode

---

See: WHAT_I_LEARNED.md for reflections and conceptual takeaways.


https://github.com/user-attachments/assets/40ff0880-1ae3-44f1-9bfd-236934d85409


