<div align="center">

<img src="assets/logo.png" alt="idea-to-brainstorm — multi-agent brainstorming methodology" width="800"/>

# idea-to-brainstorm

**A multi-agent brainstorming methodology for founders, builders, and creators.**

Turn any raw idea into a battle-tested strategy in 30 minutes — powered by Claude sub-agents that argue with you, fact-check you, and don't let you skip the hard parts.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude](https://img.shields.io/badge/Powered%20by-Claude-D97757)](https://claude.com)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Status](https://img.shields.io/badge/status-v0.1.2-orange.svg)](CHANGELOG.md)

[Quick Start](#-quick-start) • [How It Works](#-how-it-works) • [Profiles](#-profiles) • [Why This](#-why-this-vs-alternatives) • [Contribute](CONTRIBUTING.md)

</div>

---

## The Problem

LLMs are great at telling you why your idea is brilliant. They're terrible at telling you why it will fail.

Ask any LLM — Claude, ChatGPT, Gemini, Grok — to brainstorm and you get the same failure modes:
- ❌ Same-side agreement (no real pushback)
- ❌ Fabricated market sizes and made-up statistics
- ❌ Generic SWOT lists that fit any business
- ❌ "5 great ideas!" — none of which are actually different
- ❌ No memory across sessions — you re-explain context every time

This tool fixes those failures. The **full multi-agent version runs on Claude** (Cowork or Claude Code) — that's where sub-agent isolation lives. A **degraded-but-functional standalone prompt** in `distributions/standalone-prompts/lite.md` works in any other LLM.

## The Solution

**A structured 6-phase brainstorming flow with dedicated sub-agents.** Each phase has a specialist that doesn't see what the others did — so the critic actually criticizes, the researcher actually researches, and the planner actually plans.

It's the same way professional strategy teams work: separate people for ideation, critique, and execution. We just made each "person" a specialized Claude agent.

> "It found a flaw in my pivot that I'd been missing for three weeks." — early tester

---

## 🚀 Quick Start

Two install paths ship today. Two more are on the roadmap.

### ✅ Option 1: GitHub template / Cowork folder (available now)
```bash
git clone https://github.com/winchxyz/idea-to-brainstorm.git
```
Open the cloned folder in Cowork (or Claude Code). The root [`CLAUDE.md`](CLAUDE.md) activates the coordinator and sub-agents automatically — it bootstraps the full specification in `core/CLAUDE.md`.

### ✅ Option 2: Standalone prompt — any LLM (available now)
Copy [`distributions/standalone-prompts/lite.md`](distributions/standalone-prompts/lite.md) into ChatGPT, Claude, Gemini, or any chat. Degraded quality (no sub-agent isolation, no cross-session memory), but zero setup.

### 🚧 Option 3: Cowork plugin (.plugin) — on roadmap
A drag-and-drop `.plugin` installer is planned for v0.2. Track [issue #1](https://github.com/winchxyz/idea-to-brainstorm/issues/1) for status.

### 🚧 Option 4: Claude Code plugin — on roadmap
Marketplace registration and `claude plugin install` support are planned for v0.2. Track [issue #2](https://github.com/winchxyz/idea-to-brainstorm/issues/2) for status.

---

## 🧩 How It Works

A coordinator agent guides you through six phases. For the two most-skipped phases (critique and planning), it spawns dedicated sub-agents with **isolated context** — so they can't drink the Kool-Aid.

```
┌────────────────────────────────────────────────────────────────┐
│                    Coordinator (you talk to)                   │
│                                                                │
│  Phase 1 ─ Understanding   "What are you actually trying to    │
│                             accomplish?"                       │
│  Phase 2 ─ Context         🔍 Research Agent (optional)        │
│  Phase 3 ─ Generation      💡 Ideation Agent (optional)        │
│  Phase 4 ─ Deep Dive       🔬 Deep-Dive Agent (optional)       │
│  Phase 5 ─ Critique        ⚔️  Critic Sub-Agent  ◄── isolated │
│                             Sees: final choice only            │
│                             Forced: premortem + steelman       │
│  Phase 6 ─ Plan            📋 Planner Sub-Agent  ◄── isolated │
│                             Sees: choice + critique            │
│                             Forced: actionable steps + gates   │
└────────────────────────────────────────────────────────────────┘
```

**Why isolation matters:** A critic that has seen 30 messages of you defending an idea is biased toward letting you keep it. A critic that sees only "the user chose X, premortem it" has no such bias. This is the single biggest quality lever.

---

## 📚 Profiles

idea-to-brainstorm ships with **6 modes**: one general-purpose base plus five domain specializations.

| Profile | When to use | Key tools |
|---------|-------------|-----------|
| 🎯 [General](profiles/general.md) | Any idea, any domain | Full 6-phase framework |
| 🚀 [Startup](profiles/startup.md) | Founder ideating a product/business | Unit economics, GTM, JTBD, Beachhead |
| ⚙️ [Tech Architecture](profiles/tech-architecture.md) | System design, stack choices | Trade-off matrices, RFC structure |
| 🎬 [Content Strategy](profiles/content-strategy.md) | Channel, niche, monetization | Audience-fit, virality patterns, RPM |
| 🗺️ [Product Roadmap](profiles/product-roadmap.md) | Feature prioritization, GTM | ICE/RICE, Kano, North Star Metric |
| 🧭 [Personal Decisions](profiles/personal-decisions.md) | Career moves, life transitions | Reversibility, Expected Value, Inversion |

Profiles override defaults inside each phase. Switch with `/profile startup`.

---

## 🆚 Why This vs Alternatives

| | Raw ChatGPT/Claude | Awesome-prompts repo | LangChain/CrewAI build | **idea-to-brainstorm** |
|---|---|---|---|---|
| Setup time | 0 sec | 30 sec | 30+ min | ✅ 60 sec |
| Forced critique | ❌ | ⚠️ Often skipped | ✅ if coded | ✅ Hard-gated |
| Fact-checking discipline | ❌ Hallucinates | ❌ No enforcement | ⚠️ DIY | ✅ Tier 1/2/3 protocol |
| Cross-session memory | ❌ | ❌ | ✅ if coded | ✅ Context files |
| Phase isolation | ❌ Single context bleed | ❌ | ✅ if multi-agent | ✅ Sub-agents native |
| Domain profiles | ❌ One-size | ❌ | ⚠️ DIY | ✅ 6 ready |
| Cost per brainstorm | Free–$1 | Free | $$ (LLM API) | Free (your Claude subscription) |

---

## 🎯 Core Principles

1. **Skeptical by default.** Every claim — yours, the user's, the source's — is a hypothesis to be tested. Accuracy over confidence, clarity over speed, evidence over assumption. When uncertain, the tool tells you exactly what would verify the claim.
2. **Phase-explicit communication.** Coordinator announces the current phase in every message. No silent transitions.
3. **Factual rigor (Tier 1/2/3).** Made-up numbers are a sin. Each material claim gets a ✅ / ⚠️ / 🔍 confidence label.
4. **Calibrated recommendations.** Every recommendation includes a confidence percentage, what would raise/lower it, and an alternative if confidence drops. No false certainty.
5. **Forced critique.** Phase 5 cannot be skipped. Premortem + What-Needs-to-Be-True are mandatory.
6. **Sub-agent isolation.** Critic and Planner agents work in fresh context. They cannot inherit your biases.
7. **Memory as a log, not state.** Decisions and rejected options are appended, never overwritten. History matters.

Full methodology: [`docs/METHODOLOGY.md`](docs/METHODOLOGY.md)

---

## 🏗️ Architecture

```
idea-to-brainstorm/
├── CLAUDE.md                 # Entry point — auto-activates the coordinator
├── core/
│   ├── CLAUDE.md             # Full coordinator specification
│   ├── agents/               # 5 specialized sub-agents
│   ├── skills/               # Recommendation + confidence module
│   └── templates/            # Project context file template
├── profiles/                 # 6 domain profiles (general + 5 specialized)
├── distributions/
│   └── standalone-prompts/   # Lite version for any LLM
├── docs/
│   ├── ARCHITECTURE.md       # How sub-agents are orchestrated
│   ├── METHODOLOGY.md        # Core principles in depth
│   ├── PHASES.md             # 6 phases explained
│   └── PROFILES.md           # Profile authoring guide
└── examples/                 # Template, guide + real comparison transcripts
```

> Roadmap directories not shipped in v0.1.0: `distributions/cowork-plugin/`, `distributions/claude-code-plugin/`. The `examples/` directory ships with a template, an authoring guide, and four real comparison transcripts — each the same prompt run as plain Claude vs. through the methodology: a stickman game, a personal-health-AI startup, a Hyperliquid wallet (full methodology through Phase 5 critique), and an AI support agent (the "can it say no?" test, where the methodology recommends *not* building). A broader library lands in v0.2. See [`CHANGELOG.md`](CHANGELOG.md).

Full architecture: [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)

---

## 🤝 Contributing

We welcome:
- 🆕 New profiles for specific domains (legal, healthcare, education, climate, etc.)
- 🛠️ Improvements to sub-agent prompts
- 📖 Real-world brainstorm transcripts for `examples/`
- 🌍 Translations (currently English-first; methodology language-agnostic)
- 🐛 Bug reports and edge cases

See [`CONTRIBUTING.md`](CONTRIBUTING.md).

---

## 📜 License

MIT — see [`LICENSE`](LICENSE). Use it, fork it, ship it commercially. Just don't sue us if your brainstorm convinces you to do something dumb.

---

## ⭐ Star History

If `idea-to-brainstorm` helped you avoid a bad decision (or commit to a good one), a star makes our day.

[![Star History Chart](https://api.star-history.com/svg?repos=winchxyz/idea-to-brainstorm&type=Date)](https://star-history.com/#winchxyz/idea-to-brainstorm&Date)

---

<div align="center">
Built with 🧠 by people who got tired of LLMs agreeing with them.
</div>
