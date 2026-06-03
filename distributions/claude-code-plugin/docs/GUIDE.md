# Usage Guide

How to actually use idea-to-build for the situations you'll hit. (For install, see the [README Quick Start](../README.md#-quick-start).)

Two things hold across everything below:
- **In Cowork**, if `/`-commands aren't registered, just say them in plain language — "run the critique", "switch to the startup profile", "re-check this with my results". The coordinator understands those everywhere.
- The session **chats in your language** but **writes files in English** (they're build artifacts Claude Code reads).

## Which scenario are you in?

- **Starting a brand-new idea** → [New idea → build](#new-idea--build)
- **You already built something and have real results** → [Re-check a project you're building](#re-check-a-project-youre-building)
- **You have a working project and want to plan a change** → [Plan a change to an existing project](#plan-a-change-to-an-existing-project)
- **Not sure which lens fits** → [Picking a profile](#picking-a-profile)

---

## New idea → build

The full arc, end to end.

1. **`/start`** (or just describe the idea). First it asks **what kind of project this is** — pick a preset, or describe it and it classifies, then confirm. The preset sets the lens *and* the flow shape (which phases run full / light / skipped).
2. **Phases 1–4.** It restates your goal (Understanding), maps the landscape with sources (Context), generates 3–5 *genuinely different* approaches (Generation), and develops the one you pick (Deep Dive). It won't change phase without your "ok" / "next".
3. **Phase 5 — Critique.** A forced premortem + steelman + inversion you can't skip. It names the **core thesis**, separates it from the parameters, and returns GO / GO-with-conditions / NO-GO. Push back and ask follow-ups freely — it stays in this phase until you signal to move.
4. **Phase 6 — Plan.** A gated plan with a cheap **pilot that tests the riskiest assumption first** (usually whether the thesis is even true), plus kill-criteria.
5. **`/scaffold`.** Turns the whole brainstorm into a folder — `CLAUDE.md` + `README` + `DECISIONS` + `PLAN` — you open in Claude Code and build from. The `CLAUDE.md` carries the thesis, the rejected paths, and "stay honest" guardrails so the build doesn't tunnel.
6. **Build, then `/recheck`.** Once you have real results, come back and re-check (next section).

See it run end to end: [`examples/medieval-tycoon-fullrun.md`](../examples/medieval-tycoon-fullrun.md).

---

## Re-check a project you're building

You already built something (here or elsewhere) and have results — good or bad. This is where most projects quietly die: tuning the *parameters* of a thesis that was never true. **No amount of calibration fixes a structurally wrong approach.**

1. Open the project in idea-to-build (it reads its `context/<slug>.md` if one exists).
2. Run **`/recheck`** and paste your **real results** — metrics, what's actually happening, where it's stuck.
3. It re-critiques under one question: **is the thesis failing, or just the tuning?** It rules out build-drift and proxy metrics, gives the thesis a *fair, bounded* test (its best plausible config), looks for any signal of the mechanism, and returns:
   - 🟢 **keep** — the thesis is alive; keep tuning (within the bound)
   - 🟡 **pivot the thesis** — fair test, no signal; change the approach, don't keep tuning
   - 🔴 **kill** — the thesis is disconfirmed
4. On pivot/kill, it points you back to the alternatives you rejected in the brainstorm — so you don't tunnel a dead approach.

**No prior idea-to-build brainstorm for it?** `/recheck` still works — describe the project and the thesis it rests on, then paste the results. If no clear thesis exists yet, it helps you name one first (that's usually the real problem).

---

## Plan a change to an existing project

You have a working project and want to think through a new feature, a pivot, or a hard call — not rebuild from scratch.

1. **`/start`** and scope it to the *change*, not the whole project: "I have X working; I'm deciding whether to add Y."
2. Pick the preset that fits **the decision**, not the product — e.g. `product-roadmap` to prioritize a feature, `tech-architecture` for a design choice, `personal-decision` for a judgment call.
3. Run the phases on the change. Critique and Plan stay scoped to that decision.
4. **`/scaffold`** only if the change is big enough to deserve its own build brief; otherwise just take the plan.

**Tip:** keep each project's brainstorm in its own `context/<slug>.md` so memory doesn't bleed between projects.

---

## Picking a profile

The preset aims the whole session — the questions, the frameworks, and (critically) **how the critique is aimed**. A personal tool is not a business; don't let it be critiqued like one.

| You're… | Preset | The critique aims at… |
|---|---|---|
| building something to sell / make money | `startup` | demand, adoption, unit economics, competition |
| building a tool / app / game for yourself | `personal-project` | will you finish & use it, over-engineering, build-vs-reuse |
| thinking a topic through, no build yet | `exploration` | the *reasoning* — assumptions, missing angles (ends at Critique, no scaffold) |
| designing a system / stack | `tech-architecture` | trade-offs, failure modes, complexity |
| growing content / an audience | `content-strategy` | channel fit, distribution, retention |
| prioritizing features on a product | `product-roadmap` | impact vs. effort, sequencing |
| making a life / career decision | `personal-decisions` | reversibility, downside, second-order effects |
| not sure / mixed | `general` | calibrates to whatever the project actually is |

Switch any time with **`/profile <name>`** (or, in Cowork, "switch to the startup profile"). The preset also sets the **flow shape** — e.g. `exploration` skips the isolated planner and `/scaffold`; `personal-project` runs a lighter plan. The coordinator tells you the shape it's running, and you can override it.

---

## Quick command reference

| Command | What it does |
|---|---|
| `/start` | Activate the coordinator, pick a preset, begin (or resume) a brainstorm |
| `/profile <name>` | Switch domain profile (the lens + flow shape) |
| `/critique` | Run the Phase 5 critique now, in-context |
| `/recheck` | Re-critique a built project with real results (thesis vs. tuning) |
| `/plan` | Run the Phase 6 planner |
| `/scaffold` | Turn the finished brainstorm into a buildable folder for Claude Code |
| `/recommend` | A calibrated recommendation with a confidence % |
| `/factcheck <claim>` | Verify one claim under the Tier 1/2/3 protocol |
| `/memory` | Show what's saved about the current project |
| `/reset` | Start a fresh project |
| `/phase <n>` | Jump to a phase (use sparingly) |
