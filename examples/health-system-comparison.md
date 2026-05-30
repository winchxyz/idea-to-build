# Example: Same prompt, two sessions — a personal-health-AI idea

| | |
|---|---|
| **Profile used** | `general` (startup-flavored questioning emerged naturally) |
| **Real or illustrative** | Real session |
| **What this shows** | A harder case than the [stickman example](stickman-comparison.md). Here plain Claude was *already competent* — it scoped, checked connectors, added safety rules. The methodology still pulled clearly ahead, on a different axis: it questioned *what to build and for whom*, not just *how*. |

> **TL;DR:** Given an ambitious "personal health system powered by Claude" idea, plain Claude built a 15-file foundation in minutes — thoughtfully. The methodology refused to build anything, spent all of Phase 1 turning a sprawling platform into a single beachhead, caught a hard architectural blocker (Apple Health can't reach a Telegram Mini-app) and a regulatory risk, and saved the decisions to memory. When the plain output is good, the methodology's value shows up as *strategy*, not *speed*.

---

## The prompt (identical in both)

> I want to build a personal health system powered by Claude that deeply understands my context — my diet, training, lab results, and daily metrics — learns over time, backs its suggestions with relevant scientific papers (tracking new PubMed publications), pulls in my Apple Watch data (sleep, activity, calories), and surfaces hidden correlations and improvements I wouldn't spot myself.

---

## Session A — Plain Claude (no methodology)

This was *not* a naive build. The plain session:
- Checked the MCP connector registry for Apple Health / PubMed / storage connectors
- Presented four upfront decisions (foundation-first, local folder, Health Auto Export, fresh start)
- When the folder picker was cancelled and the workspace VM was down, **built anyway** — a 15-file `health-system/` foundation: `SYSTEM.md` operating manual, `memory/` (profile, insights, decisions-log), `data/` intake templates, `research/` PubMed watchlist, `setup/` guides
- Included safety rules, and deliberately deferred the correlation engine "until real data exists"
- Closed by offering to wire up a weekly PubMed tracker

**Time-to-artifact:** minutes. **Questions asked:** yes, but tactical — *how* to build, not *whether* or *for whom*. **Framing:** "build me this system."

> 📝 Genuinely good output for "set me up." The structural blind spot: it treated a startup-sized, regulation-adjacent, multi-subsystem idea as a folder to scaffold. Nobody asked who it's for, whether the riskiest piece is safe, or what the smallest winning version is.

---

## Session B — With idea-to-build

The coordinator never wrote a product file. It spent the entire exchange in **Phase 1 — Understanding**, and it earned the time.

### Opening: restate, then scope

> **Here's what I understand you want:** …an evolving advisor that gets sharper over time. Before I map the landscape, I want to confirm scope, because "build" could mean three very different projects:
> 1. **Personal setup for you alone** — config + prompts, fast and fragile
> 2. **A software product/app** — real pipeline, storage, UI
> 3. **A startup/commercial product** — the above + market + regulatory exposure

And immediately flagged the riskiest assumption:

> ⚠️ *The "tracks new PubMed papers and personalizes recommendations" piece is the hardest and riskiest part — turning fresh literature into safe, individualized advice is exactly where systems over-claim or generate noise. We'll stress-test it in Critique.*

### User answers → tightened statement → the make-or-break question

User: *for users · app or Telegram Mini-app · potential startup.*

The coordinator restated a tightened problem statement, then drove on the one thing that matters most for a startup:

> The critical one is **the wedge** — "diet + training + labs + wearables + literature for all users" is a *platform, not a wedge*, and platforms are extremely hard to launch cold. Who is the first user you're obsessed with, and what single outcome do you want to nail for them?

…while carrying forward two risks it refused to hand-wave:

> ⚠️ **Apple Watch / Apple Health data does not flow cleanly to a Telegram Mini-app** — Health is locked to iOS/HealthKit. A Mini-app almost certainly can't read it directly; you'd need a companion iOS app or an export bridge. This is an architectural constraint, not a detail. 🔍 *Will verify in Phase 2.*
>
> ⚠️ **Personalized recommendations from new papers puts you near regulated-medical-advice territory.** The further from "wellness/insights" toward "do X for your condition," the more legal/safety exposure.

### Narrowing the beachhead (the user asked to sharpen before advancing)

The coordinator laid out five criteria a good beachhead must hit (rich structured data on day one, intense pain, willingness to pay, cheap reach, values evidence), then scored four candidate segments — strength/physique, endurance, longevity/biohackers, body-recomp — against them.

User committed to **longevity / biohackers.** The coordinator then *corrected its own earlier hypothesis* (it had leaned strength/physique):

> Good choice — more defensible than my hypothesis gave it credit for. They pull frequent lab panels, track obsessively, and value PubMed-grade evidence. The "monitor new papers + surface correlations" engine is **a vitamin for most segments but a painkiller here.** WTP is highest of the four.
>
> The risk I'll keep on the board: this crowd is the most credulous and most exposed to over-claiming. Your edge — and safety moat — is being the rigorous, skeptical voice in a hype-filled space. Your ✅/⚠️/🔍 labeling could *be the product's brand.*

It saved the locked problem statement, the beachhead, and three open hypotheses to `context/health-os.md` — so the next session resumes instead of restarting.

> 📝 **What the methodology caught that the fast build couldn't:** that this is a startup-scope decision, not a scaffolding task; that "everyone health-conscious" is not a beachhead; a concrete architectural blocker (HealthKit → Telegram); a regulatory exposure; and a positioning insight (evidence-labeling as moat). It also self-corrected and persisted state to memory.

---

## Takeaway

Compared to the stickman example, this is the more honest stress test — because **plain Claude was already good here.** It scoped, it added safety, it deferred wisely.

The methodology still pulled ahead, but on a different axis. The plain session optimized *"build the thing well."* The methodology asked *"is this the right thing, for whom, and what will kill it"* — and produced a locked beachhead, two named risks, and persistent memory instead of 15 files you might have to throw away once you realize a Telegram Mini-app can't read Apple Health.

- **Plain Claude** wins on time-to-artifact and is the right tool once the *what* is settled.
- **The methodology** wins when the expensive mistake is building the wrong thing confidently — which is most of what startups actually die from.

The fast path gave you a folder. The slow path gave you a strategy — and stopped you from shipping into an architectural wall.
