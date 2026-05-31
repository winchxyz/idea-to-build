# Contributing to idea-to-build

Thanks for considering a contribution. This project gets better with every domain-specific profile, every refined sub-agent prompt, and every real-world brainstorm transcript shared as an example.

## What We Welcome

### 🆕 New Profiles
The biggest impact contribution. Profiles specialize the core methodology for a specific domain — legal strategy, healthcare product, education startup, climate venture, real estate, B2B sales, academic research, etc.

A new profile lives in `profiles/<name>.md` and follows the structure of existing profiles. See [`docs/PROFILES.md`](docs/PROFILES.md) for the authoring guide.

### 🛠️ Sub-Agent Prompt Improvements
The agents in `core/agents/` are the engine (research, ideation, deep-dive, critic, planner, and the post-Phase-6 scaffolder). If you find a way to make the Critic more adversarial, the Researcher more rigorous, or the Planner more concrete — open a PR.

When changing a sub-agent prompt, include in the PR:
- What problem the change solves
- One example before-state and after-state output
- Any token-cost implications

### 📖 Real-World Examples
The `examples/` folder holds anonymized transcripts of real brainstorming sessions. These help new users see what good output looks like and help us identify edge cases.

To contribute an example:
1. Anonymize all sensitive details
2. Save as `examples/<short-slug>.md`
3. Include a brief intro explaining the problem and the outcome

### 🌍 Translations
The methodology is language-agnostic; the prompts are currently English. Translations of the coordinator, sub-agents, and profiles into other languages are welcome.

Track each translation in a subfolder: `core/CLAUDE.<lang>.md`, etc.

### 🐛 Bug Reports
If a sub-agent misbehaves, ignores its instructions, or produces low-quality output — open an issue with:
- The input that triggered the failure
- The actual output
- What you expected instead
- The LLM client + version used

### 🚀 Distribution Channels
We currently support GitHub template repo, Cowork plugin, Claude Code plugin, and standalone prompts. Adding new channels (MCP server, Cursor rules, ChatGPT Custom GPT, etc.) is welcome.

## Development Workflow

1. Fork the repo
2. Create a branch: `git checkout -b feature/your-change`
3. Make changes — keep them focused (one profile, one sub-agent, one fix)
4. Test by running a brainstorm session through the modified flow
5. Open a PR with a clear description of what changed and why

## PR Review Criteria

We evaluate PRs on:
- **Methodology adherence** — does the change preserve factual rigor, phase isolation, confidence labeling?
- **Token efficiency** — verbose prompts are rejected; tighten before submitting
- **Specificity** — vague additions ("be thorough") are rejected; concrete instructions accepted
- **Anti-pattern resistance** — does the change harden against any LLM failure mode?

## Style Guide

### For prompts (CLAUDE.md, agents, profiles)

- **Direct second-person.** "You do X" not "The agent should do X."
- **Imperative.** "Produce 5 variants" not "Try to produce variants."
- **Numbered required outputs.** Sub-agents must enumerate what they must produce.
- **Explicit anti-patterns.** What NOT to do is as important as what to do.
- **Confidence labels in examples.** Show ✅ / ⚠️ / 🔍 in any sample output.

### For docs (README, ARCHITECTURE, METHODOLOGY)

- **Clear hierarchy.** H2 for sections, H3 for subsections. No deeper.
- **Tables for comparisons.** Side-by-side beats prose.
- **Code blocks for prompts and configs.**
- **No filler.** Cut everything that doesn't add information.

## What We Don't Want

❌ Profiles that essentially duplicate the general profile
❌ Sub-agent prompts that add bureaucracy without adding quality
❌ Distribution channels that increase setup friction
❌ Examples that aren't anonymized
❌ Translations of the README only (the methodology / prompts matter more)
❌ Generic "improvements" without concrete before/after evidence

## Code of Conduct

Be kind. Push back honestly. Don't tolerate sycophancy.

(The same standards the tool applies to brainstorms apply to PR reviews.)

## Getting Help

Open an issue tagged `question`. We'll respond within a few days.

For larger contributions (new profile, new distribution channel), open a Discussion first to align on scope before investing time.

Thanks again. The next great profile or sub-agent improvement might be yours.
