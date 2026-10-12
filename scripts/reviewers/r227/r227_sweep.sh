#!/bin/sh
# r227, claim 5.  Sweep FINDINGS.md, findings/ and response.md for a surviving
# statement that a certificate at one dimension settles Conjecture A for all
# even n >= 12.  Run from the repo root.
#
# The sweep is a two-stage grep: locate every sentence that mentions a
# certificate, the block table, stability, or transfer; then read the hits.
set -e
echo "== stage 1: certificate / transfer / stability sentences =="
grep -rn "certificat\|transfer\|block table\|stable from\|dimension-free\|Levin\|Chandrasekaran\|freely.described" \
     FINDINGS.md response.md findings/ | wc -l
echo "== stage 2: those that also carry an all-n quantifier =="
grep -rn "certificat\|transfer\|block table\|stable from" FINDINGS.md response.md findings/ \
  | grep -i "every \$n\|all \$n\|every even\|all even\|n\\\\ge12\|n \\\\ge 12\|independent of \$n\|does not transfer\|settles" \
  | sed 's/\(.\{200\}\).*/\1.../'
echo
echo "== stage 3: planted violation -- the sweep must catch this line =="
tmp=$(mktemp -d)/findings
mkdir -p "$tmp"
printf 'A certificate built at $n=12$ settles Conjecture A for all even $n\\ge12$.\n' > "$tmp/planted.md"
if grep -rn "certificat" "$tmp" | grep -i "all even" >/dev/null; then
  echo "planted violation CAUGHT -- the sweep pattern fires"
else
  echo "planted violation MISSED -- the sweep pattern is blind"
fi
