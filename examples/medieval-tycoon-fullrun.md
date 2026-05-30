# Example: A full run, idea → buildable plan (2D medieval tycoon game)

| | |
|---|---|
| **Profile used** | `general` |
| **Real or illustrative** | Real session |
| **What this shows** | The **whole method, start to finish** — Phase 1 through Phase 6, then `/scaffold`. Unlike the "can it say no?" examples, this idea *survives*: it gets scoped, researched, critiqued (🟡 GO with conditions, not NO-GO), planned with a kill-switch, and handed off as a ready-to-build folder. This is the normal path — an idea, honestly stress-tested, turned into something you can actually build. |

> **TL;DR:** "I want to build a 2D medieval tycoon game" → the method didn't reject it. It narrowed "town builder" down to a beginner-shippable shape, picked Godot with reasons, generated five small-scope variants, and when the founder chose an idle game "because Claude Code will help," it pushed back that the hard 80% is *balancing*, not code. A cold critic returned **GO with conditions**; an isolated planner produced a 4-week finish-ability pilot + a 90-day plan + a quantitative kill-switch; and `/scaffold` wrote a buildable briefing folder. The critique is the means; **a plan you can build is the end.**

---

## The prompt

> I want to build a 2D medieval tycoon game.

---

## The run, phase by phase

**Phase 1 — Understanding.** Restated the goal, then flagged the real risk: *"'beginner' + 'ship it' + 'village builder' is the hardest combination"* — town builders hide pathfinding, production chains, economy balancing. Reframed the whole session around one constraint: *what's the smallest version that's still fun and shippable by a beginner?* The founder confirmed, adding "I'll ship it with Claude Code." The coordinator calibrated honestly: *"AI accelerates typing code; it doesn't decide what game to make or whether the loop is fun."*

**Phase 2 — Context (sourced).** Mapped the genre: Foundation, City Tales – Medieval Era, Songs of Syx, plus itch.io's long tail. The lesson: *"the market rewards depth or a sharp hook, not 'generic medieval town builder #400' — and a beginner can't out-depth Songs of Syx, so your edge is a hook or a constraint, not scope."* Recommended **Godot/GDScript** with reasons (free, 2D-first, AI-readable), flagged the one caveat (less training data than Unity/C#) for the user to watch.

**Phase 3 — Generation.** Five deliberately small-scope variants, each deleting a category of hard work: One-Screen Hamlet, Seasons Survival (turn-based, fixed ending), One Road Town (1D layout, no pathfinding), Single-Resource Specialist, Idle Village. The founder chose **Idle Village**.

**Phase 4 — Deep Dive.** Pushed back once: *"the thing that makes or breaks an idle game isn't the code — it's the shape of the curve, and that's a taste-and-playtesting problem Claude Code can't hand you."* The founder accepted a **finish line** (a Cathedral capstone) as the v1 target. Grounded the curve math in idle-design sources (cost ×1.15 / output ×1.10 / prestige exponent 0.5–0.8) and explicitly designed out pathfinding, production chains, and procedural maps.

**Phase 5 — Critique (isolated cold critic) → 🟡 GO with conditions.** The premortem named *"no deadline"* as the murder weapon (55% burnout/never-ships), flagged the un-tuned economy (the fun is invisible), and warned that AI-generated save/offline/big-number code "looks plausible but fails at the edges." Steelman: *"you entered a genre whose appeal is mathematical pacing and a long tail — as a beginner who deferred the math and capped the tail."* Five conditions, chief among them: **model the economy in a spreadsheet first**, and **set a hard deadline**. Sharpest advice: ship a 2-building vertical slice in a few weeks — if that doesn't get finished, the full game won't.

**Phase 6 — Plan (isolated planner).** A 4-week "Finish-ability Gate" pilot (spreadsheet + 2-building slice with working save/offline/BigNumber, 5 binary pass-checks), a front-loaded 90-day sequence, concrete risk mitigations, a quantitative green-light kill-switch (≥100 wishlists, no unlock gap > ~2h, slice done), a ~$115 budget, and a $0 first action: *build the Farm cost curve in a spreadsheet and ask whether the wait feels like a game or a chore.*

**`/scaffold`.** Gate satisfied (Phases 5–6 done). Wrote a `medieval-village-tycoon/` folder with four briefing files — `CLAUDE.md` (chosen approach, frozen scope, "do not re-propose" list, risks, build order), `README.md`, `DECISIONS.md`, `PLAN.md` — and **no game code**. Open it in Claude Code and it starts building against the brief.

---

## Takeaway

Most of the other examples here end in NO-GO, which can make the method look like a rejection machine. It isn't. **The point is not to kill ideas — it's to make an idea survive contact with reality.** Here the idea lived: it came in as a vague "medieval tycoon game" and left as a scoped, genre-aware, critiqued concept with a finish line, a deadline, a kill-switch, a $0 first move, and a buildable briefing folder.

NO-GO is one honest outcome (when the evidence demands it). **GO-with-conditions → a plan you can build is the other — and the more common one.** That's the whole loop: bring an idea, brainstorm it honestly, and walk out with something you can actually ship.
