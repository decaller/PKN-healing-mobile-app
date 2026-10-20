# PKN Mobile v2 — Figma (`.fig`) & FigCraft (`.figcraft`) Design System & Full Interactive Prototype

Source Interactive Prototype: `http://100.118.34.69:3018/`
WebDAV Project Path: `webdav://100.118.34.69:3923/home/Project/PKN-healing-mobile-app/designv2/`

## Project Structure

- `pkn-mobile-v2.fig` — Native Figma Kiwi binary file (5 pages, 20 screens, 10 master components, 47 variables across multi-mode `Earth-Tree Theme` & `Layout & Radius Tokens` collections). Compatible with **Figma** and **OpenPencil**.
- `pkn-mobile-v2.figcraft` — Native **FigCraft** project file containing all 5 pages, 20 screens, variables, components, and 85 interactive prototype transitions (`proto.*`).
- `pkn-mobile-v2-commands.jsonl` — Reproducible 1,305-command FigCraft batch scene graph & prototype build specification.
- `pkn-mobile-v2-prototype.html` — Preserved HTML/CSS/JS source of the live interactive prototype (`http://100.118.34.69:3018/`).
- `exports/`
  - `00-cover-architecture.png` — Page 00 preview (1600×960)
  - `01-design-system-tokens.png` — Page 01 preview (1680×1360)
  - `02-component-library.png` — Page 02 preview (1680×620)
  - `03-main-app-screens.png` — Page 03 preview (3370×1410, 7 screens)
  - `04-interactive-modals-flows.png` — Page 04 preview (3370×2320, 13 modal & P3K screens)
  - `pkn-mobile-v2-handoff.pdf` — Multi-page vector PDF handoff document
  - `pkn-mobile-v2-tokens.css` — Exported CSS Custom Properties (`--bg-canvas`, `--brand-pine-600`, etc.)
- `scripts/`
  - `build_all.mjs` — End-to-end generator & renderer script (`node scripts/build_all.mjs`)
  - `design_tokens.mjs` — Earth-Tree palette tokens, variable definitions, and `FigCraftBuilder` DSL
  - `pages_system_and_components.mjs` — Pages 00, 01, and 02 generator
  - `pages_main_screens.mjs` — Page 03 (7 main app screens) generator
  - `pages_modals_and_flows.mjs` — Page 04 (13 modal/triage screens + 85 interactive prototype links) generator
