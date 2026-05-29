# Tech Architecture Profile

For system design, stack choices, and engineering trade-off decisions.

## When to use

- Greenfield system design
- Major refactor or migration planning
- Choosing between competing technologies
- Designing for scale, reliability, or specific non-functional requirements
- Architecture review and second-opinion

## Phase customizations

### Phase 1 — Understanding
**Scoping questions:**
- What's the functional requirement?
- What are the non-functional requirements (scale, latency, availability, cost ceiling)?
- What's the team size and skill mix?
- What's the existing tech stack, if any?
- What's the time horizon (MVP vs. 5-year platform)?

### Phase 2 — Context
**Tier 3 search topics:**
- Current state of the relevant technologies (cloud services, frameworks, databases)
- Recent breaking changes or deprecations
- Real-world production case studies at similar scale
- Pricing tiers for managed services involved
- Open-source vs. vendor landscape

### Phase 3 — Generation
**Variant axes specific to tech architecture:**
- Build vs. buy vs. open-source-stitch
- Monolith vs. modular vs. microservices
- Self-host vs. managed services
- Synchronous vs. asynchronous communication
- Stateful vs. stateless

Always generate at least one "boring tech" variant and one "modern stack" variant.

### Phase 4 — Deep Dive
**Specification must include:**
- Component diagram (text-based or ASCII)
- Data flow
- Failure modes and recovery
- Scaling plan (vertical, horizontal, partition)
- Cost estimate per stage of scale
- Operational complexity (who maintains this Monday morning at 3 AM)

### Phase 5 — Critique
**Premortem questions specific to tech architecture:**
- What's the most likely cause of a Sev1 incident in year 1?
- What if the team that built this leaves?
- What if the chosen vendor changes pricing 5x?
- What if the load is 100x the assumption?
- What if a regulator requires data residency in a new jurisdiction?

### Phase 6 — Plan
**Planner deliverables specific to tech architecture:**
- Phased rollout with reversibility checkpoints
- Migration plan from existing system (if applicable)
- Observability and alerting setup before any traffic
- Runbook for the 5 most likely incidents
- Cost monitoring and budget alerts

## Frameworks heavily used

- C4 model (Context / Container / Component / Code)
- CAP theorem trade-offs
- Reversibility (one-way vs. two-way doors)
- "Choose boring technology" heuristic
- TCO over 3 years, not initial cost
- Conway's Law (architecture follows team structure)

## Anti-patterns specific to tech architecture

- Over-engineering for hypothetical scale ("we might need to do 1M req/sec one day")
- Adopting a technology because it's trending rather than because it solves the problem
- Ignoring operational cost (who runs this, what does it take)
- Underestimating migration cost from existing systems
- Treating data model as an afterthought
- Skipping observability "until we need it"

## Critical risks to surface in critique

1. Vendor lock-in with no defensible exit
2. Architectural complexity exceeds team capacity to operate
3. Failure mode that requires rare expertise to diagnose
4. Cost scaling super-linearly with users
5. Data model that can't accommodate likely future requirements
