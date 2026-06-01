---
description: Jump the idea-to-build session to a specific phase (1–6). Use sparingly — when the user types "/phase 4" (any phase 1-6) or explicitly asks to skip to a phase.
---

# /phase — jump to a phase (use sparingly)

1. Read `${CLAUDE_PLUGIN_ROOT}/core/CLAUDE.md` and `${CLAUDE_PLUGIN_ROOT}/docs/PHASES.md`.
2. Parse the target phase number (1–6) from what the user provided after `/phase` (as a slash command, `$ARGUMENTS`; e.g. `/phase 4` → 4). If no number is given, ask which phase.
3. Skipping phases weakens the result — especially skipping **Phase 5 (Critique)**. If the user jumps past Critique toward Plan, flag that once before proceeding.
4. Set the current phase and continue, announcing the phase on the first line of the reply as usual.
