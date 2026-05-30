# Changelog

All notable changes to `idea-to-brainstorm` are tracked here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.5] — 2026-05-31

### Added
- **Scaffolder + `/scaffold` command.** After Phase 6, generate a ready-to-build project folder from the brainstorm's context file: `CLAUDE.md` (chosen approach, rejected variants, risks to watch, go/no-go gates), `README.md`, `DECISIONS.md`, `PLAN.md`. Produces the *briefing*, not application code — you open the folder in Claude Code and it builds. Spec in `core/agents/scaffolder.md`; gated to require a completed Phase 6. Verified end to end.
- **Seventh example:** `examples/medieval-tycoon-fullrun.md` — the whole method start to finish (Phase 1 → 6 → `/scaffold`) on a real idea that survives: scoped, critiqued (GO with conditions), planned with a kill-switch, handed off as a buildable folder. The constructive counterpart to the "can it say no?" examples.

## [0.1.4] — 2026-05-31

### Added
- Real slash commands for Claude Code / Claude CLI, shipped as skills in `.claude/skills/`: `/profile`, `/critique`, `/plan`, `/recommend`, `/memory`, `/reset`, `/phase`, `/factcheck`. (Cowork reserves `/` for installed plugins, so there these are invoked in plain language until the v0.2 plugin. The claim-verifier is named `/factcheck`, not `/verify`, to avoid colliding with a built-in Claude Code skill.)
- Sixth example transcript: `examples/profiles-comparison.md` — the same idea run through all six profiles, showing each reframes the goal and asks different questions (proof that profiles change behavior, not just labels).

## [0.1.3] — 2026-05-30

### Added
- Fifth example transcript: `examples/food-delivery-comparison.md` (food delivery — the fullest "can it say no?" arc, and the first example with **trace-verified** sub-agent isolation after the dispatch fix: the cold critic returns NO-GO on the head-on idea, then GO-with-conditions on the pivot).

### Changed
- Re-recorded `examples/hyperliquid-wallet-comparison.md` from a **trace-verified isolated run** (Phase 5 shows `ran an agent`). The earlier version documented a run whose dispatch had used the to-do tool rather than a real sub-agent, so its "isolated critique" claim wasn't accurate; the new run genuinely isolates and returns NO-GO.

### Fixed
- **Sub-agent dispatch now targets the real agent-launch tool.** The protocol said "the Task tool," which in Cowork collides with the `TaskCreate`/`TaskUpdate` *to-do* tools — so the coordinator created a checklist item and wrote the critique itself in-context, instead of spawning an isolated critic. Phases 5/6 were running with no real context isolation (the core value prop). `core/CLAUDE.md` §3, the root `CLAUDE.md`, and `docs/ARCHITECTURE.md` now name the correct tool per host (`Agent` in Cowork, `Task` in Claude Code), explicitly forbid the to-do tools, and require a verification step that a separate agent actually ran.

## [0.1.2] — 2026-05-30

### Added
- Second example transcript: `examples/health-system-comparison.md` (personal health AI — plain Claude vs. methodology; a case where the plain build was already competent and the methodology added strategic depth).
- Third example transcript: `examples/hyperliquid-wallet-comparison.md` (Hyperliquid crypto wallet — the fullest example, running the methodology through Phase 5 isolated critique; the security/regulatory showcase).
- Fourth example transcript: `examples/ai-support-agent-comparison.md` (AI support agent — the "can it say no?" test, where the methodology pushes back and recommends not building, rather than cheerleading).

## [0.1.1] — 2026-05-29

### Fixed
- Root `CLAUDE.md` now auto-activates the coordinator on clone-and-open. Previously the spec lived only in `core/CLAUDE.md`, which is not auto-loaded when the repo root is opened in Cowork/Claude Code — users got a generic assistant instead of the methodology.

### Added
- First real example transcript: `examples/stickman-comparison.md` (same prompt run as plain Claude vs. the methodology).

## [0.1.0] — 2026-05-29

### Added
- Core coordinator (`core/CLAUDE.md`)
- 5 sub-agents: Research, Ideation, Deep-Dive, Critic, Planner
- 6 profiles: General, Startup, Tech Architecture, Content Strategy, Product Roadmap, Personal Decisions
- Methodology documentation: ARCHITECTURE, PHASES, METHODOLOGY
- Standalone-prompt distribution (lite, single-prompt version for any LLM)
- Project context file template
- `examples/`: transcript template, authoring guide, and a first real comparison transcript (stickman — plain Claude vs. methodology)
- CONTRIBUTING guide
- MIT License

### Methodology highlights in this release
- Three-tier factual rigor protocol (Tier 1/2/3 search policy)
- Mandatory ✅/⚠️/🔍 confidence labels on material claims
- Sub-agent isolation for Phase 5 (Critique) and Phase 6 (Plan)
- Append-only project memory model
- Cross-project context isolation rule

### Known limitations
- Cowork plugin (`distributions/cowork-plugin/`) and Claude Code plugin (`distributions/claude-code-plugin/`) installers planned for v0.2
- `examples/` has one real comparison transcript so far; a broader library of brainstorm transcripts is planned for v0.2
- MCP server distribution planned for v0.3
- Skills directory currently contains only `recommendation-confidence.md`; additional skills (premortem helpers, phase advancement) planned for v0.2
- No automated tests for sub-agent output quality
- Profiles are English-first; translations welcome

---

## Versioning policy

- **Major** (1.x.x → 2.0.0): breaking changes to core methodology or sub-agent contracts
- **Minor** (x.1.x → x.2.0): new profiles, new sub-agents, new distribution channels
- **Patch** (x.x.1 → x.x.2): prompt refinements, doc fixes, anti-pattern additions

## Template update protocol

When the core methodology changes:

1. **Do not** silently edit `core/CLAUDE.md` or sub-agent prompts
2. Add a CHANGELOG entry describing what changed and why
3. Bump the version in the relevant files
4. Document migration path for users on older versions
5. Test against 2–3 example brainstorms before release
