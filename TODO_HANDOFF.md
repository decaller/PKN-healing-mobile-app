# PKN Healing Mobile App — Project Roadmap, SuperPlane Setup & Handoff Document

> **Status:** Architecture Scaffolding & Automation Setup Complete  
> **Last Updated:** October 2026  
> **Target Platform:** Flutter (iOS & Android)  

---

## 1. Project Overview

**PKN Healing Mobile App** is an executive microlearning and knowledge curation mobile app built in Flutter. It synthesizes four proven interaction paradigms:

1. **Deepstash Model:** Card-based knowledge curation, vertical infinite discovery feed, bookmarking, and markdown-rendered core theses.
2. **Empirio Model:** Professional & executive domain focus (Strategy, Finance, Product, Marketing, Leadership, Self-Mastery).
3. **Google Primer Model:** Interactive snackable 5-minute decks with dynamic cards (text insight, swipe poll, multiple-choice quiz, fill-in-the-blank) and segmented progress tracking.
4. **Mobbin / Moonly Model:** Multi-step Jobs-To-Be-Done (JTBD) diagnostic questionnaire delivering an Activational Insight Card before reaching the main experience.

---

## 2. Infrastructure & SuperPlane Setup

### A. SuperPlane Automation Control Plane
SuperPlane is deployed locally on Docker to orchestrate AI tasks, automate lesson content generation, and supervise code quality.

| Item | Details |
| :--- | :--- |
| **Instance URL** | `http://100.118.34.69:8095` |
| **Organization** | `Local` (`138b4a85-4714-404a-a520-a4eb47c6c777`) |
| **Owner Account** | `Harridi Tovid` (`harridiilmantovid@gmail.com`) |
| **Active App Name** | `pkn-healing-app` |
| **Active App ID** | `a51414a1-fbcf-4946-8a05-b98eff0fa61e` |
| **App Web UI** | `http://100.118.34.69:8095/138b4a85-4714-404a-a520-a4eb47c6c777/apps/a51414a1-fbcf-4946-8a05-b98eff0fa61e` |
| **CLI Status** | Installed at `~/.local/bin/superplane` (`v0.30.0`), authenticated and bound to `pkn-healing-app`. |

### B. Environment & Credentials
- **Local credentials file:** `~/.superplane.yaml` contains active context and token.
- **Git credentials:** GitHub PAT configured in `~/.git-credentials` for user `@decaller`.
- **Canvas specification:** Stored locally in `superplane/canvas.yaml`.

---

## 3. How SuperPlane Interacts with this Project

SuperPlane functions as an **external AI DevOps engine and content pipeline**:

```
┌─────────────────────────────────────────────────────────────┐
│                     SuperPlane Control Plane                │
│                                                             │
│   [Schedule Trigger] ──> [AI Agent: Claude/OpenAI]          │
│                                   │                         │
│                                   ▼                         │
│                        [Generate Lesson JSON]               │
│                                   │                         │
│                                   ▼                         │
│                        [GitHub: Open Pull Request]          │
└───────────────────────────────────┬─────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────┐
│                 PKN Flutter Repository                      │
│                                                             │
│   assets/data/lessons/ ──> Decoupled JSON Lesson Decks      │
│   lib/features/lessons/ ──> Player renders new decks         │
└─────────────────────────────────────────────────────────────┘
```

1. **AI Lesson Content Generation:** Generates valid lesson JSON files matching `assets/data/lessons/` schema and commits them to Git.
2. **Autonomous Pull Requests:** When features or bug fixes are specified, SuperPlane AI agents can branch, edit, and open review-ready PRs.
3. **CI/CD & Monitoring:** Runs health checks and notifies developers on build failures or errors.

---

## 4. Prioritized Implementation Roadmap (TODO List)

### Phase 1: Local Tooling & State Machine Verification
- [ ] **Task 1.1:** Run `flutter pub get` and verify dependency tree consistency.
- [ ] **Task 1.2:** Audit Riverpod state providers in `lib/core/` and `lib/features/`.
- [ ] **Task 1.3:** Validate JSON deserialization contracts for polymorphic lesson cards in `lib/core/network/` or `lib/features/lessons/models/`.
- [ ] **Task 1.4:** Create unit tests for `LessonPlayerNotifier` (tracking step index, answers, and deck completion).

### Phase 2: Design Tokens & Theme Foundation
- [ ] **Task 2.1:** Verify `lib/app/theme/` tokens (executive dark/light palette, serif/sans typography contrast).
- [ ] **Task 2.2:** Build reusable `SegmentedProgressBar` supporting animated width interpolations.
- [ ] **Task 2.3:** Implement tactile feedback utility (`HapticFeedback` wrappers for card swipes and quiz responses).

### Phase 3: Onboarding & JTBD Diagnostic Flow
- [ ] **Task 3.1:** Implement step-by-step diagnostic questionnaire in `lib/features/onboarding/`.
- [ ] **Task 3.2:** Build algorithm computing user executive archetype from questionnaire responses.
- [ ] **Task 3.3:** Design the **Activational Insight Card** displayed upon completing the diagnostic.
- [ ] **Task 3.4:** Persist onboarding completion status to `SharedPreferences` to route returning users directly to the feed.

### Phase 4: Google Primer-Style Lesson Player
- [ ] **Task 4.1:** Build polymorphic step renderer supporting:
  - `TextInsightCard`: Highlighted quotes, markdown body, takeaway pill.
  - `SwipePollCard`: Binary or ternary opinion poll with instant aggregate feedback.
  - `MultipleChoiceQuizCard`: Interactive selection with animated explanation reveal upon answering.
  - `SummaryCard`: Key takeaways with quick bookmark and share actions.
- [ ] **Task 4.2:** Integrate deck transition animations (smooth horizontal swipe and spring physics).
- [ ] **Task 4.3:** Connect deck completion events to user profile streak counters.

### Phase 5: Deepstash-Style Discovery Feed
- [ ] **Task 5.1:** Build vertical infinite feed showing idea cards and daily briefs.
- [ ] **Task 5.2:** Implement domain category chips (Finance, Strategy, Leadership, Product).
- [ ] **Task 5.3:** Wire `BookmarksNotifier` to allow saving idea cards offline.
- [ ] **Task 5.4:** Implement search and keyword filtering.

### Phase 6: SuperPlane Automation Pipeline Wiring
- [ ] **Task 6.1:** Connect GitHub repository (`decaller/PKN-healing-mobile-app`) to SuperPlane.
- [ ] **Task 6.2:** Configure LLM credentials (Anthropic Claude / OpenAI) in SuperPlane Secrets.
- [ ] **Task 6.3:** Deploy automated daily lesson generator canvas in SuperPlane.
- [ ] **Task 6.4:** Configure PR verification webhook to run automated Flutter analyzer checks.

---

## 5. Developer Quick Reference & Commands

### Flutter Commands
```bash
# Install dependencies
flutter pub get

# Run static analyzer
flutter analyze

# Run unit and widget tests
flutter test

# Run app locally (Chrome / Android / Linux)
flutter run -d chrome
```

### SuperPlane CLI Commands
```bash
# Check CLI authentication & active app
superplane whoami
superplane apps active

# List available apps
superplane apps list

# Inspect current app canvas
superplane apps canvas get a51414a1-fbcf-4946-8a05-b98eff0fa61e

# Discover integration capabilities
superplane index actions --from github
superplane index actions --from claude
```

### Direct REST API Testing
```bash
# Test API connectivity
curl -H "Authorization: Bearer <SUPERPLANE_TOKEN>" \
     http://100.118.34.69:8095/api/v1/me

# List canvases
curl -H "Authorization: Bearer <SUPERPLANE_TOKEN>" \
     http://100.118.34.69:8095/api/v1/canvases
```
