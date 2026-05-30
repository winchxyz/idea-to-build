---
name: recommend
description: Produce a structured idea-to-build recommendation with calibrated confidence. Use when the user types "/recommend" or asks for a calibrated recommendation / your honest call.
---

# /recommend — calibrated recommendation

1. Read `core/CLAUDE.md` and `core/skills/recommendation-confidence.md`.
2. Produce a recommendation that follows that skill exactly:
   - the call (what you'd do),
   - a **confidence percentage**,
   - what would **raise or lower** that confidence,
   - the **alternative** if confidence drops.
3. No false certainty. Label material claims ✅ verified / ⚠️ hypothesis / 🔍 needs verification.
