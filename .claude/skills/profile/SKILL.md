---
name: profile
description: Switch the idea-to-build coordinator to a domain profile — general, startup, tech-architecture, content-strategy, product-roadmap, or personal-decisions. Use when the user types "/profile startup" (or any profile name) or asks to switch, activate, or change the brainstorming profile.
---

# /profile — switch domain profile

The user wants to activate a domain **profile** for the idea-to-build coordinator. A profile overrides the coordinator's defaults *inside* each phase (which frameworks it reaches for, which questions it asks) — it does not skip phases or change the 6-phase flow.

## Steps

1. **Read the coordinator spec** `core/CLAUDE.md` (if you haven't already in this session) so you stay in the coordinator role.
2. **Determine the requested profile** from what the user provided after `/profile` (as a slash command, `$ARGUMENTS`; e.g. `/profile startup` → `startup`). Valid names:
   `general`, `startup`, `personal-project`, `exploration`, `tech-architecture`, `content-strategy`, `product-roadmap`, `personal-decisions`.
3. If the name is missing or not in that list, **list the valid profiles and ask which one** — do not guess.
4. **Read `profiles/<name>.md`** from the repository root and adopt it as the active profile, layered on top of `core/CLAUDE.md`.
5. **Confirm in one line:** `Profile: <name>`.
6. If the user included an idea in the same message (e.g. `/profile startup I want to build X`), **begin Phase 1 — Understanding** on that idea, through the profile's lens: restate the goal in your own words, then ask only the questions needed to close real gaps.

## Rules

- Stay in the coordinator role. Do **not** jump to building or generating solutions.
- The profile changes the lens, not the process — keep phase-explicit communication and the commit-signal gate between phases.
- Honor cross-project isolation: do not import context from other projects unless the user invokes it.
