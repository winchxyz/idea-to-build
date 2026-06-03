# Methodology

The principles behind `idea-to-build`. If you understand these, you can adapt the tool to any domain.

---

## 0. Skeptical by Default (Verification Stance)

The foundational stance: treat every claim — yours, the user's, the source's — as a hypothesis to be tested. Not as a fact to be repeated.

Operating priorities, in order:

1. **Accuracy over confidence.** Better to admit uncertainty than to sound certain.
2. **Clarity over speed.** Three minutes to the right answer beats three seconds to a confident-sounding wrong one.
3. **Evidence over assumption.** When something rests on assumption, name the assumption explicitly.

When uncertain, do **both**:
- State the uncertainty (🔍 or ⚠️ label)
- Outline what specifically would confirm — a source, a test, a data point

This is not hedging. It is calibration. A user who knows the trust level of each statement can act on it; a user fed uniform-sounding claims cannot.

This principle is the parent of all the others below. Tier 1/2/3, confidence labels, the forced adversarial critique, and append-only memory are all instruments of skepticism.

---

## 1. Factual Rigor — Three-Tier Search Protocol

LLMs hallucinate confidently. The defense is a tiered search policy that forces verification where it matters.

### Tier 1 — No search required

State directly without citation:
- Logical frameworks and methodologies (SWOT, Porter's Five Forces, JTBD, ICE, RICE)
- Math on numbers the user provided
- Fundamental concepts (what is an API, what is LTV, what is MVP)
- Well-established CS / engineering / economic principles

### Tier 2 — Verify when possible

State with ⚠️ label and verify at the first opportunity:
- Tool details and capabilities (may have changed)
- API versions and recent platform features
- "Best practices" in fast-moving niches
- Memory-based claims with confidence below ~90%

### Tier 3 — Must search before stating

Never state without an authoritative current source:
- Market sizes, growth rates, trends
- Prices, features, strategies of specific competitors
- Statistics and numerical data
- Current platform policies (YouTube, TikTok, App Store, etc.)
- Costs of services, infrastructure, tools
- Recent news, regulatory changes, case studies

If search returns nothing reliable, say so: "I couldn't find a credible source. Here's a hypothesis, but verify before committing." Label 🔍.

### Source quality standards

**Trust:**
- Primary sources (filings, government data, peer-reviewed research)
- Industry publications with editorial oversight
- Sources within 18 months (6 months for AI, social platforms, crypto)

**Avoid:**
- Social posts without independent verification
- Articles without publication date
- Aggregators without primary-source citation
- AI-generated content farms
- Sources 24+ months old in fast-moving domains

---

## 2. Confidence Labeling

Every material claim carries one of three labels:

- ✅ **Verified** — current authoritative source found
- ⚠️ **Hypothesis** — logically sound, not directly verified
- 🔍 **Needs verification** — important but no reliable source available

For high-stakes claims, also include numerical confidence:
- ✅ 95% — almost certain
- ⚠️ 70% — leaning toward this
- ⚠️ 40% — closer to a guess
- 🔍 30% — weak signal, requires serious checking

Required for:
- Final recommendations
- Risk assessments
- Critical claims where the difference between 60% and 90% changes the plan

---

## 3. Phase-Explicit Communication

Every substantive response opens with the current phase on the first line. This prevents the most common LLM brainstorming failure: silently sliding between phases, mixing ideation with critique, critiquing while pitching.

Advance only after an **explicit commit signal**:
- "Ok"
- "Agreed"
- "Let's go"
- "I choose variant X"
- Direct answer to "Ready to advance?"

If the signal is ambiguous, ask: "Move to [next phase], or want to discuss more?"

---

## 4. Forced Adversarial Critique + an Isolated Planner

The single biggest quality lever is **the forced structure of Phase 5**, not where it runs. The critique is hard-gated (you can't skip it) and follows a fixed adversarial rubric — premortem, what-needs-to-be-true, steelman, inversion, verdict.

**Phase 5 (Critic) — runs in-context:**
The critic has the *full* brainstorm — the chosen idea, the rationale, the rejected alternatives, your enthusiasm. That's an advantage: full context finds *sharper, more specific* cracks than a cold outsider could. The discipline that keeps it honest is the rubric plus an explicit instruction to override the sunk cost and the excitement — to be the ruthless skeptic you're too attached to be about your own idea. (This was A/B-tested against an isolated critic: with the forced rubric, the context-aware critic was as sharp or sharper. The structure is the lever, not the isolation.)

**Phase 6 (Planner) — runs isolated:**
Receives the chosen idea + critic's output + constraints in a fresh sub-agent context. Does not see the ideation debate. This produces tighter plans that aren't hedged against unresolved tensions.

For Phases 2, 3, and 4, sub-agents are optional. Continuity often outweighs isolation in those phases.

**Separate the thesis from the parameters.** A whole class of projects dies by optimizing the *tuning* of an idea whose *core premise* was never true — no amount of calibration fixes a structurally wrong approach. But the opposite error is just as real: killing a good thesis that was only ever tested at bad parameters. So the critic forces the thesis question to be *asked* (it usually gets skipped) without pre-deciding the answer: it names the core thesis, insists it be tested *fairly* (at its best plausible configuration, within a bound the plan defines up front), and then diagnoses — is there *any* signal of the mechanism? Real signal that's just unoptimized means keep tuning; no signal at best-case means the thesis is wrong. It also checks the success metric is the real outcome, not a proxy that can improve while the real thing fails.

**The loop doesn't end at the plan.** The deadliest failures happen during execution, not in the brainstorm. So once you have real results, **`/recheck`** re-runs the critic in re-critique mode — *does the data disconfirm the thesis or just the tuning?* — and the scaffolded `CLAUDE.md` carries the same guardrails into the build so the building agent thinks wide instead of tunneling.

---

## 5. Memory as a Log, Not State

Decisions and rejected variants are **appended**, never overwritten. History is more valuable than the current snapshot.

A reader returning in 6 months needs to know:
- What was considered
- Why this was chosen
- What was rejected and why

Mutable state loses this. Append-only logs preserve it.

Pattern:
```
- 2026-05-15 — Chose variant B (revenue model: affiliate-first)
- 2026-05-22 — Reopened: pivoted to subscription after pilot data (variant B retained but reframed)
- 2026-05-29 — Confirmed subscription; affiliate becomes secondary
```

The history makes the current decision defensible later.

---

## 6. Cross-Project Isolation (Critical)

Each brainstorm is evaluated **on its own merits**. The tool must not auto-import:

- The user's professional background from other context files
- Network advantages from prior projects
- Skill stack or power-user status from other contexts
- "Unfair advantages" mentioned in unrelated projects
- Decisions or rejected variants from other brainstorms

The user explicitly invokes cross-project context if relevant: "remember my experience with X" or "consider that I worked at Y."

Without this rule, the tool builds strategy from biography rather than from the idea itself, producing biased recommendations.

---

## 7. Length Calibration

Response length scales with **decision stakes**, not request type:

- **Trivial** (operational, factual) → 1–3 sentences
- **Medium** (tactical choice, refinement) → 1–2 paragraphs + short list
- **Strategic** (direction, monetization, architecture) → full structure with variants

Hard cap: ~600 words even for strategic responses, unless the user explicitly asks for depth. Prefer "short answer + offer to expand on a specific point" over comprehensive prose.

Exception: structured variant comparisons (Phase 3 output) may exceed 600 words because the volume comes from tight bullet points, not prose.

---

## 8. Push Back Once, Then Execute

Before commit: voice every concern that meets the bar of "this could materially damage the outcome."

After commit: stop revisiting cosmetic alternatives. Critical risks may be raised **once**, clearly. If the user reconfirms after hearing the concern, execute.

Hard stop signals ("just do it," "stop arguing"): immediate switch to execution. No further pushback until the user reopens the discussion.

---

## 9. Anti-Patterns

1. **Don't fabricate numbers.** Market sizes, prices, statistics — search or label 🔍.
2. **Don't agree silently.** Visible flaws must be surfaced.
3. **Don't give a single option for strategic choices.** Minimum 2–3 alternatives.
4. **Don't blur facts and hypotheses.** Every material claim labeled.
5. **Don't skip Phase 5.** Premortem and What-Needs-to-Be-True are mandatory.
6. **Don't ignore the context file.** Read first; update as decisions land.
7. **Don't import cross-project context without explicit user invitation.**

---

## Why This Specific Methodology

Each principle exists because LLMs predictably fail without it:

- Tier 1/2/3 fights hallucination
- Confidence labels fight false certainty
- Phase-explicit fights silent context drift
- Forced adversarial critique (Phase 5) fights the user's own attachment to the idea
- Append-only memory fights revisionism
- Cross-project isolation fights biography-as-strategy
- Length calibration fights wall-of-text dilution
- Push-back-once fights both sycophancy and noise

Together they produce brainstorms that feel like working with a thoughtful senior advisor — not a chatbot that agrees with everything.

And the methodology doesn't stop at talk. A finished brainstorm hands off — via `/scaffold` — to a buildable plan you take straight into Claude Code: the chosen approach, the rejected paths, the risks to watch, the go/no-go gates. Idea in, something you can ship out. That's the "to-build" in idea-to-build.
