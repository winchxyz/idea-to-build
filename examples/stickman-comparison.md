# Example: Same prompt, two sessions — plain Claude vs. idea-to-build

| | |
|---|---|
| **Profile used** | `general` |
| **Real or illustrative** | Real session |
| **What this shows** | The same one-line idea, run two ways. Plain Claude builds immediately. The methodology refuses to build until the scope is real — and catches three things the fast build silently assumed away. |

> **TL;DR:** Given *"I want to build a stickman unlimited levels game with motion graphics,"* plain Claude shipped a playable game in seconds with zero questions. The methodology spent Phase 1 surfacing that "unlimited levels," "motion graphics," and "Broforce-style" each hide a hard design problem — and that a portfolio piece wants tight polish, not scope. Neither is "wrong"; they're tools for different jobs.

---

## The prompt (identical in both)

> I want to build a stickman unlimited levels game with motion graphics.

---

## Session A — Plain Claude (no methodology)

One prompt in, the assistant auto-planned (*Design game architecture → Build HTML game file → Test in browser*) and shipped a single self-contained file, `stickman-fighter.html`, with no clarifying questions.

What it produced, in one shot:
- Skeletal stickman animation (limbs from joint angles; run/jump/punch/kick/uppercut/block/hurt all interpolate)
- Motion graphics: screen shake, particle sparks, landing dust, swoosh arcs, speed lines, floating damage numbers, dash trail
- "Unlimited levels": enemy count + HP scale per level, bosses every 5th level, +25 HP between levels
- AI enemies that chase and attack on cooldown; ragdoll on death
- Controls: A/D move, W jump, J punch, K kick, L uppercut, Shift dash, Space block

**Time-to-artifact:** seconds. **Questions asked:** zero. **Scope decisions made silently:** all of them.

> 📝 For a throwaway "build me something fun" request, this is genuinely a good outcome — fast and dense with features. The cost is invisible: every ambiguity got resolved by the model's guess, not your intent.

---

## Session B — With idea-to-build

### Coordinator — Phase 1 (opening)

> **Here's what I understand you want:** a game with a stickman protagonist, endlessly extending levels (no fixed ending), and "motion graphics" as a core aesthetic. Before I commit to that read, I want to push back — because each ambiguity changes the entire project.

It then laid out that the phrasing maps to **three very different products**:

1. **Endless runner** — one continuous procedural level (Stick Hero, Run 3)
2. **Discrete level generator** — infinite distinct levels with goals/exits (Stick War, Vex)
3. **User-generated levels** — "unlimited" because players/AI keep creating them (Geometry Dash)

…and that *"motion graphics"* could mean stylized cutscenes, kinetic-vector gameplay, or just smooth tweened animation — each a different art pipeline.

**Five questions before advancing**, covering game type, platform/scope, who's building it + skill level, *why* (portfolio vs commercial vs learning), and a concrete motion-graphics reference.

> 📝 **This is the fix in action:** Phase 1 leads with a restatement of intent *before* interrogating. It doesn't feel like a blind questionnaire — it shows what it already understood, then asks only to close real gaps.

### User's answers

> 1) Kind of Broforce gameplay style
> 2) Let's start with web
> 3) Solo + AI (Claude Code)
> 4) Portfolio piece
> 5) Stick graphics, minimalistic, no 3D

### Coordinator — Phase 1 (restate + critique)

> **Restated scope:** a browser-playable 2D stickman run-and-gun platformer in the Broforce mold — fast action, multiple weapons, destructible terrain, explosions — but minimalist stick-figure art. "Unlimited levels" = procedural generation. Built solo with Claude Code. Goal: a shipped, playable portfolio piece a recruiter can open and immediately play.

Then **three pushbacks**, each labeled by confidence:

- **Broforce-like is one of the harder genres to clone.** Its feel comes from per-pixel destructible terrain, chained explosion cascades, and tight weapon feedback — all individually hard. Stick figures don't reduce that. Either pick which system to nail and fake the rest, or pick a lighter cousin (Super Crate Box, Downwell). ⚠️ *Hypothesis from genre knowledge — would verify against solo-dev Broforce clones that shipped.*
- **"Unlimited levels" + "Broforce-style" is a known-hard combo.** Broforce itself used hand-crafted levels; the devs said procedural didn't feel designed. Shippable version: hand-designed chunks stitched procedurally, or a roguelike room generator (Nuclear Throne). 🔍 *Worth researching in Phase 2.*
- **For a portfolio piece, polish on a small core loop beats ambitious-but-unfinished.** A recruiter plays for 90 seconds and needs to *feel* something tight, not see scope. Strongest version might be 2-minute roguelike runs, not literal "unlimited levels."

It closed with a clear choice: commit on three remaining decisions (procedural model, tech stack, time budget) **or** say *"proceed with your recommendations"* and it advances to Phase 2 with sensible defaults.

> 📝 **What the methodology caught that the fast build buried:** that "unlimited levels" is an open design problem, not a feature flag; that the Broforce feel survives the art swap and stays expensive; and that the stated goal (portfolio) argues *against* the stated scope (unlimited). The plain session silently picked answers to all three.

---

## Takeaway

This isn't "the methodology builds a better game." Plain Claude's game was good. The difference is **what gets decided, and by whom.**

- **Reach for plain Claude** when the cost of a wrong guess is low — prototypes, throwaways, "just show me something."
- **Reach for the methodology** when a wrong guess is expensive — when scope, time, or the actual goal are on the line, and building the wrong thing fast is worse than building the right thing deliberately.

The stickman prompt looked trivial. Phase 1 alone showed it wasn't.
