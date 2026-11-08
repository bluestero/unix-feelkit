#!/usr/bin/env bash
# Tries dash2dock.patch against a Dash2Dock release and says, per hunk, whether it applies.
#   check-patch.sh            the newest release for this GNOME, downloaded from extensions.gnome.org
#   check-patch.sh <dir|zip>  an unpacked extension folder or its zip (e.g. an older release)
# Exit 0: every hunk applies or is already in the release. Exit 1: some fail (refresh the patch).
# A hunk marked "already in": the release has the change, so drop it from the patch.
set -uo pipefail
here="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
uuid="dash2dock-lite@icedman.github.com"
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT

src=${1:-}
if [[ -z $src ]]; then
  ver=$(gnome-shell --version | grep -oE '[0-9]+' | head -1)
  url=$(curl -fsS "https://extensions.gnome.org/extension-info/?uuid=$uuid&shell_version=$ver" |
    python3 -Ic 'import json,sys; print(json.load(sys.stdin)["download_url"])') || { echo "✗ can't reach extensions.gnome.org"; exit 2; }
  curl -fsSL -o "$tmp/r.zip" "https://extensions.gnome.org$url" || { echo "✗ download failed"; exit 2; }
  src=$tmp/r.zip
fi
if [[ -f $src ]]; then mkdir "$tmp/x" && unzip -q "$src" -d "$tmp/x" || exit 2; src=$tmp/x; fi
[[ -f $src/dock.js ]] || { echo "✗ $src has no dock.js: not a Dash2Dock folder"; exit 2; }

release=$(grep -o '"version": *[0-9]*' "$src/metadata.json" | grep -o '[0-9]*$')
echo "Dash2Dock release ${release:-?}, patch written against 92"
out=$(patch -p1 -N --dry-run -d "$src" <"$here/dash2dock.patch" 2>&1)
# patch only reports hunks that moved, were skipped or failed: read the rest from the patch itself
declare -A why=() prev_applied=()
file=""
while IFS= read -r line; do
  case $line in
    "checking file "*) file=${line#checking file } ;;
    "Hunk #"*" ignored"*) n=${line#Hunk #}; why["$file:${n%% *}"]="in" ;;
    "Reversed (or previously applied) patch detected"*) prev_applied[$file]=1 ;;
    "Hunk #"*" FAILED"*)  n=${line#Hunk #}; why["$file:${n%% *}"]="fail" ;;
    "Hunk #"*" succeeded"*) n=${line#Hunk #}; why["$file:${n%% *}"]="ok" ;;
  esac
done <<<"$out"
bad=0 file="" n=0
while IFS= read -r line; do
  case $line in
    "+++ "*) file=${line#+++ b/}; n=0 ;;
    "@@ "*)
      (( n++ ))
      st=${why["$file:$n"]:-ok}; [[ -n ${prev_applied[$file]:-} && $st == ok ]] && st=in
      case $st in
        ok)   printf '  ✓ %s hunk %d applies\n' "$file" "$n" ;;
        in)   printf '  ✓ %s hunk %d is already in the release: drop it from the patch\n' "$file" "$n" ;;
        fail) printf '  ✗ %s hunk %d fails\n' "$file" "$n"; bad=1 ;;
      esac ;;
  esac
done <"$here/dash2dock.patch"
grep -q "can't find file" <<<"$out" && { echo "  ✗ a file the patch changes is missing in this release"; bad=1; }
(( bad )) && echo "✗ the patch needs a refresh for this release" || echo "✓ the patch applies"
exit "$bad"
