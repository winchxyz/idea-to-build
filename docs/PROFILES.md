# Profile Authoring Guide

How to write a new domain profile for `idea-to-build`.

## What a profile is

A profile **specializes** the coordinator and sub-agents for a specific domain without replacing the core methodology. It overrides or extends defaults inside each phase.

A profile is a single markdown file in `profiles/<name>.md`. It is loaded when the user runs `/profile <name>`.

## When a new profile is justified

✅ Create a new profile if:
- The domain has its own frameworks not covered by existing profiles (e.g., LTV/CAC for startup, C4 model for tech-arch)
- The Tier 3 search topics differ materially from existing profiles
- The premortem questions, anti-patterns, or critical risks are distinct
- A meaningful audience would use the profile repeatedly

❌ Don't create a new profile if:
- The general profile + one extra framework reference would suffice
- It's essentially "startup with a vertical hint" (better as a sub-section of the startup profile)
- The variations from existing profiles are <30%

## Profile structure

Use this template:

```markdown
# <Domain> Profile

For <one-line audience description>.

## When to use
- Bullet list of concrete scenarios

## Flow shape (optional — omit to use the default: all phases `full`, scaffold after Phase 6)
- Per-phase weight (`full` / `light` / `skip`) when this domain's flow differs from the default,
  plus whether `/scaffold` applies. See `core/CLAUDE.md` → "Flow Shape".

## Phase customizations

### Phase 1 — Understanding
**Scoping questions:** <domain-specific questions to ask>

### Phase 2 — Context
**Tier 3 search topics:** <what to search for in this domain>

### Phase 3 — Generation
**Variant axes specific to <domain>:** <axes the generator should use>

### Phase 4 — Deep Dive
**Specification must include:** <required spec elements>

### Phase 5 — Critique
**Premortem questions specific to <domain>:** <domain-specific failure scenarios>

### Phase 6 — Plan
**Planner deliverables specific to <domain>:** <expected outputs>

## Frameworks heavily used
- List of methodologies the coordinator may reference

## Anti-patterns specific to <domain>
- What NOT to do in this domain

## Critical risks to surface in critique
- The 5 risks most likely to kill projects in this domain
```

## Quality bar

A good profile:
- Adds **at least 3 frameworks** not in the general profile
- Adds **at least 3 anti-patterns** not in the general profile
- Adds **5 critical risks** specific to the domain
- Adds **at least 5 Tier 3 search topics** the general profile wouldn't surface
- Is between 80 and 200 lines

## Testing a profile

Before submitting:

1. Run a brainstorm in your profile's domain through the coordinator with `/profile <yourname>`
2. Compare the output quality to running the same brainstorm with the general profile
3. If the difference is marginal, refine the profile — it's not specialized enough
4. If the difference is significant in quality and concreteness, you're ready to submit

## Domains that would benefit from profiles (open call)

We have specific interest in:

- **Legal strategy** (litigation, M&A, regulatory)
- **Healthcare / biotech** (clinical, regulatory, payer-aware)
- **Education / curriculum design**
- **Climate / sustainability ventures**
- **B2B sales strategy**
- **Real estate / property development**
- **Academic research design**
- **Nonprofit / mission-driven organizations**
- **Open-source project strategy**
- **Creative writing / fiction project**
- **Music / album / artist career**

If you specialize in any of these, your profile would be a major contribution.

## Anti-patterns in profile design

❌ Writing a profile that duplicates the general profile with slight tone changes
❌ Adding frameworks "for completeness" that you wouldn't actually use
❌ Critical risks copied from another profile without domain-specific framing
❌ Tier 3 search topics that aren't actually search-able (too vague)
❌ Profiles that try to be "all things to a vertical" instead of focused

## Submitting

1. Place your profile at `profiles/<name>.md`
2. Add an entry to the README's profile table
3. Open a PR with title "profile: <name>"
4. Include in the PR description: a sample brainstorm session showing the profile's value vs. the general profile
