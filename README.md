# Metal Proficiency Lab

This repository is a personal effort to **revisit and strengthen my understanding of Metal** on Apple platforms.

Over time, it’s easy to rely on abstractions and lose touch with what the GPU is actually doing. This repo is my way of slowing down, revisiting Metal from first principles, and rebuilding confidence in the fundamentals with a performance- and production-oriented mindset.

---

## Why Metal

Metal sits at the intersection of performance, correctness, and system-level thinking. I’m revisiting it because it forces you to be explicit—about memory, execution, and data flow—and that discipline carries over to every performance-critical problem, whether it’s rendering, image processing, or ML pipelines.

---

## Structure

Each folder in this repository is a **self-contained module** focused on revisiting a specific Metal concept.

- Each module has its own README
- Examples are intentionally small
- Reflections are documented alongside code

Details live inside the respective sub-repositories.

---

## Progress

### 01 — Metal Fundamentals (Triangle Rendering)
A focused revisit of the Metal render pipeline using a rotating triangle to reinforce:
- Command buffers and encoders
- Shader execution (MSL)
- CPU → GPU data flow

---

## Status

This repository evolves incrementally as concepts are revisited and validated. New sections will be added here as additional modules are completed.
