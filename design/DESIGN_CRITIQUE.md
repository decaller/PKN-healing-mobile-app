# PKN Design Critique — Findings

Date: 2026-10-07. Recommendations only; no application changes.

## Overall impression

PKN's strongest design is situational guidance: a calm next action and words a caregiver can use immediately. Its weakest boundary is between a broad educational vision, a simulated browser experience, and the smaller Flutter implementation. Prioritize trust, readable guidance, and task-based navigation before expanding the virtual world.

Concept alternatives and proposed product direction are kept in [IDEA_REFINEMENT.md](IDEA_REFINEMENT.md).

## Evidence and limits

- Read project scope and principles in `README.md:11–12,41–48,99–115`, design contracts in `design/README.md:5–11,38–44,76–102`, and the Flutter crisis implementation in `lib/features/feed/presentation/screens/feed_screen.dart:151–212,219–282`.
- Served the existing `design/prototype.html` locally and opened it in Chromium. Inspected all 12 flow entry screens through their rendered text/accessibility structure at 390×844. Exercised guidance save and bookmark retrieval, home navigation, TB40 choice/next transition, scenario B feedback, and theme switching. Checked the executive screen at 320×700 and institution entry at 768×1024; neither sampled page had horizontal document overflow.
- The loaded prototype contains 104 canonical screen definitions. This is inventory evidence, **not** an audit of all 104 screens or 166 native viewport variants.
- Screenshot capture succeeded, but image inspection was unavailable in this review environment. Layout findings below use measured browser geometry and computed styles, not aesthetic judgments inferred from screenshots.
- `flutter devices` returned `command not found: flutter`. Flutter findings are source-backed, not observed on a device. No production audio, offline, screen-reader, clinical, or assessment validation is claimed. No tests were run for this documentation-only review.
- **Observed** means rendered browser behavior; **source-backed** means repository evidence; **[INFERENCE]** identifies a risk requiring user validation.

## Priority findings

| ID | Severity | Finding and evidence | Recommendation |
|---|---|---|---|
| F1 | High | **Source-backed:** Flutter crisis copy invites a calming embrace and says to hug during anger (`feed_screen.dart:185–187,272–275`). The newer browser K flow instead says not to force an embrace; scenario feedback explicitly rejects forced touch. The prayer tile prohibits hitting before age 10 (`:267–270`), which can be misread as permission after that age. | Reconcile guidance across Flutter, design, and content. Put immediate safety first, make touch conditional on the child's willingness, and avoid age-based wording that implies permission for violence. Require qualified religious and safeguarding review; this report is not a fatwa or clinical judgment. |
| F2 | High | **Observed:** home presents `P1`–`P6` and links such as `T1–T5`, `R1`, `L1–L3`, `B1`, and `A1`. The executive screen links to `D2`. **[INFERENCE]:** internal taxonomy requires users to decode implementation labels before finding help. Sources: rendered H/F; reference replacement in `design/generate-prototype.mjs:58`; persona breadth in `design/README.md:17–34`. | Use task labels such as “Help with a difficult moment,” “Classroom observation,” and “Check the source.” Keep stable keys in engineering metadata and reviewer tools, not primary user navigation. Show only relevant tasks for the active context, with access to the full library. |
| F3 | Moderate | **Observed:** executive body copy is 13px with a 20px line height; the dock education disclaimer is 10px. This is consistent with the current Body token, not an isolated CSS accident (`design/README.md:78–80`). **[INFERENCE]:** small explanatory/safety text increases effort under stress and for low-vision readers. | Test a larger body role, initially 16px-equivalent, with reflow rather than shrinking text. Keep safety boundaries readable. Validate native text scaling at 200% before claiming compliance. |
| F4 | Moderate | **Observed:** the inline `D2` source control on F measured approximately 17×24 CSS px at 390×844. Its accessible name is descriptive, but the visible target is tiny. `generate-prototype.mjs:58` creates code-sized inline controls. This measurement alone does not establish a WCAG failure because spacing exceptions were not evaluated. | Replace with a descriptive source link and generous padded target. Test adjacent target spacing and keyboard focus; distinguish the project 48dp design goal from measured web pixels. |
| F5 | Moderate | **Observed:** the mobile flow selector shrinks to approximately 67px wide at 320×700 alongside Back, theme, and saved-state controls. **Source-backed:** the sidebar containing the full session-only-storage disclosure is hidden below 700px (`generate-prototype.mjs:30,39`); save confirmation still announces session simulation (`:60`). | Keep reviewer flow switching in a collapsible prototype toolbar. Add a concise, persistent mobile demo notice before sensitive writing. Do not ship the reviewer toolbar as production navigation. |
| F6 | Moderate | **Observed:** A1 renders a textual timeline/control description plus a separate demo player. GF_MAP repeats venue names across SVG labels, navigation buttons, and description cards. **[INFERENCE]:** duplicated content weakens hierarchy and lengthens reading before action. | Give each screen one primary representation. Keep an accessible text alternative for the map, but separate it from repeated explanatory cards. For audio, show a real player and transcript entry rather than both an illustrative player and controls. |
| F7 | High release gate | **Source-backed:** the README carries an accessibility WCAG 2.1 AA badge (`README.md:8`), while design documentation does not demonstrate full compliance. Browser geometry checks and named controls do not prove screen-reader or native text-scale support. | Replace compliance language with a target until a documented audit passes. Record per-surface contrast, focus order, target sizes, screen-reader announcements, and large-text results. Do not treat the badge as evidence. |
| F8 | Moderate | **Source-backed:** the prototype begins at persona tasks, uses session-only state, and has simulated audio/download/background controls and illustrative TB40/game data (`design/README.md:60,98–102`; `generate-prototype.mjs:50,65`). **[INFERENCE]:** polished flows can be mistaken for functioning product capabilities. | Maintain an explicit capability matrix: designed, browser simulation, Flutter implemented, device verified. Keep disclosures beside controls that imply storage, assessment, or media playback. |
| F9 | Moderate | **Source-backed:** the fictional avatar simulator represents “Tangki Cinta” and energy as percentages and a named nafs state (`design/generate-prototype.mjs:91–92`). Disclaimers explicitly deny measurement of real children. **[INFERENCE]:** precise percentages can still suggest an emotional/spiritual measurement model. | Prefer contextual support descriptions rather than numeric love or spiritual-state gauges. Test whether users can explain that avatar feedback is authored fiction, not an assessment of a child. Preserve the distinction even if game development continues. |

## Visual hierarchy and reading flow

**Observed on F:** title, persona/pillar metadata, principle, example phrase, boundaries/source, and weekend-dialogue cards precede the bottom save action. The useful phrase is not the first content block. **[INFERENCE]:** in a ten-second situation, “what to say now” should outrank profile taxonomy and longer explanations.

Suggested hierarchy: immediate safety/next action, usable phrase, optional explanation/source, then save. Preserve nuance through progressive disclosure rather than deleting guardrails. Test comprehension and time-to-guidance; do not optimize merely for fewer taps.

**Observed on H:** pillar inventory precedes urgent-help and task cards. The crisis feature is correctly described as assistance, not a seventh pillar. The home should orient around the current need rather than teach the full content map on every visit.

## Consistency and design-system decisions

| Area | Evidence | Decision to propose |
|---|---|---|
| Content safety | Flutter hug wording differs from K and scenario feedback. | One reviewed content source with explicit consent/safety boundaries consumed by every surface. |
| Typography | Current native/browser contract uses Inter Body13/20 and Caption12/18; older design assumptions are explicitly superseded (`design/README.md:80`). | Update the contract and generators together if readability trials favor larger roles; do not patch only generated HTML. |
| Navigation | Main dock: Beranda/Tersimpan/Audio/Profil; game dock: Rumah/Peta/Kabar/Jeda (`generate-prototype.mjs:70`). | Retain distinct task navigation if game remains a separate mode; provide an explicit route back to the main learning context. Do not assume mode-switch comprehension. |
| Source presentation | D2 is an internal key in visible copy, while the generated source card uses a sourced quotation, Arabic language/direction, and external attribution (`:58,62`). | Keep the attribution pattern; replace visible technical keys with plain-language labels. |
| Prototype state | Save is session memory, not application persistence (`:50,60`). | Consistent “demo” language at the point of action; production success states must reflect actual persistence. |

## Accessibility checks

- **Contrast, calculated from loaded tokens:** Light TextSecondary `#475569` on Surface `#FFFFFF` is approximately 7.58:1; white OnPrimary on `#0F766E` is approximately 5.47:1. Dark TextSecondary `#CBD5E1` on `#1E2229` is approximately 10.75:1; `#0F172A` OnPrimary on `#5EEAD4` is approximately 12.07:1. These sampled pairs pass the 4.5:1 normal-text threshold. They do not cover pillar-colored text, states, borders, imagery, or all rendered combinations.
- **Targets:** F's dock save action measured 358×48 CSS px at 390×844, and navigation buttons approximately 89.5×64.5. Inline D2 remains a small target; full target audit remains open.
- **Structure:** browser observation exposes named buttons, selected options, and pressed choice states. Source card sets Arabic `lang` and `dir`. Keyboard focus CSS and reduced-motion handling exist (`generate-prototype.mjs:29,32,62`). Presence is not an assistive-technology pass.
- **Reflow:** no horizontal document overflow in the two sampled narrow/tablet states. Long-text, keyboard-open, 200% text-scale, and all game states were not validated.
- **Next validation:** native TalkBack/VoiceOver, keyboard-only journey completion, large text, error announcements, and consent controls. Report blocked/failed checks separately from passes.

## What works well

1. Situational scripts turn principles into usable words; the F and K entries provide specific actions rather than only an article catalogue.
2. The newer K flow avoids forced hugs and emphasizes safety. Scenario feedback explains consequences without a right/wrong score; the observed B path acknowledges that a boundary can help while listening is still missing.
3. Session, audio, assessment, and avatar disclaimers are explicit in the design documentation and several rendered screens. The B flow says its questions are illustrative, not validated TB40.
4. No streak shaming or comparative leaderboard is part of the stated contract (`README.md:99–107`). Warm return copy and optional real-world actions support that intent.
5. Shared tokens, stable screen keys, source attribution, and explicit Light/Dark design contracts create a maintainable base. The sampled theme toggle changed the browser theme successfully; this is not a full dark-mode audit.

## Recommendation order

### Phase 1 — Trust and task clarity

Resolve F1, make capability boundaries visible (F8), and replace user-facing screen keys (F2). Content/safeguarding changes require domain review and functional integration, not merely a visual adjustment. Release acceptance: the same safe wording reaches every applicable surface, users find a relevant response without decoding taxonomy, and simulation cannot be mistaken for saved records or assessment.

### Phase 2 — Readability and hierarchy

Trial larger body/safety text (F3), improve inline targets (F4), put the immediate action first, and remove duplicated presentation (F6). Acceptance: caregivers can identify a usable phrase in a timed scenario without missing the safety boundary; large text reflows without clipped controls.

### Phase 3 — Verified polish

Separate prototype chrome (F5), complete the actual accessibility audit (F7), and review loading/empty/error states only against functioning Flutter features. Update token/generator sources, regenerate derived artifacts, and verify the affected native and browser surfaces. Do not claim production readiness from prototype completion.
