---
description: Apply the idea-to-build verification protocol (Tier 1/2/3, Skeptical-by-Default) to a specific claim. Use when the user types "/factcheck" followed by a claim, or asks to verify, fact-check, or pressure-test a specific statement.
---

# /factcheck — verify a claim (Skeptical-by-Default)

1. Read `${CLAUDE_PLUGIN_ROOT}/core/CLAUDE.md` (the Factual Rigor / Tier 1/2/3 protocol and the Skeptical-by-Default stance).
2. The claim to verify is whatever the user provided after `/factcheck` (as a slash command, that's `$ARGUMENTS`). If it's empty, ask which claim to check. Then classify it:
   - **Tier 1** — logic, math on given numbers, fundamental concepts → assert directly.
   - **Tier 2** — tool details, "best practices", memory-based claims below ~90% confidence → mark ⚠️ and verify when possible.
   - **Tier 3** — market sizes, prices, competitor data, current platform policies, recent news, anything that could have changed in the last 6–18 months → **search before stating.**
3. For Tier 3, search first, then cite the source (title + year, URL if available).
4. Label the verdict: ✅ verified / ⚠️ hypothesis / 🔍 needs verification. If no reliable source exists, say so plainly — never fabricate.
5. If the claim is false or shaky, say so directly and name exactly what would confirm or refute it.
