"""SP-3: which 4-subsets of the ten d=3 bracket types are Jacobi-consistent.

A vertex of the pinned polytope at three distinct eigenvalues has (at least) four
of the ten t_{ijk} zero (Lemma L120's companion, reviews/DERIVE-sp3.md).  For a
REALISABLE vertex, t_{ijk}=0 means <[E_i,E_j],E_k>=0, so a candidate vanishing set
Z determines a bracket table

    B(i,j) = { k : sorted{i,j,k} not in Z },   [E_i,E_j] subset of sum_{k in B(i,j)} E_k.

Z is the EXACT vanishing set, so every type outside Z must be able to be nonzero.
Jacobi forces  [[E_i,E_j],E_k] subset [E_i,[E_j,E_k]] + [E_j,[E_i,E_k]], i.e. the
index inclusion below.  If it fails, Jacobi forces a bracket outside Z to vanish,
contradicting exactness -- so Z is inadmissible.

Controls are run first and printed: the Z_3-grading and the split symmetric pair
must PASS, and a deliberately wrong set must FAIL, or the test proves nothing.
"""
from itertools import combinations, combinations_with_replacement

CLASSES = (1, 2, 3)
TYPES = [tuple(t) for t in combinations_with_replacement(CLASSES, 3)]  # 10 of them


def table(Z):
    Z = set(Z)
    return {(i, j): frozenset(k for k in CLASSES if tuple(sorted((i, j, k))) not in Z)
            for i in CLASSES for j in CLASSES}


def admissible(Z):
    B = table(Z)
    for i in CLASSES:
        for j in CLASSES:
            for k in CLASSES:
                lhs = set().union(*(B[(m, k)] for m in B[(i, j)])) if B[(i, j)] else set()
                r1 = set().union(*(B[(i, m)] for m in B[(j, k)])) if B[(j, k)] else set()
                r2 = set().union(*(B[(j, m)] for m in B[(i, k)])) if B[(i, k)] else set()
                if not lhs <= (r1 | r2):
                    return False
    return True


Z3 = [(1, 1, 2), (1, 1, 3), (2, 2, 2), (3, 3, 3)]          # Z_3-grading
SP = [(1, 1, 3), (1, 2, 3), (2, 2, 3), (3, 3, 3)]          # symmetric pair, split even part
# NEGATIVE CONTROL, verified by hand.  Z = {111,112,122,123} forces B(1,2) = {},
# i.e. [E_1,E_2] = 0, so Jacobi makes [[E_1,E_1],E_2] subset [E_1,[E_1,E_2]] = 0;
# but B(1,1) = {3} and B(3,2) = {2,3} are nonempty, so that bracket is required
# nonzero.  Contradiction, so this Z must be REJECTED.
BAD = [(1, 1, 1), (1, 1, 2), (1, 2, 2), (1, 2, 3)]
# An earlier draft used {111,112,113,122} as the negative control and it PASSED --
# correctly, because E_1 is an ideal only if five types vanish (112,113,122,123,133),
# which no 4-subset can do.  That control tested nothing; this one does.

print("CONTROLS  (the test is worthless unless the first two PASS and the third FAILS)")
ok = True
for name, Z, want in (("Z_3-grading       ", Z3, True), ("split symm. pair  ", SP, True),
                      ("hand-checked bad  ", BAD, False)):
    got = admissible(Z)
    ok &= (got == want)
    print(f"  {name} {[''.join(map(str,x)) for x in sorted(Z)]} -> "
          f"{'PASS' if got else 'FAIL'}  (expected {'PASS' if want else 'FAIL'})"
          f"{'' if got == want else '   *** CONTROL BROKEN ***'}")
if not ok:
    raise SystemExit("controls failed: the enumeration below would prove nothing")

good = [Z for Z in combinations(TYPES, 4) if admissible(Z)]
print(f"\nADMISSIBLE 4-SUBSETS: {len(good)} of {len(list(combinations(TYPES, 4)))}")
for Z in good:
    tag = []
    if set(Z) == set(Z3): tag.append("Z_3-grading")
    if set(Z) == set(SP): tag.append("split symmetric pair")
    print("   ", "".join(f"{a}{b}{c} " for a, b, c in Z), ("  <- " + ", ".join(tag)) if tag else "")
