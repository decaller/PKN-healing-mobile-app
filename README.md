# Executive Microlearning Mobile App (Concept & Architectural Blueprint)

> [!NOTE]
> **Status**: Concepting & Architectural Scaffolding Phase
> 
> This repository contains the **architectural blueprint, boilerplate, JSON data schemas, state machine contracts, and component skeletons** for a hybrid executive microlearning app. It is structured specifically for an AI-assisted **"vibecoding"** workflow in Flutter.

---

## 1. Concept Synthesis

This project synthesizes three proven mobile interaction paradigms:
1. **Deepstash Model**: Card-based knowledge curation, vertical infinite discovery feed, bookmarking, and markdown-rendered core theses.
2. **Empirio Model**: Professional & executive domain focus (Strategy, Finance, Product, Marketing, Leadership).
3. **Google Primer Model**: Interactive snackable 5-minute decks with dynamic cards (text insight, swipe poll, multiple-choice quiz, fill-in-the-blank) and segmented progress tracking.
4. **Mobbin / Moonly Model**: Multi-step Jobs-To-Be-Done (JTBD) diagnostic questionnaire delivering an Activational Insight Card before reaching the main experience.

---

## 2. Directory Layout (Feature-First Clean Architecture)

```text
lib/
├── app/                      # Global configurations, theme, routing (GoRouter)
│   ├── app.dart              # Root MaterialApp
│   ├── router/               # Shell navigation & modal routes
│   └── theme/                # Executive dark/light theme tokens & typography
├── core/                     # Shared utilities, local persistence & UI badges
│   ├── network/              # Offline JSON bundle loader
│   ├── storage/              # SharedPreferences storage wrapper
│   └── widgets/              # Reusable badges, segmented progress bar
└── features/
    ├── onboarding/           # JTBD diagnostic flow & personalization
    ├── feed/                 # Deepstash-style idea cards and daily briefs
    ├── lessons/              # Google Primer-style interactive 5-minute decks
    └── profile/              # User progress, streaks, bookmarks
```

---

## 3. Core Architectural Contracts

### A. The Lesson JSON Schema (`assets/data/lessons/`)
Decouples content creation from application code:
- `lessonId`: Unique package identifier
- `category`: Domain tag (`Finance`, `Strategy`, `Product`, etc.)
- `cards`: List of polymorphic steps (`text`, `multiple_choice`, `summary`, etc.)

### B. State Machine Blueprints (Riverpod)
- **`LessonPlayerNotifier`**: Immutable `LessonSessionState` managing `currentIndex`, `userAnswers (stepId -> optionId)`, and `isCompleted`.
- **`BookmarksNotifier`**: Manages `Set<String>` synced with local persistent storage.
- **`OnboardingController`**: Step-by-step diagnostic questionnaire tracking answers and computing executive archetypes.

---

## 4. Vibecoding Roadmap for Execution

When progressing from the concepting phase to implementation:

1. **Phase 1 — Tooling & Compilation**: Ensure Flutter SDK is installed and run `flutter pub get`.
2. **Phase 2 — UI Polishing**: Refine swipe gestures, card transitions, and tactile feedback animations.
3. **Phase 3 — Content Pipeline**: Add real content packages to `assets/data/lessons/` matching the JSON schema.
4. **Phase 4 — Integration**: Wire up backend API or remote CMS endpoints as needed.
