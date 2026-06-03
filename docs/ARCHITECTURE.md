# Architecture

This document explains how `idea-to-build` is built and why.

## Design Goal

**Take a raw idea to a plan you can build — maximize the quality of the brainstorm in between, with minimal setup friction.**

The single biggest quality lever in any structured brainstorm is **a forced adversarial critique you can't skip** — a hard-gated Phase 5 that runs a fixed rubric (premortem, what-needs-to-be-true, steelman, inversion, verdict) against the idea you're attached to, and that separates the *thesis* from the *parameters* so you don't later optimize a premise that was never true. It runs *in-context*: full knowledge of the brainstorm lets it find sharper, more specific cracks than a cold outsider could. The one phase that genuinely benefits from a fresh context — the planner — is dispatched as a native Claude sub-agent. The arc doesn't stop at a plan: a final scaffolder turns the brainstorm into a folder Claude Code can build from, and `/recheck` re-critiques the project once real results are in — so the discipline reaches past the plan into the build.

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│   Coordinator Agent  (the one the user converses with)          │
│   ─────────────────                                             │
│   • Manages the 6-phase flow                                    │
│   • Reads and writes the project context file                   │
│   • Enforces phase-explicit communication                       │
│   • Runs the Phase 5 critique itself, in-context (adversarial)  │
│   • Dispatches the planner sub-agent at Phase 6                  │
│   • Aggregates the sub-agent output back to the user            │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┴─────────────────────┐
        │                                           │
  in-context (no sub-agent)              real sub-agent (Agent in
        │                                Cowork / Task in Claude Code)
   ┌────▼──────┐         ┌──────────┐         ┌─────▼─────┐
   │  Critic   │         │ Research │         │  Planner  │
   │ (Phase 5) │         │  Agent   │         │   Agent   │
   │ adversarial│        │ (Phase 2)│         │ (Phase 6) │
   └───────────┘         └────▲─────┘         └─────▲─────┘
        ▲                     │                     │
        │                FRESH CONTEXT (optional) FRESH CONTEXT
   FULL CONTEXT          (cannot inherit coordinator state)
   (sharper cracks)
```

Sub-agents for Phases 2 (Research), 3 (Ideation), and 4 (Deep Dive) are **optional** — invoked when the user wants stronger isolation or when the coordinator is at risk of context bleed.

## Why Phase 5 Runs In-Context and Phase 6 Runs Isolated

**Phase 5 (Critique) — in-context:**
The instinct is to isolate the critic so it can't "drink the Kool-Aid." We A/B-tested that. With a forced adversarial rubric, a critic that has the *full* brainstorm was as sharp or sharper than a cold one — it catches idea-specific cracks the outsider misses. The bias risk (a critic that watched you defend the idea wants to let you keep it) is handled not by amnesia but by an explicit instruction to override the sunk cost and your enthusiasm. The lever is the forced structure, not the isolation.

**Phase 6 (Plan) — isolated:**
A planner that has seen the ideation debate may inherit unresolved tensions and produce a plan that hedges. A planner that sees only "X was chosen, here are the critic's risks" produces a tighter, more committed plan. This one genuinely benefits from a fresh context, so it's dispatched as a sub-agent.

For Phases 1–4, continuity matters more than isolation. The coordinator holds context naturally and saves on token cost.

## The Scaffolder — the opposite design choice (after Phase 6)

The critic runs under a forced adversarial rubric and the planner is isolated *because* judgment must be unbiased. The **scaffolder** is the inverse, on purpose: it runs with the **full** project context. Its job is to *transform* a finished brainstorm into a buildable handoff — `CLAUDE.md`, `README.md`, `DECISIONS.md`, `PLAN.md` — so it needs everything the brainstorm decided, including the rejected paths and the risks to carry forward. Isolation would cripple it. It's gated to require a completed Phase 6, and it produces the briefing, **not** application code — you open the folder in Claude Code and build from there. This is the "to-build" half of idea-to-build.

## Memory Model

The persistent memory layer lives in plain markdown files:

```
context/
├── INDEX.md                  # Active projects, one-line status each
└── <project-slug>.md         # Per-project state, decisions, hypotheses
```

The context file is structured as an **append-only log**, not a state document:

- New decisions get a new dated entry
- Rejected variants stay in their section forever
- The "Last updated" header is the only mutable field

This pattern preserves history. A user returning in 3 months can see *why* they made each call, not just the current snapshot.

## Why Append-Only?

In real strategic work, the *rationale* behind a decision is more valuable than the decision itself. A reader 6 months later needs to know:
- What was considered
- Why this was chosen
- What was rejected and why

Mutable state loses this. Append-only logs preserve it.

## Profile Layer

Profiles override the coordinator's defaults inside each phase. They live in `profiles/<name>.md` and are activated by the user with `/profile <name>`.

A profile may:
- Add domain-specific frameworks (e.g., LTV/CAC for startup, RFC structure for tech-architecture)
- Specialize search terms for Phase 2
- Adjust the Critic's premortem questions
- Customize the Planner's deliverable format

Profiles **do not replace** the core methodology. They specialize it.

## Distribution Channels

The same core methodology ships through multiple installation paths to minimize friction for different user types:

| Channel | Target user | Setup time |
|---------|-------------|-----------|
| Cowork plugin (.plugin) | Non-developer / general user | < 60 sec |
| Claude Code plugin | Developer / CLI user | < 60 sec |
| GitHub template repo | Customizer / forker | < 5 min |
| Standalone prompts | Any LLM user (degraded quality) | < 30 sec |
| MCP server (planned) | Power user (Cursor, Claude Desktop) | < 5 min |

All channels share the same `core/` and `profiles/` directories. Each distribution wraps them with platform-specific install glue.

## Tool Dependencies

The coordinator and sub-agents assume access to:

- **Read / Write / Edit** — for context file management
- **Web Search** — for Tier 3 factual rigor
- **Sub-agent launch** — for the Phase 6 planner (and optional Phase 2–4 isolation). This is the **`Agent`** tool in Cowork and the **`Task`** tool in Claude Code. ⚠️ It is *not* the `TaskCreate`/`TaskUpdate`/`TaskList` to-do tools, which only track a checklist and provide no context isolation. The Phase 5 critique does **not** need this — it runs in-context.

If a target environment lacks any of these, the relevant capability degrades gracefully:
- No web search → Tier 3 claims are flagged 🔍 instead of researched
- No sub-agent launch tool → the Phase 6 plan runs in-context too (the critique is unaffected — it was already in-context)

## Trade-Offs We Accepted

1. **Token cost.** The Phase 6 planner sub-agent consumes more tokens than single-agent. We accept this because the build handoff is the primary value.
2. **Slower plan phase.** The planner sub-agent invocation adds 30–60 seconds. Acceptable for the tighter, less-hedged plan. (The Phase 5 critique runs in-context, so it adds no dispatch latency.)
3. **Per-platform install glue.** Multiple distribution paths require maintenance. We accept this because friction is the #1 adoption killer.

## Non-Goals

- We do not orchestrate external APIs (no LangChain-style chains).
- We do not embed retrieval / RAG (the context file is the memory).
- We do not run the brainstorm autonomously — the user is always in the loop.
- We do not write application code — after Phase 6, `/scaffold` produces the build *briefing* (`CLAUDE.md`, `README`, `DECISIONS`, `PLAN`); Claude Code writes the code.

## Future Architecture Considerations

**MCP server distribution (planned).** Repackage the coordinator + sub-agents as an MCP server so the tool works in Cursor, Claude Desktop, and other MCP-compatible clients without Cowork or Claude Code.

**Memory consolidation skill.** A periodic agent that re-reads project context files and surfaces stale facts, duplicate decisions, or unresolved hypotheses.

**Profile authoring tooling.** A scaffolding command that helps contributors generate new domain profiles from a template.
