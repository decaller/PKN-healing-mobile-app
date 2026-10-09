# Architectural & UX Report: Building an App-Oriented Narrative Game with Flutter and Flutter Scene

## 1. Executive Summary
Traditional narrative games (such as those by Telltale Games) rely on full-screen 3D engines, continuous camera motion, and immersive environment exploration. However, when targeting mobile users who prefer lightweight, session-friendly experiences, a full 3D game engine can feel heavy, battery-intensive, and out of place. 

This report outlines an architectural and UX framework for creating a narrative game that functions structurally like a production-grade mobile application (e.g., an investigative workspace, secure dossier reader, or encrypted communication hub) while leveraging `flutter_scene` (`fscene.dev`) for embedded, high-fidelity 3D assets.

---

## 2. Core Architectural Blueprint: The UI-First Shell
To make the application feel like a native mobile tool rather than a game engine sandbox, the traditional rendering pipeline must be inverted.

### Layout Strategy
* **The Split Viewport:** Allocate 30% to 40% of the screen height to a bounded container hosting the `SceneView`. The remaining 60% to 70% is dedicated to standard native mobile layout structures (`Scaffold`, `CustomScrollView`, `DraggableScrollableSheet`) utilizing crisp typography, data cards, and action sheets.
* **State Decoupling:** Narrative progression should be treated as a reactive state management problem (using frameworks like Riverpod or Bloc). Dialogue branches, player inventories, dynamic flags, and trust meters update locally in the UI store, instantly driving visual state changes while dispatching precise camera or material triggers to the scene controller.

---

## 3. UI/UX Paradigms for Non-Game Feel
To disarm the user's expectation of a traditional game and foster an immersive "role-playing utility" experience, adopt established enterprise or communication UI patterns:

### Paradigm A: The Investigator’s Dossier / Secure Terminal
* **Aesthetic & Layout:** Dark-mode dashboard, monospaced metadata labels, status badges, and expandable accordion cards.
* **Scene Integration:** The top viewport (`SceneView`) functions as a "surveillance feed" or an examination space where players rotate a single piece of 3D evidence. Narrative choices appear below as secure action buttons, multi-choice audit logs, or prompt inputs.

### Paradigm B: The Encrypted Chat / Context Feed
* **Aesthetic & Layout:** Modeled precisely after high-end messaging interfaces (e.g., Signal or Telegram) or modern email clients (e.g., Notion).
* **Scene Integration Characters message the player asynchronously. Choices manifest as quick-reply chips. When major narrative confrontations occur, the chat interface smoothly minimizes to reveal a split pane displaying a 3D video feed or spatial context.

---

## 4. Technical Constraints & Configuration for `flutter_scene`
Embedding `flutter_scene` into an app-like wrapper requires strict constraints to preserve the native utility aesthetic:

* **Constrained Cameras:** Avoid free-roaming or user-controlled orbital cameras except when specifically inspecting items. Utilize fixed perspectives or orthographic framing focused tightly on clean, singular assets.
* **Lighting and Material Discipline:** Employ neutral, cinematic Image-Based Lighting (IBL) rather than saturated game shaders. Match background clear colors precisely with the mobile app's theme palette (e.g., deep slate or pure dark mode hex codes) so the scene blends seamlessly into the widget tree.
* **Component-Level Embedding:** Wrap the render view inside rounded, clipped containers:
  ```dart
  SizedBox(
    height: 240,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SceneView(
        scene: narrativeScene,
        cameraBuilder: (elapsed) => PerspectiveCamera.framing(...),
      ),
    ),
  )
  ```

---

## 5. Narrative Flow as App Workflows
Instead of continuous, real-time loops, narrative pacing should follow a turn-based, event-driven workflow:
1. **User Action:** The player selects a choice from a native list view or taps an action button.
2. **State Mutation:** Application logic updates global states (e.g., `trustScore = 75`, `hasKeycard = true`).
3. **Declarative Transition:** The Flutter widget tree re-renders to display the subsequent text block or data log, while the `Scene` controller cross-fades materials, alters lighting, or triggers micro-animations (e.g., locking a file or rendering a hologram).

---

## 6. Conclusion
By decoupling the UI shell from the rendering viewport, developers can build narrative games that consume fewer system resources, fit naturally into mobile usage patterns, and offer a unique, premium aesthetic. Utilizing Flutter alongside `flutter_scene` provides the ideal bridge between crisp native mobile design and interactive 3D storytelling.