# Example: Same prompt, two sessions — a Hyperliquid crypto wallet

| | |
|---|---|
| **Profile used** | `general` |
| **Real or illustrative** | Real session |
| **Isolation** | **Trace-verified.** The Phase 5 critique ran as a genuine isolated sub-agent (the dispatch trace shows `ran an agent`, not the `TaskCreate` to-do tool). |
| **Depth** | The fullest example in this repo — the methodology session runs the complete arc in one sitting: Phase 1 understanding, sourced Phase 2 landscape research, five strategic variants in Phase 3, a Phase 4 deep dive, and an isolated cold critique in Phase 5. Read this one to see the whole method. |
| **What this shows** | A high-stakes crypto/security domain. Plain Claude hand-rolled a seed vault and shipped a wallet in minutes. The methodology refused, turned a four-product "super-app" wish into a single strategic bet, mapped a crowded field with sources, and let a cold critic return 🔴 NO-GO — because you'd be entering behind a funded incumbent already running your exact thesis. |

> **TL;DR:** Given *"I want to build a crypto wallet for hyperliquid blockchain,"* plain Claude built a working self-custody browser-extension wallet — including its own AES-GCM/PBKDF2 seed vault — with zero questions. The methodology spent five phases establishing that Hyperliquid's native agent-wallet primitive already solves the custody problem, that every pillar of the idea is crowded, and — when the founder insisted on an *open agent marketplace from day one* — an isolated cold critic returned **NO-GO**: you're entering behind Senpi (~$185M, running your exact open-marketplace thesis since January), with an empty-marketplace cold-start as the 70% killer. Same prompt: one made a wallet, the other found the reason not to build this shape.

---

## The prompt (identical in both)

> I want to build a crypto wallet for hyperliquid blockchain.

---

## Session A — Plain Claude (no methodology)

Technically strong, fast, and honest about its limits:
- Searched the web, found the community `@nktkas/hyperliquid` SDK, checked signing docs
- Scaffolded a Manifest V3 extension: TypeScript + React + Vite, `viem` for EIP-712
- **Rolled its own seed vault**: AES-GCM + PBKDF2 (310k iters), `chrome.storage.local` for the encrypted blob, `chrome.storage.session` for the unlocked mnemonic, 15-min auto-lock
- Shipped v0.1 features: create/import seed, lock/unlock, balances, USDC transfer, limit orders
- Was candid: couldn't smoke-test (VM down), listed "Known gaps," cited sources

**Time-to-artifact:** minutes. **Questions asked:** zero. **Custody model, threat model, "why another wallet," competitive reality:** all decided silently.

> 📝 Competent micro-decisions, unexamined macro-decisions. It hand-built the one component where a bug is fatal (seed custody), and shipped a wallet without anyone asking whether the market this wallet targets is already won.

---

## Session B — With idea-to-build

The coordinator ran the full method in one session, **Phases 1 → 5**, and produced no product code.

### Phase 1 — Understanding

It restated the goal, flagged the central tension early, and named the stakes:

> Building a wallet means holding the keys to people's money. The bar for security and the regulatory exposure are both high — "wallet" is one of the least forgiving things to build in crypto.

The founder answered: **tokens + perps + bots (grid) + AI trading agents; MetaMask-like (non-custodial); both app and extension; motivation — "$HYPE is on hype."** The coordinator pushed back once, clearly:

> This is not one product — it's four, each hard on its own (a non-custodial wallet, a perps client, a bot engine, AI trading agents). And **"because $HYPE is hyped" is a timing thesis, not a product thesis** — hype is why a market exists, not why your product wins in it.

Founder chose **full scope**. The coordinator locked it and carried the custody-vs-automation tension forward.

### Phase 2 — Context (sourced research)

> ✅ The custody problem is mostly solved *for* you: Hyperliquid has a native **agent/API-wallet primitive** — a permissioned signer that can place/cancel orders but **cannot withdraw**. Bots and agents trade through it while the user keeps the master key.
> ✅ But every pillar is crowded: wallets (OneKey, Gem, Bitget, plus Hyperliquid's own app), bots (goodcryptoX, Hummingbot, WunderTrading…), and AI agents — the hottest, most contested space, where **Senpi** claims the "first personal trading agents for Hyperliquid" (~$100M+ volume, ⚠️ self-reported).
> Plausible wedge (⚠️ hypothesis): no one unifies all four behind one key/UI. But an integration play in a hyped market is a thesis to test, not a guarantee.

### Phase 3 — Generation (five distinct bets)

Command-center wallet · agent-first · open dev rails · distribution wedge · strategy marketplace — each a *theory of why you survive*, not a feature list, with a trade matrix. Founder chose the **all-in-one super-app wallet** (consolidation bet).

### Phase 4 — Deep Dive

> One non-custodial master key fans out into purpose-scoped, trade-only agent wallets — that's why a small team can build it (orchestrating native primitives, not reinventing custody). But bots/agents must run 24/7, so **a server holds the trade-only key**. Funds stay non-custodial; trading authority does not. ⚠️ **"Non-custodial" applies to funds, not trading authority — don't blur that in marketing; it's exactly the kind of thing that detonates trust later.**

Pushed to pick *one* killer feature, the founder chose **an agent marketplace inside the wallet**. The coordinator pushed back once — a two-sided marketplace has a brutal cold-start — and recommended seeding the supply side first-party. The founder chose **open marketplace from day one**. The coordinator pushed once more, respected the override, and carried *"third-party creators will show up at launch"* into the critique as the load-bearing, unprotected assumption.

### Phase 5 — Critique (isolated agent — `ran an agent`, trace-verified) → 🔴 NO-GO

> **Verdict: 🔴 NO-GO.** And it surfaced a fact that updated the picture: ✅ **Senpi is reportedly at ~$185M volume and the fastest-growing Hyperliquid consumer app — already running your exact thesis (open agent marketplace + non-custodial agent trading) since January.** You're not early; you're entering behind a funded incumbent with the supply-side network you don't have.
>
> Premortem: (70%) **empty marketplace at launch** — "open from day one" with no creator network means users see a handful of unaudited, track-record-less strategies and leave; (65%) a subscribed third-party agent blows up someone's funds through your operated infrastructure — "non-custodial" stops mattering to the user who lost money, and the liability is yours; (60%, fundamental) simply outrun by Senpi.
>
> **Steelman (one line worth repeating):** *"You've confused a feature list with a wedge, and the one piece that's actually differentiated — the open marketplace — is the piece you're least equipped to deliver."*

Per the method, a NO-GO sends the work back to Phase 3 to reframe — not forward to a plan built on a cracked foundation. The coordinator recommended a narrow, seeded wedge (operate a few audited flagship agents with public track records first, open publishing later) and named three things to verify before any reframe: Senpi's actual creator retention, app-store policy on automated-trading agents, and legal exposure when a delegated agent loses user funds.

> 📝 **What the methodology caught that the fast build couldn't:** that this is four products, not one; that the custody problem is already a solved native primitive (so it's not the moat); that "non-custodial" honestly applies to funds, not trading authority — the exact thing plain Claude's "non-custodial wallet" glossed; and, via the cold critic's own research, that the one differentiated pillar is already owned by a funded incumbent. It pushed back at every fork, respected the founder's overrides, and let an isolated agent — immune to the conversation's momentum — deliver the verdict.

---

## Takeaway

This is the fullest demonstration of the method, and the isolation is real — the Phase 5 critic ran as a genuine sub-agent (trace-verified), did its own research, and came back harsher than the in-session momentum would have allowed.

Plain Claude shipped a wallet that *looks* done — and hand-built the seed vault, the one place a bug is fatal — for a product shape an independent critic showed is already lost: a four-pillar super-app whose single differentiated piece (an open marketplace) is owned by Senpi and is the piece a small team is least able to deliver.

- **Plain Claude** is the right tool once the strategy is settled and a wrong guess is cheap.
- **The methodology** earns its time when a confident wrong move is expensive — and "build a four-product crypto super-app, behind a funded incumbent, during a hype cycle" is about as expensive as wrong moves get.

The fast path gave you a wallet. The slow path told you the wallet you described enters behind Senpi with its only moat being the thing you can't yet build — and pointed at the narrower wedge that might survive.

---

> ⚠️ **On the numbers:** the agent-wallet primitive details, the competitor list, and Senpi's volume (~$100M+ / ~$185M) come from the session's own web research (sources cited in-session). They're reproduced here as the critique's inputs, not independently re-verified for this document — and the critic itself flagged Senpi's figures as self-reported. Exactly the kind of claim the methodology labels rather than asserts.
