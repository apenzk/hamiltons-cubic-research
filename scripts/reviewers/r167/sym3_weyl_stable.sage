"""The stable O(n)-decomposition of Sym^3(Weyl_n), n >= 12, without expanding any character.

RUN:  sage scripts/reviewers/r167/sym3_weyl_stable.sage       (seconds, ~100 MB)

Reviewer r167, written from the definitions to audit scripts/runs/sym3_weyl_blocks.sage.

METHOD
  1. V^GL_[2,2](R^n) | O(n) = [2,2] + [2] + [0]  and  V^GL_[2](R^n) | O(n) = [2] + [0],
     so the Weyl module is the virtual GL class  s_{22} - s_2  restricted to O(n).
  2. Restriction GL(n) -> O(n) is a homomorphism of lambda-rings, so
        Sym^3(Weyl_n) = restrict( h_3[ s_{22} - s_2 ] ).
  3. h_3[s_{22} - s_2] has 39 Schur terms, all of length <= 6.
  4. Littlewood's restriction rule  V^GL_mu | O(n) = sum_lambda (sum_{beta even} c^mu_{lambda beta}) [lambda]
     is valid whenever len(mu) <= n/2, hence for every n >= 12.

OUTPUT: 71 O(n)-irreducible blocks for every n >= 12, with n-independent labels and
multiplicities.  Six of the 71 have exactly 6 rows; at n = 12 those are SELF-ASSOCIATE and
each splits into two SO(12)-irreducibles, so the SO(12) block count is 71 + 6 = 77.
From n = 14 on nothing splits and both counts are 71.

CHECKS: sum over blocks of multiplicity times dimension equals C(dim Weyl_n + 2, 3) at
n = 12, 14, 16 -- 7.3e8, 4.9e9, 2.5e10 -- with dim_O = 2 dim_SO on the six 6-row labels.
"""
import sys
from collections import defaultdict

S = SymmetricFunctions(QQ); s = S.s(); h = S.h()
EVENS = [b for k in range(0, 13, 2) for b in Partitions(k) if all(p % 2 == 0 for p in b)]


def restrict(f):
    """Littlewood restriction of a (virtual) GL character to O(n), n >= 2*max_rows(f)."""
    m = defaultdict(int)
    for mu in f.support():
        cmu = f.coefficient(mu)
        for b in EVENS:
            if sum(b) > sum(mu):
                continue
            for la in Partitions(sum(mu) - sum(b)):
                c = s(s(la) * s(b)).coefficient(mu)
                if c:
                    m[tuple(la)] += cmu * c
    return {k: v for k, v in m.items() if v != 0}


f = s(h[3].plethysm(s[2, 2] - s[2]))
assert max(len(la) for la in f.support()) == 6, "Littlewood range assumption broken"
m = restrict(f)
assert all(v > 0 for v in m.values()), "a multiplicity came out negative"

six = {k: v for k, v in m.items() if len(k) == 6}
print("O(n)-blocks of Sym^3(Weyl_n), stable for n >= 12: %d" % len(m))
print("self-associate (6-row) labels, which split under SO(2r) at n = 12 only:")
for k in sorted(six):
    print("    %-22s multiplicity %d" % (str(list(k)), six[k]))
print("=> SO(12) block count = %d + %d = %d" % (len(m), len(six), len(m) + len(six)))
print("=> SO(2r) block count = %d for every n = 2r >= 14" % len(m))
print("trivial block multiplicity (cubic O(n)-invariants) = %d" % m.get((), 0))
prof = sorted(m.values(), reverse=True)
print("multiplicity profile: %s" % prof)
print("largest block %d x %d;  sum of multiplicities %d;  SDP free parameters %d"
      % (prof[0], prof[0], sum(prof), sum(v * (v + 1) // 2 for v in m.values())))
sys.stdout.flush()

print("\ndimension checks:")
for typ, r, n in [("D", 6, 12), ("D", 7, 14), ("D", 8, 16)]:
    R = WeylCharacterRing("%s%d" % (typ, r))
    def dimO(la):
        d = R(list(la) + [0] * (r - len(la))).degree()
        return 2 * d if len(la) == r else d
    D = (n + 2) * (n + 1) * n * (n - 3) // 12
    tot = sum(v * dimO(k) for k, v in m.items())
    print("  n=%2d  dim Weyl=%5d  sum m*dim=%14d  C(D+2,3)=%14d  %s"
          % (n, D, tot, binomial(D + 2, 3), "MATCH" if tot == binomial(D + 2, 3) else "MISMATCH"))
    assert tot == binomial(D + 2, 3)
