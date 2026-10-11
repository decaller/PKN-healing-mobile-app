# PKN v3 — Earth-Tree

Standalone Flutter web learning app. `prototype/v1` is unchanged. The original light/dark home mockups and Earth-Tree specification remain in `design/`.

## Run

Requires Flutter (SDK constraint Dart 3.7+) and network access for initial package installation.

```sh
cd prototype/v3
flutter pub get
./run_web.sh
```

Default address: `http://localhost:3003/`. Override with `PORT=3004 HOST=127.0.0.1 ./run_web.sh`. The script uses Flutter from PATH, falling back to `/home/abuhafi/flutter/bin`. Stop with Ctrl+C. This is the app itself, without an emulator, frame, or preview toolbar.

## App behavior

Fresh starts open the home screen. Profile → **Pilih peran & fokus belajar** opens the existing onboarding flow; onboarding is optional rather than a gate. The bottom navigation opens home, the existing module catalog, and profile/settings. Lessons retain the existing interactive cards, completion persistence, and adab report flow. Search filters actual local material titles, summaries, and tags. Category shortcuts filter the recommendation library. Reading cards opens full existing material, including source details and bookmark controls. Sharing copies the actual summary and source, not a fictitious link.

Profile → **Tampilan** selects system, light, or dark mode and persists the choice in this browser. System is the default. Earth-Tree supplies Material and Forui colors and typography; real Forui buttons power the home learning action and profile actions. Existing adaptive primitives use Cupertino navigation, sheets, inputs, buttons, and feedback on iOS/macOS; other platforms use Material. No artificial platform selector is included.

## Design mapping

The home preserves mockup section order: greeting/search, horizontal Highlights, activity cards, feature bento, serial carousel with working pagination, practical tools, recommendations, and fixed bottom navigation. Wide screens use a bounded content column and additional bento space; narrow screens keep horizontal card rails and three-column tools. Icons/tonal surfaces replace unbundled mockup photographs rather than relying on ephemeral image URLs.

| Mockup concept | Implemented capability |
| --- | --- |
| AI sanctuary / curhat / walkie-talkie | **Teman belajar keluarga** and **Bahasa Hati** open the existing connection-before-correction lesson. Copy explicitly says this is not a chatbot. |
| Event / webinar highlights and reservations | Actual local PKN library highlights, opening full reading cards; no booking claim. |
| Activity progress | Actual completed module count and bookmark count; no invented percentage or streak. |
| Serial RPG | Existing interactive lesson sequence, with lesson titles and actual steps; no invented episodes. |
| Calculators, voice detection, talent analysis | Shortcuts to actual learning categories, lessons, saved material, and focus selection; no diagnostic/scoring tools. |
| Agenda bottom item | Existing module catalog rather than an empty event destination. |
| Notification/avatar | Saved material and genuine profile; no fictitious unread badge or identity. |

Earth-Tree frontmatter tokens are authoritative, including dark themes inherited from v1; inconsistent inline mockup gray overrides are not copied. Merriweather headings and Plus Jakarta Sans body text use the existing Google Fonts integration. Fonts are not bundled and may need network access on first load; platform fallback is available.

## Smoke entry routes

Flutter's default hash routing is used:

- `http://localhost:3003/` — fresh home.
- `http://localhost:3003/#/feed` — home/search/library.
- `http://localhost:3003/#/lessons` — module catalog.
- `http://localhost:3003/#/lessons/lesson_koneksi_koreksi` — interactive lesson and completion/report flow.
- `http://localhost:3003/#/profile` — saved material, settings, onboarding entry.
- `http://localhost:3003/#/onboarding` — role/focus selection.
- `http://localhost:3003/#/activational-insight` — existing onboarding insight.

## Limitations and verification

Content comes from the existing example repositories/assets, not a new content backend. Stored choices, bookmarks, and completions are local to the browser origin; clearing site data removes them. There is no login, cloud sync, audio playback, AI, microphone capture, clinical service, reservations, or guarantee of privacy/security. The previously simulated audio player and child-mode/streak display are removed. Educational material is reused, not a new clinical or religious validation.

Existing controller/package tests were copied with the app. Added v3 tests cover the fresh home route and theme setting persistence. Implementation did not run builds, analysis, tests, or formatters; run `flutter analyze`, `flutter test`, and web smoke checks before release. Check light/dark, a narrow viewport, wide layout, keyboard navigation, text scaling, search, bookmark persistence, carousel navigation, onboarding, and lesson completion.
