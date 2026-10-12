# Reconstruct the O(n) invariants of the Sym^3 decomposition from the SO(n)=D_m ground truth.
# SO block with a_m != 0  <->  one self-associate O(n) label (l(lambda)=m), same multiplicity, appearing as a +/- pair.
# SO block with a_m == 0  <->  ONE O(n) irrep or its associate; either way it contributes its multiplicity once.
# Hence total O(n) multiplicity is determined exactly, with no modification rule needed.
import json, sys
n = int(sys.argv[1]); m = n//2
d = {tuple(eval(k)): v for k, v in json.load(open('scripts/reviewers/r225/r225_so%d.json' % n)).items()}
pairs, zeros = {}, {}
for k, v in d.items():
    if k[-1] != 0:
        key = k[:-1] + (abs(k[-1]),)
        assert pairs.get(key, v) == v, ("asymmetric pair", key)
        pairs[key] = v
    else:
        zeros[k] = v
assert 2*len(pairs) + len(zeros) == len(d)
tot_O = sum(zeros.values()) + sum(pairs.values())
lo = len(zeros) + len(pairs)
print("n=%d: SO blocks=%d total=%d | +/- pairs=%d (self-assoc, l=%d) | a_m=0 blocks=%d"
      % (n, len(d), sum(d.values()), len(pairs), m, len(zeros)))
print("  => O(%d) TOTAL MULTIPLICITY = %d (exact, no modification rule used)" % (n, tot_O))
print("  => O(%d) block count in [%d, %d]" % (n, lo, 2*len(zeros)+len(pairs)))
