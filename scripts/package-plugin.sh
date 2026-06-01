#!/usr/bin/env bash
# package-plugin.sh — build a release-ready idea-to-build-plugin.zip
#
# Produces a STANDARD zip (PK / deflate) with forward-slash entries, valid for
# BOTH Windows Explorer and the Cowork "Create plugin -> Upload plugin" path.
#
# !!! DO NOT build this with `tar -a -c -f x.zip` !!!
#   The tar in this environment is GNU tar, which IGNORES the .zip extension and
#   writes a *tar* archive with a .zip name. Windows then reports the download as
#   "invalid" and Cowork can't read it. (This actually shipped once in v0.3.0.)
#   We build the zip with Python's zipfile, which is portable and correct.
#
# It first regenerates the commands (scripts/build-plugin-commands.sh, which runs
# the guard), so the packaged plugin is always current and well-formed.
#
# Usage: bash scripts/package-plugin.sh [output.zip]
#   then: gh release upload <tag> <output.zip> --clobber

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN="$ROOT/distributions/claude-code-plugin"
OUT="${1:-$ROOT/idea-to-build-plugin.zip}"

bash "$ROOT/scripts/build-plugin-commands.sh"

rm -f "$OUT"
python - "$PLUGIN" "$OUT" <<'PY'
import zipfile, os, sys
plugin, out = sys.argv[1], sys.argv[2]
dirs = ['.claude-plugin', 'commands', 'core', 'docs', 'profiles']
n = 0
with zipfile.ZipFile(out, 'w', zipfile.ZIP_DEFLATED) as z:
    for d in dirs:
        for dp, _, files in os.walk(os.path.join(plugin, d)):
            for fn in sorted(files):
                full = os.path.join(dp, fn)
                arc = os.path.relpath(full, plugin).replace(os.sep, '/')
                z.write(full, arc)
                n += 1
with zipfile.ZipFile(out) as z:
    bad = z.testzip()
    assert bad is None, f"corrupt entry: {bad}"
    assert any(name == '.claude-plugin/plugin.json' for name in z.namelist()), \
        "plugin.json missing from zip root"
print(f"packaged {n} files")
PY

# magic bytes must be PK (a real zip, not a tar-in-disguise)
if [ "$(head -c 2 "$OUT")" != "PK" ]; then
  echo "ERROR: $OUT is not a zip (bad magic) — did something use GNU tar?" >&2
  exit 1
fi

echo "OK - valid zip at: $OUT"
echo "Upload with: gh release upload <tag> \"$OUT\" --clobber"
