---
name: memory
description: Show what idea-to-build has recorded in the current project's context file. Use when the user types "/memory" or asks what's saved / remembered about the project.
---

# /memory — show project memory

1. Read `core/CLAUDE.md` (the memory model: an append-only log, not state).
2. Read `context/INDEX.md` and the current project's `context/<slug>.md`.
3. Summarize what's recorded: the locked problem statement, key decisions (with dates), open hypotheses, and rejected variants.
4. If no context file exists for the current project yet, say so plainly — don't invent history.
