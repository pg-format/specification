#!/usr/bin/bash
set -euo pipefail

for pg in examples/*.pg; do
  expect=${pg%.pg}.highlighting

  if [[ -f "$expect" ]]; then
    tmp=${pg%.pg}.tmp
    skylighting -d pg.xml -s pg -f native "$pg" 2>/dev/null > "$tmp"

    if  cmp -s "$tmp" "$expect" ; then
      echo "$pg - OK"
      rm "$tmp"
    else
      echo "$pg - highlighting not as expected"
      cat $tmp
      cat $expect
    fi
  else
    echo "$pg - created $expect"
    skylighting -d pg.xml -s pg -f native "$pg" 2>/dev/null > "$expect"
    cat $expect
  fi
done
