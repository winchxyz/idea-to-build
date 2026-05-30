---
name: reset
description: Start a fresh idea-to-build project — a new context file and cleared focus. Use when the user types "/reset" or asks to start over / begin a new brainstorm.
---

# /reset — start a new project

1. Read `core/CLAUDE.md` (the memory model: append-only log, one file per project).
2. Confirm the user wants to start a **new** project — don't abandon the current one silently.
3. Create a new `context/<slug>.md` from `core/templates/project-context.md` for the new idea, add a line to `context/INDEX.md`, then begin **Phase 1 — Understanding**.
4. **Never** overwrite or delete existing context files — memory is a log, history is kept.
