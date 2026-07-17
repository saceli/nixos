#!/bin/sh
set -eu

usage() {
  cat <<EOF
Usage: $(basename "$0") <directory>

Generate a nested default.nix module tree from all default.nix files
found under <directory>.

Arguments:
  <directory>    Root directory to scan.

Options:
  -h, --help     Show this help message and exit.

Example:
  $(basename "$0") ./modules
EOF
}

case "${1:-}" in
  -h|--help)
    usage
    exit 0
    ;;
  "")
    usage >&2
    exit 1
    ;;
esac

ROOT=$(cd "$1" && pwd)
OUT="$ROOT/default.nix"

[ -d "$ROOT" ] || {
  echo "error: '$ROOT' is not a directory" >&2
  exit 1
}

tmp=$(mktemp)

find "$ROOT" -type f -name default.nix ! -path "$OUT" |
sort |
awk -v root="$ROOT" '
function trim(path) {
  sub(root "/", "", path)
  sub("/default.nix", "", path)
  return path
}

function indent(n, i) {
  for (i = 0; i < n; i++)
    printf "  "
}

BEGIN {
  print "{"
  print ""

  prev_depth = 0
}

{
  path = trim($0)
  split(path, p, "/")
  depth = length(p)

  common = 0
  max = (depth < prev_depth ? depth : prev_depth)

  for (i = 1; i < max; i++) {
    if (p[i] == prev[i])
      common++
    else
      break
  }

  # close blocks
  for (i = prev_depth - 1; i > common; i--) {
    print ""
    indent(i + 1)
    print "};"
  }

  # open blocks
  for (i = common + 1; i < depth; i++) {
    print ""
    indent(i + 1)
    print p[i] " = {"
  }

  # leaf
  indent(depth + 1)
  printf "%s = { imports = [ ./%s ]; };\n", p[depth], path

  for (i = 1; i <= depth; i++)
    prev[i] = p[i]

  prev_depth = depth
}

END {
  for (i = prev_depth - 1; i >= 1; i--) {
    print ""
    indent(i + 1)
    print "};"
  }

  print ""
  print "}"
}
' > "$tmp"

mv "$tmp" "$OUT"

echo "generated: $OUT"