#!/usr/bin/env bash
# build-plugin-commands.sh
#
# Regenerate the plugin's slash commands from the repo skills.
#
#   SOURCE OF TRUTH: .claude/skills/<name>/SKILL.md
#   OUTPUT:          distributions/claude-code-plugin/commands/<name>.md
#
# The transform is a PURE function of the skill, so $ARGUMENTS can never be
# dropped: arg-taking skills already contain the `$ARGUMENTS` reference, phrased
# to read correctly both as an auto-invoked skill and as a slash command. The
# build only:
#   1. removes the skill-only `name:` frontmatter key, and
#   2. rewrites bare repo paths (`core/`, `profiles/`, `docs/`) to
#      `${CLAUDE_PLUGIN_ROOT}/...`. Working-directory paths like `context/`
#      are intentionally left bare.
#
# After generating, it runs scripts/check-plugin-commands.sh as a sanity gate.
#
# Usage: bash scripts/build-plugin-commands.sh

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_DIR="$ROOT/.claude/skills"
CMD_DIR="$ROOT/distributions/claude-code-plugin/commands"

mkdir -p "$CMD_DIR"

count=0
for skill in "$SKILL_DIR"/*/SKILL.md; do
  name="$(basename "$(dirname "$skill")")"
  perl -0777 -pe '
    s/^name:[^\n]*\n//m;                                            # 1. drop skill-only name:
    s/`(core|profiles|docs)\//`\${CLAUDE_PLUGIN_ROOT}\/$1\//g;      # 2. prefix repo paths
  ' "$skill" > "$CMD_DIR/$name.md"
  count=$((count + 1))
done
echo "Generated $count command(s) -> ${CMD_DIR#"$ROOT"/}"

echo "Running guard..."
bash "$ROOT/scripts/check-plugin-commands.sh"
