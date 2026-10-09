# Flutter Scene & Narrative Game Architecture Guide

A complete technical synthesis covering 3D asset pipelines, Flutter GPU integration, cinematic narrative design (Telltale-style), and modular Flutter software architecture.

---

## 1. Engine Fundamentals: Flutter Scene (`flutter_scene`)

**Flutter Scene** is a 3D engine built directly on **Flutter GPU** and the **Impeller** rendering backend. 

### Key Characteristics
* **First-Class Widget Integration:** Unlike external engine embeddings (Unity as a library, Godot, or native OpenGL/Vulkan views over platform channels), Flutter Scene renders natively inside Flutter's widget pipeline using `SceneView`.
* **Zero Overhead Outside 3D:** On-demand instantiation allows standard 2D routes to run with zero 3D overhead. Impeller operates as standard until a `SceneView` is mounted.
* **Native Asset Format Pipeline:** Source 3D assets are converted into optimized binary representations (`.model`, `.fsceneb`) via build hooks at compilation time.

---

## 2. 3D Asset Pipelines & Pre-Processing

### Supported Asset Formats

| Asset Type | Supported Formats | Engine Role / Purpose |
| :--- | :--- | :--- |
| **3D Models & Rigs** | glTF 2.0 (`.glb`, `.gltf`) | Skeletal meshes, morph targets, animations; compiled to `.model`/`.fsceneb`. |
| **Scene Graphs** | `.fscene` (text), `.fsceneb` (binary) | Scene hierarchies, node structures, and prefabs. |
| **Materials & Shaders**| `.fmat`, GLSL | Custom vertex/fragment shaders and PBR configurations. |
| **Textures** | KTX2 / Basis Universal, PNG, JPG | GPU-compressed texture streaming with mipmaps. |
| **Environment Maps** | `.hdr`, `.exr` | Image-Based Lighting (IBL) and skyboxes. |
| **3D Gaussian Splats** | `.ply`, `.splat` | Photorealistic real-world environment captures. |

---

### Commercial Marketplace Compatibility Reality

Commercial assets from TurboSquid, CGTrader, ArtStation, or Unreal/Unity stores cannot be directly dropped into Flutter Scene without validation:

* **Engine-Specific Shader Graphs:** Shaders created in Unity Shader Graph, Unreal Material Graph, or Blender Cycles/EEVEE procedural nodes do **not** export to glTF. All surface details must be baked into 2D texture maps.
* **Rigs & Constraints:** Complex inverse kinematics (IK), driver constraints, and custom rigging scripts (e.g., Rigify) break on export. All animation curves must be **baked to Forward Kinematics (FK)** bones.
* **Normal Map Format:** OpenGL (Y+) is the glTF standard. Unreal/DirectX assets use inverted green channels (Y-) and will produce inverted lighting unless flipped.

---

### Asset Conversion & Optimization Pipeline

```
[Commercial Asset: .fbx, .blend, .obj]
                 │
                 ▼ (Blender Sanitization)
  1. Ctrl+A -> Apply All Transforms (Pos: 0, Rot: 0, Scale: 1)
  2. Simplify shader to Principled BSDF (Roughness, Metallic, Normal)
  3. Armature -> Bake Action (Visual Keying + Clear Constraints)
  4. Export to .glb (Include Normals, Tangents, Baked Animations)
                 │
                 ▼ (CLI Optimization: gltf-transform)
  npx @gltf-transform/cli optimize input.glb stage1.glb
  npx @gltf-transform/cli etc1s stage1.glb final_optimized.glb
                 │
                 ▼ (Flutter Build Hooks)
  Compiled to .model / .fsceneb during `flutter run` / `flutter build`
```

---

### Performance & Memory Budgets (Mobile Target)

| Metric | Ideal Per-Asset Target | Scene Frame Budget (Total) |
| :--- | :--- | :--- |
| **Disk Size (`.glb`)** | 1 MB – 8 MB | < 25 MB total active assets |
| **Polygons (Triangles)**| 5,000 – 30,000 (Hero)<br>500 – 5,000 (Prop) | 100,000 – 300,000 active triangles |
| **Texture Resolutions** | 1024 × 1024 (Props)<br>2048 × 2048 (Characters) | Max 3–4 active 2K textures |
| **Texture Format** | KTX2 / Basis Universal | Avoid raw uncompressed 4K PNGs (64MB VRAM each) |
| **Draw Calls / Materials** | 1–2 materials per mesh | < 50–100 total draw calls |
| **Bones / Joints** | < 64 bones per skeleton | < 150 active skinned joints |

---

## 3. Screen Design: The Layered Viewport Pattern

Do not build UI inside 3D space. Use Flutter's native 2D widget system layered on top of the 3D viewport using a `Stack`.

```
┌────────────────────────────────────────────────────────┐
│ Stack (Full Screen)                                    │
│  ├── Layer 1: SceneView (flutter_scene)                │
│  │    ├── Animated PerspectiveCamera (Cinematic cuts)  │
│  │    ├── Directional / Ambient Lighting (IBL)         │
│  │    └── Loaded Node (Environment & Characters)       │
│  │                                                     │
│  ├── Layer 2: Visual Conditioning (IgnorePointer)      │
│  │    └── Vignettes, color grading gradients, letterbox │
│  │                                                     │
│  └── Layer 3: Native 2D UI (Interaction Layer)         │
│       ├── Dialogue text & subtitle containers          │
│       ├── Timed decision bars (LinearProgressIndicator)│
│       └── Decision popups ("She will remember that")   │
└────────────────────────────────────────────────────────┘
```

### Resource Lifecycle Management
1. **Lazy Loading:** Load `.glb` assets in `initState()` via `Node.fromHostAsset()` only when the 3D screen is mounted.
2. **Pause Render Loops:** Stop animation controllers driving cameras or rigs when views are obscured or dialog modals are presented.
3. **Explicit Cleanup:** Clear references to `Scene` and `Node` in `dispose()` to allow Dart garbage collection and Flutter GPU memory pools to free Vulkan/Metal buffers.

---

## 4. Telltale-Style Narrative System Architecture

Narrative games require strict decoupling between the **Story Engine** (data), **Camera/Cinematic Director** (presentation), and **UI Overlay** (interaction).

```
┌────────────────────────────────────────────────────────┐
│ Dialogue Script (JSON / Ink Engine)                   │
│ Node: "ep1_choice_01"                                  │
│ Text: "What were you doing at the docks?"              │
│ Camera: "shot_over_shoulder_a"                         │
│ Timer: 7.0 seconds                                     │
│ Choices: ["Telling truth", "Lying", "[Stay Silent]"]   │
└──────────────────────────┬─────────────────────────────┘
                           │
             ┌─────────────┴─────────────┐
             ▼                           ▼
┌───────────────────────────┐ ┌───────────────────────────┐
│ Camera / Scene Director   │ │ UI Overlay                │
│ • Interpolates Camera Pos │ │ • Renders Choice Buttons  │
│ • Triggers Skeletal Clips │ │ • Ticks Countdown Bar     │
│ • Manages Shot Composition│ │ • Triggers "Remembered" UI│
└───────────────────────────┘ └───────────────────────────┘
```

### Camera Presets for Cinematic Cuts
Store camera coordinates as vector offsets and update `camera.position` and `camera.target` during dialogue transitions:
* **Over-the-shoulder (Shot A):** Camera behind Character B, focused on Character A.
* **Reaction Close-up (Shot B):** Direct focal zoom on the listening character's face.
* **Establishing Wide Shot:** Environmental context view when entering a new branch or scene.

---

## 5. Modular Software Architecture: Feature-First

To keep features decoupled, avoid monolithic folder structures (`/screens`, `/widgets`). Organize by **domain capabilities**:

```text
lib/
├── app/
│   ├── app.dart                    # MaterialApp & global themes
│   └── router.dart                 # Declarative GoRouter configuration
│
├── core/                           # Shared infrastructure (No feature logic)
│   ├── engine/                     # Custom 3D math, camera tweens, shaders
│   ├── storage/                    # Save game state, local SQLite/Preferences
│   └── theme/                      # Typography, palette, common styles
│
└── features/
    ├── episode_selector/           # Feature A: 2D Catalog / Chapter select
    │   ├── data/                   # EpisodeManifest DTOs, file loaders
    │   ├── domain/                 # Episode entity, unlock progress logic
    │   └── presentation/           # EpisodeSelectorScreen, ChapterCard
    │
    └── narrative_runtime/          # Feature B: 3D Game Runner
        ├── data/                   # Dialogue script parsers, scene asset paths
        ├── domain/                 # DialogueNode, Choice models, save state
        └── presentation/           # NarrativeRuntimeScreen, SceneView wrapper,
                                    # ChoiceWheelWidget, DecisionTimerBar
```

### Decoupling Rules

1. **No Direct Feature-to-Feature Widget Imports:**
   * `EpisodeSelectorScreen` must **never** import `NarrativeRuntimeScreen`.
   * Navigation is handled strictly via declarative routes:
     ```dart
     // Correct: Decoupled route navigation
     context.go('/play/${episode.id}');
     ```
2. **Domain Layer Independence:**
   * `domain/` contains pure Dart classes. No `package:flutter/material.dart` or UI references.
3. **Downward-Only Dependency Graph:**
   * Features may import from `core/`.
   * `core/` must never import from `features/`.
4. **Folder-Level vs. Monorepo Packages:**
   * Begin with **folder-based packaging** inside `lib/features/`.
   * Migrate to multi-package monorepos (`packages/feature_runtime`) using Melos only when scaling to multiple teams or independent release pipelines.

---

## 6. Implementation Checklist: From Store Asset to Playable Scene

- [ ] **Asset Procurement:** Sourced asset with PBR textures and standard bone hierarchy (preferably `.glb` / `.gltf`).
- [ ] **Blender Sanitization:** Applied all transforms (`Ctrl+A`), converted materials to standard Principled BSDF, baked rigs to FK animations.
- [ ] **glTF Validation:** Checked for zero fatal errors via the official Khronos glTF Validator.
- [ ] **Compression:** Optimized vertices and compressed textures to KTX2 / Basis Universal using `@gltf-transform/cli`.
- [ ] **Budget Verification:** Confirmed model is within target specs (<30k triangles, <8 MB file size, 1–2 materials).
- [ ] **Registration:** Placed file in `assets/models/` and registered under `pubspec.yaml`.
- [ ] **Runtime Encapsulation:** Wrapped inside an on-demand `SceneView` within the `features/narrative_runtime/` module.
- [ ] **Lifecycle Safety:** Handled `initState()` asynchronous loading and `dispose()` scene teardown.