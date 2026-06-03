# The Six Phases

`idea-to-build` runs every session through six explicit phases. The coordinator announces the current phase in every substantive message and refuses to **change phase — forward, backward, or re-opening a finished phase — without an explicit commit signal** from the user. A question, pushback, or correction *within* a phase is not a phase change: the coordinator answers it and stays put, and if new information seems to demand a phase change it names it, asks, and waits.

This document explains what each phase does, what its output looks like, and where the easy mistakes are.

---

## Before Phase 1 — Preset & Flow Shape

Before Understanding, the coordinator establishes **what kind of thing this is** via a one-question preset: `startup`, `personal-project`, `exploration`, `tech-architecture`, `content-strategy`, `product-roadmap`, or `personal-decision` (or the user describes it and the coordinator classifies, then confirms). The preset does two things:

- **Lens** — which questions, frameworks, and vocabulary each phase uses, and (critically) **how the critique is aimed**. A personal build is not a business: its failure modes are abandonment and over-engineering, not market/adoption/ROI.
- **Flow shape** — how heavy each phase is for that kind of project (`full` / `light` / `skip`). The 6-phase spine is the same; the weights differ. E.g. `exploration` ends at Critique (no isolated Plan, no scaffold); `personal-project` runs Critique through the personal lens and Plan `light`. The coordinator tells the user the shape it's running.

---

## Phase 1 — Understanding

**Goal:** Restate the user's problem in your own words. Confirm scope. Surface implicit assumptions.

**Coordinator behavior:**
- Read the project context file (if continuing) or create one (if new)
- Ask 3–5 scoping questions if essential context is missing
- Reflect back the problem statement for confirmation

**Output:** A one-paragraph problem statement the user agrees with.

**Common mistakes:**
- Skipping straight to ideation
- Asking 15 clarifying questions in a row (over-questioning is friction)
- Not writing the agreed statement to the context file

**Exit criterion:** User confirms "yes, that's what I'm trying to do."

---

## Phase 2 — Context

**Goal:** Map the landscape. Who's already doing this? What changed recently? What are the platform / regulatory / market constraints?

**Coordinator behavior:**
- Identify what needs Tier 3 search (market data, competitor info, current policies)
- Optionally dispatch the **Research Agent** for stronger isolation on research-heavy tasks
- Apply confidence labels (✅ / ⚠️ / 🔍) to every material claim

**Output:** A briefing covering competitors, recent shifts, constraints, and unknowns — with cited sources.

**Common mistakes:**
- Skipping search and stating facts from memory
- Quoting sources older than 18 months in fast-moving domains
- Treating the briefing as conclusions instead of inputs

**Exit criterion:** User has enough landscape clarity to proceed to ideation.

---

## Phase 3 — Generation

**Goal:** Produce 3–5 **radically different** approaches. Not variations on a theme.

**Coordinator behavior:**
- Optionally dispatch the **Ideation Agent** for lateral thinking
- Enforce spread (some safe, some risky; some fast, some slow; some narrow, some broad)
- Present neutrally — let the user pick

**Output:** A table of variants with pros, cons, effort, and risk profile.

**Common mistakes:**
- Generating 5 variations of the same underlying idea
- Subtly biasing toward a preferred variant
- Skipping the "cons" section because the variant is exciting

**Exit criterion:** User picks one variant to deep-dive (or asks for more variants).

---

## Phase 4 — Deep Dive

**Goal:** Develop the chosen variant into a concrete, well-specified concept.

**Coordinator behavior:**
- Optionally dispatch the **Deep-Dive Agent**
- Specify the mechanism, architecture, required inputs, and produced outputs
- Surface trade-offs vs. rejected variants (prevents post-decision rationalization)
- List open sub-decisions, tagged by urgency

**Output:** A concept specification ready for critique.

**Common mistakes:**
- Silently dropping the rejected variants (no trade-off statement)
- Producing a 10-page spec when 1 page is enough
- Promising "everything will work" instead of naming open decisions

**Exit criterion:** User feels the concept is specific enough to criticize.

---

## Phase 5 — Critique (mandatory; cannot be skipped)

**Goal:** Try to break the chosen idea.

**Coordinator behavior:**
- **Become the critic in-context** — follow `core/agents/critic.md`; do **not** spawn a sub-agent
- Use the full brainstorm (idea, rationale, rejected alternatives) to find *sharper* cracks — but explicitly override the sunk cost and the user's enthusiasm; don't soften the verdict because they want it to work
- Render the verdict verbatim — no re-softening, no Phase-6 sales pitch

**Required critic output:**
1. **Premortem** — 5 ranked failure causes with probability + mechanism + preventability
2. **What Needs to Be True** — 5–7 assumptions labeled ✅ / ⚠️ / 🔍
3. **Steelman the opposition** — the strongest argument against
4. **Inversion** — what would reliably kill this
5. **Verdict** — GO / GO with conditions / NO-GO

**Common mistakes:**
- Going easy because you've seen how much the user wants this (the sunk cost is exactly what you're here to counter)
- Skipping inversion because it's uncomfortable
- Refusing to commit to a verdict

**Exit criterion:** User has seen the failure modes and either accepts the conditions or returns to Phase 3.

---

## Phase 6 — Plan

**Goal:** Turn the critiqued strategy into an executable plan with explicit success gates.

**Coordinator behavior:**
- **Dispatch the Planner Sub-Agent in isolated context**
- Pass the chosen idea + critic's output + constraints
- Aggregate the plan back to the user

**Required planner output:**
1. **Mini-MVP / Pilot** (if scope > 1 week) — minimum test of riskiest assumptions
2. **Sequenced plan** — day-by-day or week-by-week for first execution period
3. **Critical risks & mitigations** — specific actions, not platitudes
4. **Green-light criteria** — quantitative or binary checkpoints
5. **Budget summary** — one-time, recurring, contingency
6. **What the user does today** — one concrete action within 24 hours

**Common mistakes:**
- Generating a 50-step plan (first 10 matter most)
- Skipping the pilot because the user is impatient
- Vague green-light criteria ("if it's going well")

**Exit criterion:** User commits to execution (run `/scaffold` to generate the build handoff) OR returns to Phase 3 if the plan reveals the idea isn't viable.

---

## After Phase 6 — the build handoff

The brainstorm is **closed** — but it doesn't just evaporate into "now go build it somehow." Run **`/scaffold`** to turn the whole brainstorm into a ready-to-build folder — `CLAUDE.md` (chosen approach, rejected paths, risks to watch, go/no-go gates), `README.md`, `DECISIONS.md`, `PLAN.md` — that you open in Claude Code to start building. The scaffolder runs with the **full** project context (it is *not* isolated, unlike the planner) and is gated to require a completed Phase 6. It produces the briefing, **not** application code.

The scaffolded `CLAUDE.md` carries the brainstorm's strategic discipline into the build so the building agent **thinks wide instead of tunneling**: the core thesis, the rejected alternatives (kept in view as fallbacks), the #1 premise-risk, and explicit guardrails — measure the real outcome (not a proxy); when results disappoint, separate the thesis from the parameters and diagnose which is failing (a fair test of the thesis at its best config; any signal of the mechanism?) rather than defaulting to tune-more or to kill; check the build still implements the thesis; and parallel-test cheap reversible options instead of serially tuning one.

## The loop doesn't end at the plan — `/recheck`

The deadliest failures don't happen in the brainstorm; they happen **during execution**, where a project quietly optimizes the *parameters* of a *thesis that was never true* — "no amount of calibration fixes a structurally wrong approach." A one-time pre-build critique can't catch this.

So once you have **real results**, come back and run **`/recheck`** (paste the data). It re-runs the critic in *re-critique mode* on the project from its context file, under one question: **does this data disconfirm the thesis, or just the tuning?** It checks outcome-vs-proxy and build-fidelity, refuses to let "not enough data" defer the structural question, and returns 🟢 keep / 🟡 pivot the thesis / 🔴 kill. If it says pivot or kill, it points back to the rejected alternatives so you don't tunnel a dead approach.

Future sessions also reopen the project from its context file and may run other targeted phases (e.g., re-plan after pilot data). Re-opening Phase 3 requires an explicit user signal: "let's reconsider variants" or "I want to pivot."
