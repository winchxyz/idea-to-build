# General Profile (default)

The base profile that activates if no specialized profile is loaded, or as the fallback when a preset doesn't fit. Suitable for any brainstorming context.

**Calibrate to nature first.** General does *not* mean "business by default." Before applying the lenses below, register what the project actually is (personal build, commercial venture, exploration, decision…) and aim the questions and the critique accordingly — if it's clearly a personal/internal build or an open exploration, prefer the `personal-project` or `exploration` preset. Do not import market/competitor/ROI framing into a project that has no market.

## Flow shape

Default: all six phases `full`, scaffold available after Phase 6. (Specialized presets override this — see their own Flow shape sections.)

## When to use

- Any idea, any domain
- Mixed-domain projects that don't fit a single specialization
- When you're not sure which profile applies — start here, switch later

## Phase customizations

### Phase 1 — Understanding
**Scoping questions to ask** (use as needed, not all):
- What outcome are you trying to produce?
- Who is this for?
- What are the hard constraints (budget, timeline, skills)?
- What have you already considered or ruled out?
- What's the time horizon for a "result"?

### Phase 2 — Context
**For outward-facing / commercial projects, Tier 3 search topics to cover:**
- Direct competitors / alternatives
- Recent shifts in the relevant market or platform
- Regulatory or policy constraints
- Current pricing or cost benchmarks

**For a personal / internal build,** "context" is different — there's no market to research. Cover instead: existing tools/libraries you'd otherwise use, the build-vs-reuse case, and your own constraints (time, skills, stack).

### Phase 3 — Generation
**Variant spread axes:**
- Risk: safe vs. ambitious
- Speed: fast-to-market vs. long-build
- Scope: narrow vs. broad
- Resources: leveraging existing vs. greenfield
- Testability: mutually exclusive (you must pick one) vs. cheaply parallel-testable

Produce 3–5 variants spanning these axes.

**Reversibility check.** If several variants are **cheap and reversible** to test (sandbox, paper, easily undone), flag that running them **in parallel** likely beats committing to one and tuning it sequentially — same wall-clock, more learning. Sequential, one-at-a-time commitment is for **one-way doors** (expensive or hard to undo). Don't serialize what you could cheaply parallelize.

### Phase 4 — Deep Dive
**Specification structure:**
- Positioning paragraph
- Core mechanic
- Architecture / components
- Required inputs (skills, time, capital)
- First 5 concrete outputs

### Phase 5 — Critique
Use the default Critic agent (`core/agents/critic.md`) with no profile-specific modifications.

### Phase 6 — Plan
Use the default Planner agent (`core/agents/planner.md`) with no profile-specific modifications.

## Frameworks the coordinator may invoke

- SWOT
- Porter's Five Forces
- Jobs-to-be-Done
- ICE / RICE
- Premortem
- What Needs to Be True
- Inversion
- Steelmanning

## Anti-patterns specific to general use

- Asking too many scoping questions before generating variants (over-frontloading)
- Forcing a specific framework when the user's problem doesn't fit
- Defaulting to startup advice for non-startup problems
