---
name: critique
description: Run the idea-to-build Critic (Phase 5, in-context) on the currently chosen idea. Use when the user types "/critique" or asks to run the critique, stress-test, or premortem the chosen idea now.
---

# /critique — run the Phase 5 critique now

Force-run Phase 5 on the idea the user has committed to.

1. Read `core/CLAUDE.md` (stay in the coordinator role) and its §3.
2. **Become the critic yourself, in-context** — follow `core/agents/critic.md` to the letter. You have the full brainstorm; use it to find sharper, more specific flaws, but do **not** let the user's enthusiasm or sunk cost soften you. Do **not** spawn a sub-agent for this, and do **not** soften the result on the way out.
3. If there's no chosen idea/scope yet, ask the user for the idea, scope, and constraints first.
4. Produce all four sections — premortem + what-needs-to-be-true + steelman + inversion — and a 🟢 / 🟡 / 🔴 verdict. Deliver it straight: no compliments first, no preamble selling the next phase.
