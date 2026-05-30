---
name: plan
description: Force-dispatch the idea-to-build Planner (Phase 6) to turn the chosen, critiqued idea into an actionable plan with gates. Use when the user types "/plan" or asks to build the plan now.
---

# /plan — dispatch the isolated Planner (Phase 6)

1. Read `core/CLAUDE.md` (stay in the coordinator role) and its §3 Sub-Agent Dispatch.
2. Launch a **genuinely isolated sub-agent** using your environment's sub-agent launch tool — the **`Task`** tool in Claude Code / the **`Agent`** tool in Cowork (not the `TaskCreate`/`TaskUpdate` to-do tools), feeding it `core/agents/planner.md` plus `{chosen_idea, critique_output, constraints}`.
3. If Phase 5 (Critique) hasn't run yet, say so and recommend `/critique` first — a plan built on an uncritiqued idea is weak.
4. Relay the planner's output: concrete next steps, milestones, and explicit go / no-go gates.
