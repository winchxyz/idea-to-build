---
name: scaffold
description: After a completed idea-to-build (Phase 6 done), generate a ready-to-build project folder — CLAUDE.md + README + DECISIONS + PLAN — so you can open it in Claude Code and start building. Use when the user types "/scaffold" or asks to scaffold / hand the brainstorm off to a build.
---

# /scaffold — hand the brainstorm off to a buildable folder

1. Read `core/CLAUDE.md` and `core/agents/scaffolder.md`, and follow the scaffolder spec.
2. **Gate:** proceed only if **Phase 6 (Plan) is complete**. If Critique or Plan hasn't run, decline and say what's missing (run `/critique`, then `/plan` first).
3. **Source of truth = `context/<slug>.md`.** Distill what's recorded; do not invent decisions. Ask the user for anything missing.
4. Ask for the **target folder path** (default: a subfolder `<slug>/` inside the current workspace — a sibling `../` path is often blocked by the host's write scope) and the **tech stack** (or "let Claude Code decide"), then write the **Tier 1** files — `CLAUDE.md`, `README.md`, `DECISIONS.md`, `PLAN.md` — into it. Produce the briefing, **not** application code. Never overwrite existing files without confirming.
5. List what was created and tell the user to open the new folder in Claude Code to start building.
