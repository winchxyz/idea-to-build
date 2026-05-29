# Architecture

This document explains how `idea-to-brainstorm` is built and why.

## Design Goal

**Maximize the quality of a brainstorming session while minimizing setup friction.**

The single biggest quality lever in any structured brainstorm is **process isolation** — different perspectives on the same problem, operating without contaminating each other. We achieve this with native Claude sub-agents.

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│   Coordinator Agent  (the one the user converses with)          │
│   ─────────────────                                             │
│   • Manages the 6-phase flow                                    │
│   • Reads and writes the project context file                   │
│   • Enforces phase-explicit communication                       │
│   • Dispatches sub-agents at critical phases                    │
│   • Aggregates sub-agent outputs back to the user               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
                              │
              dispatches via Task tool (sub-agent)
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
   ┌────▼─────┐         ┌─────▼─────┐         ┌─────▼─────┐
   │ Research │         │  Critic   │         │  Planner  │
   │  Agent   │         │   Agent   │         │   Agent   │
   │ (Phase 2)│         │ (Phase 5) │         │ (Phase 6) │
   └──────────┘         └───────────┘         └───────────┘
                              ▲                     ▲
                              │                     │
                         FRESH CONTEXT       FRESH CONTEXT
                         (cannot inherit coordinator state)
```

Sub-agents for Phases 2 (Research), 3 (Ideation), and 4 (Deep Dive) are **optional** — invoked when the user wants stronger isolation or when the coordinator is at risk of context bleed.

## Why Sub-Agents for Phases 5 and 6 Specifically

These two phases benefit most from isolation:

**Phase 5 (Critique):**
A critic that watched the user spend 30 messages defending an idea is biased toward letting them keep it. A critic that sees only "user chose X, premortem it" has no such bias. The result: real criticism, not theater.

**Phase 6 (Plan):**
A planner that has seen the ideation debate may inherit unresolved tensions and produce a plan that hedges. A planner that sees only "X was chosen, here are the critic's risks" produces a tighter, more committed plan.

For Phases 1–4, continuity matters more than isolation. The coordinator holds context naturally and saves on token cost.

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
- **Task** (sub-agent dispatch) — for Phase 5 and Phase 6 isolation

If a target environment lacks any of these, the relevant capability degrades gracefully:
- No web search → Tier 3 claims are flagged 🔍 instead of researched
- No Task tool → all phases run in single-agent mode (degraded critique quality)

## Trade-Offs We Accepted

1. **Token cost.** Sub-agent dispatch consumes more tokens than single-agent. We accept this because critique quality is the primary value.
2. **Slower critique phase.** Sub-agent invocation adds 30–60 seconds. Acceptable for the depth gain.
3. **Per-platform install glue.** Multiple distribution paths require maintenance. We accept this because friction is the #1 adoption killer.

## Non-Goals

- We do not orchestrate external APIs (no LangChain-style chains).
- We do not embed retrieval / RAG (the context file is the memory).
- We do not run the brainstorm autonomously — the user is always in the loop.
- We do not generate slides, docs, or deliverables — that's the user's job after Phase 6.

## Future Architecture Considerations

**MCP server distribution (planned).** Repackage the coordinator + sub-agents as an MCP server so the tool works in Cursor, Claude Desktop, and other MCP-compatible clients without Cowork or Claude Code.

**Memory consolidation skill.** A periodic agent that re-reads project context files and surfaces stale facts, duplicate decisions, or unresolved hypotheses.

**Profile authoring tooling.** A scaffolding command that helps contributors generate new domain profiles from a template.
