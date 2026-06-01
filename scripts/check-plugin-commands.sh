#!/usr/bin/env bash
# check-plugin-commands.sh
#
# Guard for the Claude Code plugin's slash commands.
#
# WHY THIS EXISTS
#   distributions/claude-code-plugin/commands/*.md are HAND-MAINTAINED.
#   They are NOT a pure copy of .claude/skills/*/SKILL.md. Each command differs
#   from its skill in three ways a naive "regenerate from skills" gets wrong:
#     1. the skill's `name:` frontmatter is removed,
#     2. repo paths (core/, profiles/, docs/) are rewritten to
#        ${CLAUDE_PLUGIN_ROOT}/...,
#     3. arg-taking commands add explicit `$ARGUMENTS` handling that the skill
#        (auto-invoked, reads "the user's message") never contains.
#   An ad-hoc regen once silently dropped `$ARGUMENTS` from factcheck/phase/
#   profile, breaking their arguments. This script fails loudly if that
#   regression — or the other two packaging mistakes — reappears.
#
# Run it before packaging or cutting a release:
#   bash scripts/check-plugin-commands.sh

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CMD_DIR="$ROOT/distributions/claude-code-plugin/commands"
SKILL_DIR="$ROOT/.claude/skills"

# Commands that accept typed input after the slash and therefore MUST use
# $ARGUMENTS. Add a command name here when you give it arguments.
ARG_COMMANDS="factcheck phase profile"

fail=0
err() { echo "  x $*"; fail=1; }

echo "Checking plugin commands in ${CMD_DIR#"$ROOT"/}"

# 0. command set must match skill set (catch a forgotten add/remove)
cmds="$(cd "$CMD_DIR" && ls ./*.md | sed 's:.*/::; s/\.md$//' | sort | tr '\n' ' ')"
skills="$(cd "$SKILL_DIR" && ls -d ./*/ | sed 's:.*/\([^/]*\)/$:\1:' | sort | tr '\n' ' ')"
if [ "$cmds" != "$skills" ]; then
  err "command set != skill set"
  echo "      commands: $cmds"
  echo "      skills:   $skills"
fi

for f in "$CMD_DIR"/*.md; do
  name="$(basename "$f" .md)"

  # 1. no leftover skill `name:` frontmatter
  if grep -q '^name:' "$f"; then err "$name: leftover 'name:' frontmatter (skill-only)"; fi

  # 2. must keep a description frontmatter
  if ! grep -q '^description:' "$f"; then err "$name: missing 'description:' frontmatter"; fi

  # 3. no bare repo paths — must be prefixed with \${CLAUDE_PLUGIN_ROOT}/
  if grep -qE '`(core|profiles|docs)/' "$f"; then
    err "$name: bare repo path — use \${CLAUDE_PLUGIN_ROOT}/..."
  fi
done

# 4. arg-taking commands must reference $ARGUMENTS
for name in $ARG_COMMANDS; do
  f="$CMD_DIR/$name.md"
  if [ ! -f "$f" ]; then err "$name: expected arg-command file is missing"; continue; fi
  if ! grep -q 'ARGUMENTS' "$f"; then err "$name: arg-command missing \$ARGUMENTS handling"; fi
done

if [ "$fail" -ne 0 ]; then
  echo "FAILED - fix the above before packaging the plugin."
  exit 1
fi
echo "OK - $(echo "$cmds" | wc -w | tr -d ' ') commands well-formed; arg-commands keep \$ARGUMENTS."
