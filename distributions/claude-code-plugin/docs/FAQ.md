# FAQ

Honest answers to the questions people actually ask. If something here is hand-wavy or wrong, open an issue — that's on-brand for this project.

---

### Is this *really* multi-agent, or is it one model role-playing "now I'm the critic"?

Partly multi-agent — by design, not by accident. The **planner** (Phase 6) is dispatched as a separate agent invocation with its own fresh context window via the host's sub-agent tool (the `Agent` tool in Cowork, the `Task` tool in Claude Code). It sees only the chosen idea, the critic's risks, and the constraints — so the plan doesn't hedge against debates it never saw.

The **critique** (Phase 5) deliberately runs *in-context*. I originally isolated it too; then I A/B-tested isolated-vs-in-context with the same adversarial rubric, and the context-aware critic was as sharp or sharper — full knowledge of the idea finds cracks a cold outsider misses. So the value here isn't "more agents," it's the forced structure plus the build handoff.

The **standalone single-prompt version** (`distributions/standalone-prompts/lite.md`) runs entirely in one context — no sub-agent planner, no memory. It's the degraded fallback for non-Claude chats, and it says so.

> Note: when this calls itself "multi-agent," it means the planner runs as a real isolated sub-agent on the same Claude model — not multiple different models. The value is the forced structure and the build handoff, not agent count.

---

### Couldn't a good system prompt get the same pushback inside one context?

This is exactly the question I tested — and it turned out yes, *if* the pushback is forced and structured. I A/B'd an isolated critic against an in-context one running the same adversarial rubric (premortem, what-needs-to-be-true, steelman, inversion, verdict). The in-context critic was as blunt or blunter, because full context lets it find idea-specific cracks. The lever is the forced structure plus an explicit "override the sunk cost and the excitement" instruction — not the fresh context. That's why Phase 5 now runs in-context. (The plan still runs isolated, where a clean context genuinely helps.) If you've got a case where the in-context critique caved, show me — that's a bug, not the design.

---

### Does it actually tell you "no," or just hedge?

It says no. See [AI support agent](../examples/ai-support-agent-comparison.md) (recommends not building), [food delivery](../examples/food-delivery-comparison.md) (NO-GO on the head-on idea), and [Hyperliquid](../examples/hyperliquid-wallet-comparison.md) (NO-GO: you'd be entering behind a funded incumbent). The Phase 5 critique pushes back, respects your override if you insist, and renders a real verdict — it doesn't nag and it doesn't cave.

---

### Why Claude and not [other model]?

Because the sub-agent dispatch (for the planner), the file access, and the cross-session memory are native in Cowork / Claude Code. The single-prompt fallback runs anywhere but loses the memory and the isolated planner. Nothing stops someone porting the flow to another orchestrator — PRs welcome.

---

### How is this different from raw ChatGPT/Claude, an awesome-prompts repo, or a CrewAI build?

Forced critique (Phase 5 is hard-gated, not optional, and runs a fixed adversarial rubric that separates the *thesis* from the *parameters*), a fact-checking discipline (Tier 1/2/3 with ✅/⚠️/🔍 labels so it stops inventing market sizes), cross-session memory (append-only context files), a buildable handoff (`/scaffold` turns the finished brainstorm into a folder you build from), an execution-loop re-critique (`/recheck`) so you don't tunnel during the build, and eight ready domain profiles. The full comparison table is in the [README](../README.md#-why-this-vs-alternatives).

---

### How do I run it?

Clone the repo and open the folder in Cowork or Claude Code — the root `CLAUDE.md` activates the coordinator automatically. For any other LLM, copy `distributions/standalone-prompts/lite.md` into the chat (degraded: no memory, no isolated planner).

---

### What are profiles?

Eight modes — one general base plus seven domain specializations (startup, personal-project, exploration, tech-architecture, content-strategy, product-roadmap, personal-decisions). A preset is picked at the start of each session (or auto-classified from your description); it sets the lens **and** the *flow shape* — which phases run full, light, or skipped. They override defaults *inside* each phase (which frameworks the coordinator reaches for, which questions it asks). Switch with `/profile <name>`. See [docs/PROFILES.md](PROFILES.md).

---

### Do the slash commands (`/profile`, `/critique`, `/plan`…) work?

In **Claude Code and the Claude CLI**, yes — they ship as skills in `.claude/skills/`, so typing `/profile startup` (or `/critique`, `/recheck`, `/plan`, `/recommend`, `/memory`, `/reset`, `/phase`, `/scaffold`) just works.

In **Cowork**, `/` is reserved for installed plugins. Install the idea-to-build plugin (see the README Quick Start) and the namespaced `/idea-to-build:*` commands work there too. Without the plugin installed, just say it in plain language — "switch to the startup profile", "run the critique now", "start a new brainstorm" — the coordinator understands those everywhere, including Claude Code.

To fact-check a claim, the command is **`/factcheck <claim>`** — named `factcheck` rather than `verify`, because `/verify` collides with a built-in Claude Code skill.

---

### Does it hallucinate numbers?

It's built specifically not to. Every material claim gets a confidence label — ✅ verified (found a current source), ⚠️ hypothesis (reasoned, not verified), 🔍 needs verification (important, no source found). For market sizes, prices, competitor data, and current platform policies, it's required to search before stating. When it can't find a source, it says so rather than inventing one.

---

### Does it write the code / build my project?

It doesn't write your application code — it's a *thinking* tool that takes you from a raw idea to a critiqued plan, and deliberately refuses to jump to building. But once Phase 6 is done, **`/scaffold`** generates a ready-to-build project folder from your brainstorm: a `CLAUDE.md` (with the chosen approach, the rejected paths, the risks to watch, and the go/no-go gates), plus `README.md`, `DECISIONS.md`, and `PLAN.md`. That's the *briefing* — you open the folder in Claude Code and it builds from there. The scaffolder makes the handoff, Claude Code writes the code.

---

### What happens once I start building — does it just leave me there?

No. The deadliest failures don't happen in the brainstorm; they happen during the build, where a project quietly tunes the *parameters* of a *thesis that was never true* — "no amount of calibration fixes a structurally wrong approach." Once you have real results, run **`/recheck`** (paste the data): it re-critiques the project from its context file under one question — *is the thesis failing, or just the tuning?* It checks whether you're measuring the real outcome or a proxy, whether the build still implements the thesis, gives the thesis a fair bounded test, and returns 🟢 keep / 🟡 pivot the thesis / 🔴 kill — pointing back to the alternatives you rejected so you don't tunnel a dead approach. The scaffolded `CLAUDE.md` carries the same guardrails into the build, so the building agent stays honest without you having to come back.

---

### What does it cost?

Free — it runs on your existing Claude subscription (Cowork / Claude Code). No separate API keys or per-token billing for the methodology itself.

---

### Where does my project memory live? Is it private?

In plain markdown files in `context/` inside your own copy of the repo. Nothing is uploaded anywhere by the methodology; it's the same local files you'd commit (or not) yourself.

---

### Can I contribute?

Yes — new domain profiles, sharper sub-agent prompts, real brainstorm transcripts for `examples/`, translations, bug reports. See [CONTRIBUTING.md](../CONTRIBUTING.md).
