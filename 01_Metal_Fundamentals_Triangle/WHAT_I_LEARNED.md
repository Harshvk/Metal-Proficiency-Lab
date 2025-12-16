# What I Learned — Metal Fundamentals (Rotating Triangle)

This reflection documents the key learnings and mental models developed while building the **Metal Fundamentals — Rotating Triangle** module.

---

## 1. Metal Is Explicit by Design

Metal requires explicit control over resources, command encoding, and execution order. Nothing happens implicitly, which makes performance predictable once understood.

---

## 2. Command Buffers Are the Contract with the GPU

A `MTLCommandBuffer` represents a complete unit of work for the GPU. Commands execute only after the buffer is committed, reinforcing CPU–GPU asynchrony.

---

## 3. The Render Pipeline Is Fixed but Configurable

The pipeline follows:
Vertex → Rasterization → Fragment

Behavior is controlled by pipeline state, shaders, and resource bindings. Pipeline state creation is expensive and should be reused.

---

## 4. Shaders Must Be Minimal and Precise

Writing MSL highlighted the importance of:
- Minimal logic
- Deterministic behavior
- Exact data layout matching between Swift and shaders

---

## 5. Intentional CPU → GPU Data Flow

Passing a rotation matrix each frame emphasized buffer choice, update frequency, and memory behavior — concepts that scale to larger workloads.

---

## 6. Animation Is State Updated Over Time

Animation in Metal is simply updating state and re-encoding commands for each frame. There is no implicit animation system.

---

## 7. Small Examples Expose Core Concepts

Keeping the example minimal made Metal’s execution model clearer and revealed the cost of each API call.

---

## Final Takeaway

This module transformed Metal from a black box into a predictable GPU programming model and serves as the foundation for advanced rendering and compute work.
