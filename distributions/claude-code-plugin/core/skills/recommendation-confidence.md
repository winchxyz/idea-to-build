# Recommendation + Confidence Skill

**When invoked:** the user asks for a recommendation, or any agent (coordinator, critic, planner) is about to commit to a specific recommendation.

**Trigger phrases:** "what do you recommend", "what should I do", "your call", "pick one", `/recommend`.

**Auto-invoked:** at the end of Phase 6 (Plan) and inside the Critic verdict (Phase 5).

This skill enforces structured recommendations with **calibrated confidence**. It exists to prevent the most common LLM failure: a confidently-worded recommendation that hides its real uncertainty.

---

## Required Output Format

Every recommendation must use this structure. No exceptions.

```
## Recommendation

**Action:** <one-sentence specific action>

**Confidence:** <✅ / ⚠️ / 🔍> <numerical %>

**Rationale (why this level, not higher or lower):**
- <factor 1 — supporting or limiting confidence>
- <factor 2>
- <factor 3>

**What would raise confidence to <higher %>:**
- <specific evidence, test, or data point>
- <specific evidence, test, or data point>

**What would lower confidence to <lower %>:**
- <specific signal that would change the call>
- <specific signal>

**Alternative if confidence drops below <threshold %>:**
<fallback recommendation, also with confidence>

**Decision reversibility:**
<one of: One-way door / Two-way door / Hybrid>
<one sentence on cost-to-undo>
```

---

## Confidence Calibration Anchors

Use these as honest mental anchors. Do not output higher than you can defend.

| Label | Range | Meaning |
|-------|-------|---------|
| ✅ | 90–99% | Multiple authoritative current sources agree. Or: math on verified inputs. |
| ✅ | 75–89% | One authoritative source + strong reasoning. Disagreement would surprise you. |
| ⚠️ | 60–74% | Reasoning-based with some evidence. Reasonable people could disagree. |
| ⚠️ | 40–59% | Hypothesis. More evidence is needed before commitment. |
| 🔍 | 20–39% | Weak signal. Treat as a candidate worth testing, not a recommendation. |
| 🔍 | 0–19% | Speculation. Do not act on this alone. |

### Calibration sanity checks

Before outputting confidence, ask yourself:
1. **Would I bet money at these odds?** If your confidence is 70% but you wouldn't bet at 7:3 odds, lower it.
2. **Have I seen base rates in this domain?** Startup pivots succeed ~30% of the time at best. New channels reach monetization in ~20% of cases. Use base rates as anchors.
3. **Is my confidence dropping when I think harder?** That's a healthy signal of skepticism kicking in. Trust it.
4. **Am I confusing fluency with truth?** Smooth reasoning ≠ correct reasoning.

---

## When to refuse to give a single recommendation

If the choice is **genuinely close** between 2–3 options (say, all within 10 percentage points of each other), output **all** options with their confidence levels and explicitly state:

> "I can't strongly recommend a single option here. The top contenders are within calibration noise. The deciding factors are <X> and <Y>, which only you can weigh."

This is more honest than picking artificially.

---

## When recommending against the user's stated preference

If the user has expressed a clear preference but the recommendation runs counter to it:

1. State the recommendation against their preference with full confidence calibration
2. Acknowledge their stated preference explicitly
3. State the cost of going with their preference instead
4. Defer the final call to them — do not nag

Example:
> "**Recommendation:** Hold off on launching for 30 more days.
> **Confidence:** ⚠️ 65%
> You've said you want to launch this week. The cost of waiting is 30 days of opportunity. The cost of launching prematurely is [specific risk from Critic output]. If the 30-day delay is unworkable, my fallback is [conditional plan]."

---

## Examples of well-calibrated recommendations

### Good (calibrated)

> **Recommendation:** Run a 4-week pilot of the new pricing tier before rolling it out to the full customer base.
> **Confidence:** ⚠️ 70%
> **Rationale:**
> - Willingness-to-pay at the proposed price point is unverified ⚠️
> - Adjacent product comparables suggest plausibility but not certainty
> - Critic's premortem ranked "churn spike from existing customers" as #1 failure cause (28% likelihood)
> **What would raise to ✅ 85%:** Pilot data showing ≥75% acceptance among the test cohort and no measurable churn lift.
> **What would lower to ⚠️ 45%:** Pilot reveals acceptance below 50% or churn rises by more than 2 percentage points.
> **Alternative if confidence drops:** Introduce the new tier as opt-in for new customers only; grandfather existing customers indefinitely.
> **Reversibility:** Two-way door. Reverting takes one billing cycle; pilot cohort is small.

### Bad (overconfident)

> ❌ "I recommend going ahead with the new pricing — your model is strong and the market will accept it."

The second has no confidence label, no rationale, no test conditions, no reversibility note. It tells the user nothing about how much to trust it.

---

## Anti-patterns

❌ "I'd lean toward X" — too vague, no confidence number
❌ "X is clearly the right choice" — overconfident without basis
❌ Same confidence (e.g., 80%) on every recommendation — calibration is broken
❌ Refusing to recommend at all ("it's up to you") — that's a cop-out unless options are genuinely tied
❌ Confidence higher than the underlying evidence supports
❌ Skipping "what would change my mind" because it's uncomfortable
