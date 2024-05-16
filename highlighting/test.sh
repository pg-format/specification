#!/usr/bin/bash
set -euo pipefail

# requires
# - skylighting
# - kate-syntax-highlighter (install with Debian package libkf5syntaxhighlighting-tools)

for pg in examples/*.pg; do
  expect=${pg%.pg}.skylighting
  ansi=${pg%.pg}.ansi

  if [[ -f "$expect" ]]; then
    tmp=${pg%.pg}.tmp
    skylighting -d pg.xml -s pg -f native "$pg" 2>/dev/null > "$tmp"
    # kate-syntax-highlighter -f ansi "$pg" > "$ansi"

    if  cmp -s "$tmp" "$expect" ; then
      echo "$pg - OK"
      rm "$tmp"
    else
      echo "$pg - highlighting not as expected"
      diff $tmp $expect
    fi
  else
    echo "$pg - created $expect"
    skylighting -d pg.xml -s pg -f native "$pg" 2>/dev/null > "$expect"
  fi
done
