# Changelog

All notable changes to `idea-to-brainstorm` are tracked here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Second example transcript: `examples/health-system-comparison.md` (personal health AI — plain Claude vs. methodology; a case where the plain build was already competent and the methodology added strategic depth).
- Third example transcript: `examples/hyperliquid-wallet-comparison.md` (Hyperliquid crypto wallet — the fullest example, running the methodology through Phase 5 isolated critique; the security/regulatory showcase).

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
