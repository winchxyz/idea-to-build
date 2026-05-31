# FAQ

Honest answers to the questions people actually ask. If something here is hand-wavy or wrong, open an issue — that's on-brand for this project.

---

### Is this *really* multi-agent, or is it one model role-playing "now I'm the critic"?

Really multi-agent — when you run it on a host that can launch sub-agents. The critique and planning phases are dispatched as **separate agent invocations with their own fresh context window** via the host's sub-agent tool (the `Agent` tool in Cowork, the `Task` tool in Claude Code). The critic does not see your conversation; it gets only the chosen idea, scope, and constraints.

You can verify this yourself: in the [Hyperliquid](../examples/hyperliquid-wallet-comparison.md) and [food-delivery](../examples/food-delivery-comparison.md) examples, the Phase 5 trace shows `ran an agent` — a separate agent that does its *own* web research the main thread never did.

The one caveat: the **standalone single-prompt version** (`distributions/standalone-prompts/lite.md`) runs in one context — no real isolation. It's the degraded fallback for non-Claude chats, and it says so.

> Note: "multi-agent" here means multiple agent *roles with isolated contexts*, all running on the same Claude model — not multiple different models. The value is the isolation, not model diversity.

---

### Couldn't a good system prompt get the same pushback inside one context?

Maybe, for simple stuff — and I'd genuinely like to see a counter-example. The bet is that after a long conversation, a single-context model has read all of you being excited and tends to mirror it; a sub-agent that starts clean isn't anchored. I lean toward isolation mattering, but I haven't tested that claim rigorously. If you've gotten consistently blunt critique out of one context, show me.

---

### Does it actually tell you "no," or just hedge?

It says no. See [AI support agent](../examples/ai-support-agent-comparison.md) (recommends not building), [food delivery](../examples/food-delivery-comparison.md) (isolated critic returns NO-GO on the head-on idea), and [Hyperliquid](../examples/hyperliquid-wallet-comparison.md) (NO-GO: you'd be entering behind a funded incumbent). It pushes back, respects your override if you insist, and then lets an isolated critic render the verdict — it doesn't nag and it doesn't cave.

---

### Why Claude and not [other model]?

Because the sub-agent dispatch is native in Cowork / Claude Code, so the isolation that does most of the work is clean. The single-prompt fallback runs anywhere but loses that. Nothing stops someone porting the multi-agent flow to another orchestrator — PRs welcome.

---

### How is this different from raw ChatGPT/Claude, an awesome-prompts repo, or a CrewAI build?

Forced critique (Phase 5 is hard-gated, not optional), a fact-checking discipline (Tier 1/2/3 with ✅/⚠️/🔍 labels so it stops inventing market sizes), cross-session memory (append-only context files), real phase isolation (sub-agents, not one context bleeding into itself), and six ready domain profiles. The full comparison table is in the [README](../README.md#-why-this-vs-alternatives).

---

### How do I run it?

Clone the repo and open the folder in Cowork or Claude Code — the root `CLAUDE.md` activates the coordinator automatically. For any other LLM, copy `distributions/standalone-prompts/lite.md` into the chat (degraded: no isolation, no memory).

---

### What are profiles?

Six modes — one general base plus five domain specializations (startup, tech-architecture, content-strategy, product-roadmap, personal-decisions). They override defaults *inside* each phase (which frameworks the coordinator reaches for, which questions it asks). Switch with `/profile <name>`. See [docs/PROFILES.md](PROFILES.md).

---

### Do the slash commands (`/profile`, `/critique`, `/plan`…) work?

In **Claude Code and the Claude CLI**, yes — they ship as skills in `.claude/skills/`, so typing `/profile startup` (or `/critique`, `/plan`, `/recommend`, `/memory`, `/reset`, `/phase`, `/scaffold`) just works.

In **Cowork**, `/` is reserved for installed plugins, so a bare `/profile` returns "Unknown skill." Until the v0.2 Cowork plugin ships (it will register these commands), just say it in plain language — "switch to the startup profile", "run the critique now", "start a new brainstorm". The coordinator understands those everywhere, including Claude Code.

To fact-check a claim, the command is **`/factcheck <claim>`** — named `factcheck` rather than `verify`, because `/verify` collides with a built-in Claude Code skill.

---

### Does it hallucinate numbers?

It's built specifically not to. Every material claim gets a confidence label — ✅ verified (found a current source), ⚠️ hypothesis (reasoned, not verified), 🔍 needs verification (important, no source found). For market sizes, prices, competitor data, and current platform policies, it's required to search before stating. When it can't find a source, it says so rather than inventing one.

---

### Does it write the code / build my project?

It doesn't write your application code — it's a *thinking* tool that takes you from a raw idea to a critiqued plan, and deliberately refuses to jump to building. But once Phase 6 is done, **`/scaffold`** generates a ready-to-build project folder from your brainstorm: a `CLAUDE.md` (with the chosen approach, the rejected paths, the risks to watch, and the go/no-go gates), plus `README.md`, `DECISIONS.md`, and `PLAN.md`. That's the *briefing* — you open the folder in Claude Code and it builds from there. The scaffolder makes the handoff, Claude Code writes the code.

---

### What does it cost?

Free — it runs on your existing Claude subscription (Cowork / Claude Code). No separate API keys or per-token billing for the methodology itself.

---

### Where does my project memory live? Is it private?

In plain markdown files in `context/` inside your own copy of the repo. Nothing is uploaded anywhere by the methodology; it's the same local files you'd commit (or not) yourself.

---

### Can I contribute?

Yes — new domain profiles, sharper sub-agent prompts, real brainstorm transcripts for `examples/`, translations, bug reports. See [CONTRIBUTING.md](../CONTRIBUTING.md).
