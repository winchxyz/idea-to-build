---
description: Re-critique a project after the build, with real execution results — does the data disconfirm the THESIS or just the tuning? Use when the user types "/recheck" (often with results/data pasted) or asks to re-examine a project in light of how it's actually going.
---

# /recheck — re-critique with execution results (Phase 5, re-critique mode)

The user built (or started building) a project from an earlier idea-to-build brainstorm and now has **real results**. They want the critic to re-examine it in light of that data — not to tune parameters, but to question whether the core thesis still holds. This is the loop that catches calibration-myopia *while it's happening*, which a one-time pre-build critique cannot.

## Steps

1. **Read `${CLAUDE_PLUGIN_ROOT}/core/CLAUDE.md`** (coordinator role) and **`${CLAUDE_PLUGIN_ROOT}/core/agents/critic.md`** — especially its "Re-critique mode (invoked with results)" section.
2. **Load the project's memory:** read `context/<slug>.md` for the chosen idea, its **core thesis**, the original critique, and the **rejected alternatives**. If it's unclear which project this is, ask.
3. **The results are whatever the user provided** after `/recheck` (as a slash command, `$ARGUMENTS`) — pasted data, metrics, or a description of how it's going. If none is given, ask what actually happened.
4. **Become the critic yourself, in-context** (do **not** spawn a sub-agent, do **not** soften), and run **re-critique mode** under one overriding question — *does the data disconfirm the THESIS, or only the TUNING?*:
   - Default to suspecting the **thesis**, not the knobs. Make the user prove the premise is still alive before touching a parameter.
   - **Outcome vs. proxy:** are the numbers (good or bad) the real outcome or a proxy that can move while the real thing doesn't?
   - **Build fidelity:** does what was built still implement the chosen thesis, or did it drift into a generic version that was never the plan?
   - **Small-N as an excuse:** "not enough data to conclude" is fair for the *parameters*, but must not defer the *structural* question (is the thesis even coherent / tested correctly?).
   - **Verdict:** 🟢 keep (thesis holding) / 🟡 pivot the thesis (premise looks wrong — change approach, don't tune) / 🔴 kill (thesis disconfirmed).
5. If the verdict is **pivot or kill**, point back to the **rejected alternatives** in the context file as the place to look — don't let the user tunnel a dead approach.
6. **Append the re-critique and verdict to `context/<slug>.md`** (dated, in English), so the project's log carries it.

## Rules

- This is a judgment step, **in-context**, exactly like Phase 5 — the same critic, a new occasion. Don't tune parameters for the user; make them prove the thesis is still alive first.
- Chat in the user's language; write the context-file entry in English (§6).
- If there is no prior brainstorm/context for the project, say so and offer to run a fresh critique instead.
