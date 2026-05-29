# Example: Same prompt, two sessions — a Hyperliquid crypto wallet

| | |
|---|---|
| **Profile used** | `general` |
| **Real or illustrative** | Real session |
| **Depth** | The fullest example in this repo — the methodology session runs **all the way through Phase 5 (isolated Critique)**, including landscape research with sources, four strategic variants, a deep dive, and a cold premortem. Read this one to see the whole method, not just Phase 1. |
| **What this shows** | A high-stakes, security-and-money domain. Plain Claude hand-rolled a seed-phrase vault and shipped a 13-file wallet in minutes. The methodology flagged *building crypto key storage yourself* as "a single bug ends the company," demanded an external audit as a hard gate, and surfaced an architectural contradiction the fast build never noticed. |

> **TL;DR:** Given *"I want to build a crypto wallet for the Hyperliquid blockchain,"* plain Claude built a working self-custody browser-extension wallet — including its own AES-GCM/PBKDF2 seed vault — without a single question. The methodology refused to build, established that the user actually wanted a wallet + trading terminal + bot platform (which a browser extension *architecturally cannot run*), mapped the funded-competitor landscape with sources, generated four strategic shapes, and ran an isolated critic that returned a conditional GO with five kill-conditions. Same prompt. One produced code; the other produced a company strategy — and caught the thing that ends crypto startups.

---

## The prompt (identical in both)

> I want to build a crypto wallet for the Hyperliquid blockchain.

---

## Session A — Plain Claude (no methodology)

Technically strong, fast, and honest about its limits:
- Searched the web, found the community `@nktkas/hyperliquid` SDK, checked signing docs
- Scaffolded a Manifest V3 extension: TypeScript + React + Vite, `viem` for EIP-712
- **Rolled its own seed vault**: AES-GCM + PBKDF2 (310k iters), `chrome.storage.local` for the encrypted blob, `chrome.storage.session` for the unlocked mnemonic, 15-min auto-lock
- Shipped v0.1 features: create/import seed, lock/unlock, balances, USDC transfer, limit orders
- Was candid: couldn't smoke-test (VM down), listed "Known gaps," cited sources

**Time-to-artifact:** minutes. **Questions asked:** zero. **Custody model, threat model, "why another wallet," regulatory exposure:** all decided silently.

> 📝 Competent micro-decisions, unexamined macro-decisions. It chose self-custody with the seed in browser storage — a notorious attack surface — and hand-built the one component where a bug is fatal, without anyone deciding that was the plan.

---

## Session B — With idea-to-brainstorm

The coordinator ran **Phases 1 → 5**. Condensed, with the load-bearing moments intact.

### Phase 1 — Understanding

Opened with a restatement, then immediately separated what it knew from what it had to verify:

> ⚠️ Hyperliquid runs two environments — HyperCore (the L1 perps DEX) and HyperEVM. A "wallet" means different things depending on the surface.
> 🔍 MetaMask/Rabby/Phantom already work with HyperEVM, and the HL app uses an "agent wallet" model. So "building a wallet" competes against a crowded field unless you have a sharp wedge.

It asked the make-or-break questions: *what kind of wallet, who for, and which custody model.* User answered: **best-UX product with DCA/grid bots built in, for active traders, MetaMask-style self-custody.** The coordinator then caught the contradiction the plain build walked straight past:

> **You are not describing a wallet. You're describing a wallet + a trading terminal + a bot platform in one extension.** ⚠️ Those fight architecturally: a browser extension *cannot* reliably run a grid bot — Chrome suspends background workers and a powered-off machine kills the strategy. Realistic path: a server runs strategies via a Hyperliquid **agent key** (can trade, *cannot* withdraw, user-revocable). Your seed never leaves the extension; the server only holds a permissioned key. That's an honest product story — not pure "MetaMask-style self-custody."

### Phase 2 — Context (research, with sources)

> No player owns the bundle you want. ✅ Phantom shipped HL perps and did ~$1.8B in 16 days (distribution threat). Hyperdash/Insilico own terminal mindshare but ship no DCA/grid. goodcryptoX/WunderTrading do bots but are custodial-API-key SaaS, not wallets, not HL-native. **Nobody ships wallet + alerts + DCA + grid + HL-native as one product — the bundle is genuinely uncovered.** But the window is tight: Based raised $11.5M from Pantera to build an HL "SuperApp." *(sources cited: The Block, Blockworks, HL docs)*

### Phase 3 — Generation (four strategic shapes, not features)

A: wallet-first (bots in v2) · B: bot-first integrated bundle · C: wallet-as-a-service SDK · D: custody-agnostic pro terminal — each with pros/cons, a speed-to-market estimate, and a trade matrix (speed / defensibility / Phantom-exposure / capital efficiency / investor story). User chose **A→B** (ship wallet in ~3 mo, add the bundle by ~mo 9).

### Phase 4 — Deep Dive (where the security contrast lands)

> ⚠️ **Do not build seed-phrase storage and EIP-712 signing from scratch.** Use Turnkey or Privy for the signing primitives. You will not out-engineer their security teams, and **a single bug here ends the company.** This is non-negotiable.
>
> **Security gate before launch:** internal threat model + external audit — realistically 4–6 weeks, $40k–$120k. Bake it into the timeline: feature-freeze at week 8, not week 12. *Skip the audit and you're not shipping a wallet, you're shipping a liability.*

> 📝 **This is the headline contrast.** Plain Claude *did the exact thing this phase forbids* — hand-rolled the seed vault and shipped it unaudited. Same idea, opposite instinct: the fast path treated key storage as a coding task; the methodology treated it as the bet-the-company decision it is.

### Phase 5 — Critique (isolated sub-agent — premortem, returned cold)

The critic ran with no conversation context. Verbatim shape of what came back:

- **Premortem (top causes of death by May 2027):** 35% Phantom ships agent-wallet UX + bots first; 20% Phase A ships but gets <5k MAU (no distribution wedge); 15% Phase B slips to month 14+ eating runway; 12% a bot loses user money and the trust story collapses in one viral thread; 10% HL changes agent-wallet/builder-code economics.
- **What Needs to Be True:** ⚠️ traders are dissatisfied enough to *switch wallets* (no evidence — hypothesis only); ⚠️ they'll pay $15–40/mo where cheaper bots exist; 🔍 browser extension is the right form factor (Phantom won mobile); ✅ the agent-wallet protocol supports the architecture.
- **Steelman against you:** "The wallet isn't the moat (Phantom has 1.8B reasons), the bots aren't the moat (every SaaS vendor is a weekend from parity). The only moat is a *trust* moat — 'your keys, your bot' — and trust moats take 18 months and zero incidents. By then Phantom or Based ships 70% of the UX with 100% of the distribution."
- **Verdict: 🟡 GO with conditions** — proceed only with all five: 20+ interviews with active HL traders in weeks 1–3 (kill the wedge if <8 would switch); a concrete non-product distribution wedge by week 4; week-8 feature-freeze as a hard gate; crypto regulatory counsel before any Phase-B server code; a quantitative A→B kill criterion. *Any one deferred → flips to 🔴 NO-GO.*

---

## Takeaway

This is the example where "the methodology is slower" stops being a cost and becomes the entire point.

Plain Claude shipped a wallet that *looks* done — and hand-built the single component (seed-phrase custody) where being 99% right still ends the company. It never asked who the wallet is for, never noticed that the bots the user asked for can't run in an extension, and never mentioned an audit.

The methodology produced no code. It produced: a corrected architecture (server-side bots via revocable agent keys), a sourced competitive map, four strategic options, a "use audited primitives, don't roll your own" mandate, and a cold critique with a kill-switch-equipped GO. That is the difference between *a thing you can run* and *a decision you can bet a company on.*

- **Plain Claude** is the right tool once the strategy is settled and the stakes of a wrong guess are low.
- **The methodology** earns its time precisely when a confident wrong move is expensive — and in crypto, "confident and wrong about key storage" is the most expensive move there is.

The fast path gave you a wallet. The slow path told you not to build the wallet that way — and what would kill the company if you did.
