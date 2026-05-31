# Changelog

All notable changes to `idea-to-build` are tracked here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.2] — 2026-06-01

### Changed
- **Plugin capabilities now ship as real slash commands.** All ten live in `commands/*.md` (flat command files) instead of `skills/`, so they invoke as user-typed `/idea-to-build:start`, `/idea-to-build:critique`, `/idea-to-build:scaffold`, etc. (Cowork / Claude Code register a plugin's `commands/` as slash commands; `skills/` are only model-auto-invoked — which is why the earlier skills-based build showed up in the menu but returned "Unknown command".) **Verified executing in both the Claude Code CLI and Cowork.**
- Slimmed the plugin manifest to the minimal shape Cowork expects (`name`, `version`, `description`, `author`, `keywords`) and removed the duplicate top-level `agents/` directory — the commands dispatch the six sub-agents via the bundled `core/agents/` specs.

### Added
- **Manual-upload install path for Cowork.** `idea-to-build-plugin.zip` is attached to the GitHub release; the README documents installing it via **Create plugin → Upload plugin** (it lands under *My Uploads*) as a fallback for a known Cowork marketplace-update bug (greyed-out *Update* button / stale cache, Anthropic issues #54276 / #40600). The zip is built with forward-slash entries so Cowork reads its structure correctly.

## [0.2.0] — 2026-05-31

### Added
- **Installable plugin (Claude Code + Cowork).** New `distributions/claude-code-plugin/` packages the whole methodology as a Claude Code plugin: `.claude-plugin/plugin.json`, the 6 sub-agents (`agents/*.md` with frontmatter), all command skills, and a self-contained copy of `core/`, `profiles/`, and `docs/` so the skills resolve their references via `${CLAUDE_PLUGIN_ROOT}`.
- **Marketplace manifest** at the repo root (`.claude-plugin/marketplace.json`) so the plugin installs with `/plugin marketplace add winchxyz/idea-to-build` → `/plugin install idea-to-build@idea-to-build` in Claude Code, and via **Customize → Add marketplace → `winchxyz/idea-to-build`** in Cowork.
- **`/start` activation command** (`/idea-to-build:start`). Plugins don't auto-load a `CLAUDE.md`, so this switches the coordinator role on. On a cloned repo the root `CLAUDE.md` still bootstraps automatically, so `/start` is optional there.

### Changed
- **README Quick Start** reworked: the marketplace plugin is now the recommended install (Claude Code + Cowork), with clone-the-repo and the standalone prompt as the other two paths. Removed the "on roadmap" placeholders for the plugins.
- **`lite.md`** aligned to the idea→build framing and now names the `/scaffold` build handoff as a concrete reason to upgrade from the lite fallback (which legitimately stops at the plan).
- Resolves the v0.2 plugin/distribution roadmap (issues #1, #2, #4).

## [0.1.7] — 2026-05-31

### Changed
- **Refreshed the Windows 98 brand.** New social card (`assets/logo.png`): the old feature line and button row are replaced by the `idea → brainstorm → critique → 📁 build` arc plus the tagline *"Build the thing you can't stop thinking about."*; the MIT chip was dropped. The README demo video is re-cut to match — the full idea→build arc in the retro UI, with the prompt, the isolated critic's `context = chosen idea + scope only`, and `/scaffold` all typed live, an isolated `Critic.exe — clean context` window returning 🟡 GO-with-conditions, and the run ending on the scaffolded `medieval-village-tycoon\` folder. Visual only — no methodology change.

## [0.1.6] — 2026-05-31

### Changed
- **Renamed `idea-to-brainstorm` → `idea-to-build`** and repositioned the whole project around the full arc: a raw idea → an honest 6-phase brainstorm → a critiqued, scoped plan → a `/scaffold` build handoff. NO-GO is one honest outcome, not the headline; the constructive idea→build path is.
- **Windows 98 visual identity** — new README banner / social card and a new demo video, all in a cohesive retro-UI style.
- **Documentation aligned to idea→build:** the scaffolder / Phase-6 → build handoff is now surfaced across README (How It Works diagram, Why This table, a new "ends in a build" principle), `core/CLAUDE.md`, `docs/ARCHITECTURE.md`, `docs/PHASES.md`, `docs/FAQ.md`, `docs/METHODOLOGY.md`, and `CONTRIBUTING.md`. "See It in Action" reordered strongest-first, led by the full idea→build run. Fixed a stale "five sub-agents" count (there are six agents: research, ideation, deep-dive, critic, planner, scaffolder).

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
