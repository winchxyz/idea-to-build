# General Profile (default)

The base profile that activates if no specialized profile is loaded. Suitable for any brainstorming context.

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
**Tier 3 search topics to cover:**
- Direct competitors / alternatives
- Recent shifts in the relevant market or platform
- Regulatory or policy constraints
- Current pricing or cost benchmarks (if applicable)

### Phase 3 — Generation
**Variant spread axes:**
- Risk: safe vs. ambitious
- Speed: fast-to-market vs. long-build
- Scope: narrow vs. broad
- Resources: leveraging existing vs. greenfield

Produce 3–5 variants spanning these axes.

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
