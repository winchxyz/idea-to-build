# Changelog

All notable changes to `idea-to-build` are tracked here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.5.2] — 2026-06-03

### Added
- **`docs/GUIDE.md`: a step-by-step "re-check a project you built elsewhere."** Beginner-grade walkthrough — copy the project folder (safety), get a brutally-honest structured summary from the AI that built it (ready-to-paste prompt), run `/recheck` on it while telling it to distrust the self-summary (the build AI is biased toward "it's fine"), optionally let it read the real files to catch build-drift, then act on keep/pivot/kill. Bundled into the plugin.

## [0.5.1] — 2026-06-03

### Added
- **`docs/GUIDE.md` — a usage guide** for the situations you actually hit: a new idea end-to-end, re-checking a project you're already building (with real results), planning a change to an existing project, and a profile picker that maps "what you're doing" to the right preset — plus a quick command reference.

### Changed
- **Documentation refresh, brought current to v0.5.0.** The README is re-centered on the core thesis (a quality brainstorm that ends in something you build): How It Works now shows the preset step, the thesis-vs-parameters critique, and the `/recheck` execution loop; the Problem/Solution, profile/command counts, FAQ, ARCHITECTURE, the lite prompt, and the examples index were all updated and de-stale-d. The released plugin now bundles these current docs.

## [0.5.0] — 2026-06-01

### Added
- **`/recheck` — re-critique a built project with real execution results.** The deadliest failures happen during execution, not in the brainstorm: a project quietly optimizes the *parameters* of a *thesis that was never true*, and a one-time pre-build critique can't catch it. `/recheck` re-runs the critic in re-critique mode on the project (from its context file), under one question — is the **thesis** failing or only the **tuning**? It rules out build-drift and proxy metrics, gives the thesis a fair bounded test, diagnoses by signal presence, and returns 🟢 keep / 🟡 pivot the thesis / 🔴 kill — pointing back to the rejected alternatives so you don't tunnel a dead approach. This extends the methodology past the plan into the execution loop.

### Changed
- **The critique now separates the thesis from the parameters.** `core/agents/critic.md` names the core thesis, insists it be validated by a *fair* test (its best plausible configuration, with the bound defined up front) before optimization, and checks the success metric is the real outcome rather than a proxy. It diagnoses thesis-vs-parameter failure by signal presence instead of defaulting either way — avoiding both tuning a dead premise forever and killing a good thesis that was merely under-tuned.
- **The planner tests the premise first — cheap and fair — and prefers parallel experiments when they're cheap and reversible** rather than serially tuning one. `core/agents/planner.md`.
- **The scaffolded `CLAUDE.md` carries the strategic discipline into the build** so the building agent thinks wide instead of tunneling: the core thesis, rejected alternatives kept as fallbacks, the #1 premise-risk, and explicit guardrails (measure the real outcome not a proxy; separate thesis from parameters when results disappoint; check build fidelity; parallel-test cheap reversible options; don't tunnel; come back and `/recheck`). `core/agents/scaffolder.md`.
- **Generation gains a reversibility / parallel-testability lens** (two-way vs one-way doors): when several approaches are cheap and reversible to test, prefer parallel over sequential. `profiles/general.md`, `core/CLAUDE.md` anti-pattern #8.
- Docs updated (`docs/PHASES.md`, `docs/METHODOLOGY.md`); fixed a stale "Critic sub-agent" label in the `core/CLAUDE.md` command list (the critique runs in-context).

## [0.4.0] — 2026-06-01

### Added
- **Preset onboarding at session start.** `/start` (and auto-activation) now establishes *what kind of project this is* before Phase 1 — via a one-question preset (`startup` · `personal-project` · `exploration` · `tech-architecture` · `content-strategy` · `product-roadmap` · `personal-decision`) or by classifying the user's own description and confirming it. The preset sets the lens **and** the flow shape, instead of silently defaulting to a startup/business frame.
- **Flow shape.** A profile can declare how heavy each phase is for its kind of project (`full` / `light` / `skip`, plus whether `/scaffold` applies). Same 6-phase spine, calibrated weights — e.g. `exploration` ends at Critique (no isolated Plan, no scaffold); `personal-project` runs Critique through the personal lens and Plan `light`.
- **Two new profiles** (8 total): `personal-project` (a tool/app/game you build for yourself — success is personal utility, not a market) and `exploration` (thinking a topic through, no build intended).

### Changed
- **The critique calibrates to the project's nature and stakes.** `core/agents/critic.md` now aims its premortem and vocabulary at what the thing actually is: a personal build's failure modes are *abandonment / over-engineering / doesn't save time* — not market, adoption, ROI, or competitors. Fixes the critic defaulting to a business frame for personal projects; the `general` profile is de-business-defaulted to match.

### Fixed
- **Phase changes are now gated in every direction.** The commit-gate (`core/CLAUDE.md` §2, root `CLAUDE.md`, `docs/PHASES.md`) previously guarded only moving *forward* — so the coordinator could re-open an earlier phase (e.g. back to Generation) or push ahead on its own when a within-phase question surfaced new information. Now **any** phase change — forward, backward, or re-opening — requires an explicit signal; a follow-up question or pushback within a phase is not a phase change; and the coordinator must ask-and-wait rather than treat its own question ("this re-opens Phase 3") as consent.

## [0.3.1] — 2026-06-01

### Added
- **Reproducible plugin-command build.** `scripts/build-plugin-commands.sh` regenerates `distributions/claude-code-plugin/commands/*.md` from `.claude/skills/*/SKILL.md` as a pure transform (drop the skill-only `name:` key; rewrite `core/` / `profiles/` / `docs/` paths to `${CLAUDE_PLUGIN_ROOT}/…`; leave working-dir paths like `context/` bare). The skills are now the single source of truth, so the commands can't drift — and `$ARGUMENTS` can't be dropped, because the arg-taking skills (`factcheck` / `phase` / `profile`) now carry a `$ARGUMENTS` reference phrased to read correctly both as an auto-invoked skill and as a slash command.
- `scripts/check-plugin-commands.sh` — structural sanity gate the build runs (also runnable standalone): fails on a leftover `name:`, a missing `description:`, a bare repo path, an arg-command missing `$ARGUMENTS`, or command/skill set drift. Fixes the class of regression where an earlier ad-hoc regen silently stripped `$ARGUMENTS` from `factcheck`/`phase`/`profile`.

### Changed
- The `factcheck` / `phase` / `profile` commands now describe their argument as "whatever the user provided after `/<cmd>` (as a slash command, `$ARGUMENTS`)" — equivalent behavior, but the wording now also reads correctly when the same file runs as an auto-invoked skill.

### Added
- **Language policy: chat in the user's language, write every file in English.** New `core/CLAUDE.md` §6 (plus anti-pattern #7, a memory-write note, a `core/agents/scaffolder.md` rule, and a root-`CLAUDE.md` hard rule): the coordinator mirrors the user's language in conversation, but the context file and all `/scaffold` artifacts (`CLAUDE.md` / `README` / `DECISIONS` / `PLAN`) are always written in English — they're build artifacts Claude Code reads, so English keeps them consistent with code and avoids translation drift. Previously the scaffolder inherited the conversation's language and wrote, e.g., a Russian `PLAN.md`.

### Fixed
- **Stale isolation note in the root `CLAUDE.md`.** The activation safety-net still said "Phases 5 and 6 run in isolated sub-agents"; corrected to "Phase 5 runs in-context, Phase 6 runs isolated" to match the 0.3.0 critique redesign.
- **The v0.3.0 release `.zip` was not actually a zip.** It had been built with `tar -a -c -f …zip`, but the `tar` in the build environment is **GNU tar**, which ignores the `.zip` extension and writes a *tar* archive with a `.zip` name — so Windows reported the download as "invalid" and Cowork couldn't open it. Rebuilt the v0.3.0 asset as a real zip and added `scripts/package-plugin.sh` (Python `zipfile`, forward-slash entries, integrity-checked, with a magic-byte assertion) so this can't recur.

## [0.3.0] — 2026-06-01

### Changed
- **Phase 5 (Critique) now runs in-context, adversarially — no longer an isolated sub-agent.** I A/B-tested an isolated critic against an in-context one running the same forced rubric (premortem, what-needs-to-be-true, steelman, inversion, verdict); the context-aware critic was as sharp or sharper, because full knowledge of the idea finds idea-specific cracks a cold outsider misses. The lever is the **forced structure**, not the isolation. The critic is now instructed to use the full brainstorm but explicitly override the sunk cost and the user's enthusiasm. **Phase 6 (Plan) still runs as a genuinely isolated sub-agent**, where a fresh context measurably helps.
- This also fixes two bugs surfaced by the A/B test: the critique double-dispatching (coordinator §3 + the critique command both firing), and the coordinator re-softening the relayed verdict on the way back to the user.
- **Repositioned away from "isolation" as the headline.** The product is a quality 6-phase brainstorm that ends in something buildable (`/scaffold` → a folder Claude Code builds from) — not a multi-agent isolation demo. Updated `README.md`, `core/agents/critic.md`, `core/CLAUDE.md` §3, and the `docs/` (ARCHITECTURE, METHODOLOGY, FAQ, PHASES) to describe the in-context adversarial critique and the build handoff as the core value. Historical `examples/` traces are left as-is.
- Plugin/marketplace manifests and bundled commands regenerated to match.



### Changed
- **Plugin capabilities now ship as real slash commands.** All ten live in `commands/*.md` (flat command files) instead of `skills/`, so they invoke as user-typed `/idea-to-build:start`, `/idea-to-build:critique`, `/idea-to-build:scaffold`, etc. (Cowork / Claude Code register a plugin's `commands/` as slash commands; `skills/` are only model-auto-invoked — which is why the earlier skills-based build showed up in the menu but returned "Unknown command".) **Verified executing in both the Claude CLI and the Cowork / Claude Code desktop app.**
- Slimmed the plugin manifest to the minimal shape Cowork expects (`name`, `version`, `description`, `author`, `keywords`) and removed the duplicate top-level `agents/` directory — the commands dispatch the six sub-agents via the bundled `core/agents/` specs.

### Added
- **Manual-upload install path for Cowork.** `idea-to-build-plugin.zip` is attached to the GitHub release; the README documents installing it via **Create plugin → Upload plugin** (it lands under *My Uploads*) as a fallback for a known Cowork marketplace-update bug (greyed-out *Update* button / stale cache, Anthropic issues #54276 / #40600). The zip is built with forward-slash entries so Cowork reads its structure correctly.

## [0.2.0] — 2026-05-31

### Added
- **Installable plugin (Claude Code + Cowork).** New `distributions/claude-code-plugin/` packages the whole methodology as a Claude Code plugin: `.claude-plugin/plugin.json`, the 6 sub-agents (`agents/*.md` with frontmatter), all command skills, and a self-contained copy of `core/`, `profiles/`, and `docs/` so the skills resolve their references via `${CLAUDE_PLUGIN_ROOT}`.
- **Marketplace manifest** at the repo root (`.claude-plugin/marketplace.json`) so the plugin installs with `/plugin marketplace add winchxyz/idea-to-build` → `/plugin install idea-to-build@idea-to-build` in the Claude CLI, and via **Customize → Add marketplace → `winchxyz/idea-to-build`** in the Cowork / Claude Code desktop app.
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
