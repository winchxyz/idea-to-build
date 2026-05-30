---
name: critique
description: Force-dispatch the idea-to-brainstorm Critic (Phase 5) on the currently chosen idea. Use when the user types "/critique" or asks to run the critique, stress-test, or premortem the chosen idea now.
---

# /critique — dispatch the isolated Critic (Phase 5)

Force-run Phase 5 on the idea the user has committed to.

1. Read `core/CLAUDE.md` (stay in the coordinator role) and its §3 Sub-Agent Dispatch.
2. Launch a **genuinely isolated sub-agent** using your environment's sub-agent launch tool — the **`Task`** tool in Claude Code / the **`Agent`** tool in Cowork. Do **not** use the to-do tools (`TaskCreate`/`TaskUpdate`); they don't isolate. The critic must run cold.
3. Feed it the contents of `core/agents/critic.md` as its instructions, plus only `{chosen_idea, scope, constraints}`. Do **not** pass the rationale for the choice or the rejected alternatives.
4. If there's no chosen idea/scope yet, ask the user for the idea, scope, and constraints first.
5. Relay the critic's output verbatim (premortem + what-needs-to-be-true + steelman + verdict). Don't soften it — that's the point of running it isolated.
