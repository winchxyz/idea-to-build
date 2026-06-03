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

### Step by step: re-checking a project you built somewhere else

If you built the project in another chat or in Claude Code (not through idea-to-build), here's the safe, no-skill-needed way to get an honest re-check.

**Step 1 — Make a copy of your project folder, so nothing real gets touched.**
Find the folder on your computer, right-click → Copy, then Paste. Rename the copy to something like `myproject-recheck`. *(Why: idea-to-build only writes small notes files, never your code — but working on a copy means your real project stays exactly as it is.)*

**Step 2 — Get an honest summary from the AI that built it.**
Go back to the chat (or Claude Code session) where the project was built — it knows the project. Paste this and send it:

> Write a brutally honest project summary for an outside skeptic. Don't reassure me. Cover:
> 1. **The core thesis** — the one belief this whole project rests on, in one sentence.
> 2. **The real success metric** — the actual outcome that would prove it works (money, users, the edge, time saved) and the **real numbers so far**. Separate it from any proxy numbers we've tracked.
> 3. What we've **tried/tuned** and what moved or didn't.
> 4. Where there **is** a signal of it working (any subset/config), and where there's **none**.
> 5. Anywhere the build may have **drifted** from the original thesis into a generic version.
> 6. The honest open question: is the **thesis** in doubt, or just the **tuning**?
> Be specific, include numbers. Under-reporting problems makes this useless.

Copy the answer. *(If it sounds too upbeat, reply: "Be harsher — focus on what's NOT working and the real numbers.")*

**Step 3 — Open idea-to-build.**
Open the copy folder (`myproject-recheck`) in Cowork or Claude Code — or just start any idea-to-build chat.

**Step 4 — Run the re-check.**
Type **`/recheck`** and paste the summary from Step 2. *(In Cowork, if `/recheck` isn't available, just write: "Re-check this project — is the thesis failing, or just the tuning?" and paste the summary.)* Add one line: **"Don't trust this summary on its face — the AI that wrote it built the project, so it may be soft-pedaling the problems."**

**Step 5 — (Optional, makes it stronger) Let it check the real files.**
If you opened the copy folder, add: *"You can also read the project files to check whether the code actually does what the thesis claims."* This catches a build that quietly drifted from the plan.

**Step 6 — Read the verdict and act.**
- 🟢 **keep** — the idea's still alive; keep going.
- 🟡 **pivot** — the premise looks wrong; switch to one of the alternatives, don't keep tuning.
- 🔴 **kill** — stop; the thesis doesn't hold.

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
