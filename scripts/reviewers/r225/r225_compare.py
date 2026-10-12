"""Compare Sage's independent SO(n) Sym^3 decomposition against the stable O-table.

Prediction: an O(n) irrep [lambda] with l(lambda) < m restricts to SO(2m) irreducibly with
highest weight lambda padded by zeros; with l(lambda) = m it splits into the chirality pair
(lambda_1..lambda_{m-1}, +-lambda_m).  So the stable table predicts the SO table exactly.

Uniqueness of the pull-back: Sym^3(Weyl_n) sits inside (C^n)^{tensor 12}, so every O(n)
constituent [mu] has |mu| <= 12.  For an SO block with a_m = 0 the two O preimages are lambda
and its associate lambda~ with |lambda~| = |lambda| + n - 2 l(lambda); the script checks that
every associate exceeds 12, so the O-table is determined and no modification rule is needed.
"""
import json, sys
n = int(sys.argv[1]); m = n//2
T = {tuple(eval(k)): v for k, v in json.load(open('scripts/reviewers/r225/r225_stable_table.json')).items()}
S = {tuple(eval(k)): v for k, v in json.load(open('scripts/reviewers/r225/r225_so%d.json' % n)).items()}

pred = {}
split = []
for la, v in T.items():
    la = tuple(x for x in la if x)
    assert len(la) <= m, ("label longer than the rank", la)
    if len(la) < m:
        pred[tuple(list(la) + [0]*(m-len(la)))] = pred.get(tuple(list(la)+[0]*(m-len(la))), 0) + v
    else:
        split.append(la)
        for s in (1, -1):
            w = tuple(list(la[:m-1]) + [s*la[m-1]])
            pred[w] = pred.get(w, 0) + v

ok = (pred == S)
print("n=%d (D_%d)" % (n, m))
print("  Sage SO blocks       : %d   total multiplicity %d" % (len(S), sum(S.values())))
print("  predicted from table : %d   total multiplicity %d   (%d labels split into +/- pairs: %s)"
      % (len(pred), sum(pred.values()), len(split), split))
print("  EXACT MATCH          : %s" % ok)
if not ok:
    for k in sorted(set(pred) | set(S)):
        if pred.get(k, 0) != S.get(k, 0):
            print("    MISMATCH %s  predicted %d  actual %d" % (str(k), pred.get(k,0), S.get(k,0)))

# uniqueness of the O pull-back
bad = []
for k, v in S.items():
    if k[-1] == 0:
        la = [x for x in k if x]
        assoc = abs(sum(la)) + n - 2*len(la)
        if assoc <= 12:
            bad.append((k, assoc))
print("  associate pull-backs with |lambda~| <= 12 (would leave the O-table ambiguous): %s"
      % (bad if bad else "none -- O-table uniquely determined"))
print("  => O(%d) table: %d blocks, %d multiplicities" %
      (n, len(T), sum(T.values())) if ok else "  => COMPARISON FAILED")
