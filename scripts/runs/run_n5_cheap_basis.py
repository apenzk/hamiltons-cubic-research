"""Choose the 14 invariant sextics for ASSEMBLY COST, not at random.

The pairing <P_i conj(P_j), J_b> factorises: for a fixed diagram and a fixed
3+3 splitting of its six slots, contracting U_i's tensors along the pairs
INTERNAL to its half gives a reduced object with one index per CROSS pair, and
that object is shared across every j.  The pairing is then one small contraction
per (i,j) rather than |supp_i| x |supp_j| polarised evaluations.

The cost is set by the cross-pair count, and it varies: over random matchings it
runs 4, 6, 8, 10, 12, giving reduced tensors of 5^c entries -- 625 up to 244
million.  Nothing forces the basis to be random, so it is screened here for the
cheap end while still being checked to span.

The spanning check can fail and did: cap 8 stops at rank 10.  But the cap-12
row COULD NOT have failed -- reviewer 190 proves every loopless matching has
sum_S cross(S) = 72 over the ten balanced splittings, so max cut >= 8 always and
cap 12 admits 100% of diagrams.  That row is a vacuous filter reported as a
measurement.

190 also makes the result exhaustive rather than sampled: the cap-C family is
(iso classes of 4-regular loopless multigraph on 6 vertices) x 3^6 slot
assignments -- cap 8 gives 3 classes and all 2187 diagrams, rank 10 at three
primes; cap 10 gives 15 classes and all 10935, rank 13.  So 10/13/14 is OPTIMAL,
not merely achievable.  The cheap end is thin because one cap-8 class is
DISCONNECTED, two doubled triangles, contributing only the line tr(M^3)^2.

And the cost metric here is wrong: it should be sum_S 5^cross(S), not 5^max.
The cheapest cut-12 class has ONE splitting at 5^12 against four for the worst.
"""
import sys, os, random, numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "..", "reviewers", "r179"))
import weyl_invariants as WI

N, K, P = 5, 6, 10007
rng = np.random.default_rng(21); pyrng = random.Random(21)
PTS = [WI.random_weyl(N, P, rng) for _ in range(40)]

from itertools import combinations
SPLITS = [frozenset(c) for c in combinations(range(6), 3) if 0 in c]   # 10 up to swap

def worst_cross(m):
    """the largest cross-pair count over the 3+3 splittings -- the memory driver."""
    w = 0
    for S in SPLITS:
        c = sum(1 for a, b in m if ((a//4) in S) != ((b//4) in S))
        w = max(w, c)
    return w

CAP = 8
basis, rows, seen, tries = [], [], 0, 0
while len(basis) < 14 and tries < 40000:
    m = WI.random_matching(K, pyrng); tries += 1
    if worst_cross(m) > CAP: continue
    seen += 1
    col = [WI.eval_diagram(W, m, K, P) % P for W in PTS]
    trial = rows + [col]
    if WI.rank_modp([r[:] for r in trial], P) > len(rows):
        rows = trial; basis.append(m)

print(f"  screened {tries} matchings, {seen} with worst cross-pair count <= {CAP}")
print(f"  independent diagrams found: {len(basis)}")
print(f"  evaluation rank: {WI.rank_modp([r[:] for r in rows], P)}  (must be 14)")
print(f"  spans the invariant sextics: {len(basis) == 14}")
if basis:
    ws = sorted(worst_cross(m) for m in basis)
    print(f"  worst cross-pair counts in the chosen basis: {ws}")
    print(f"  largest reduced tensor: 5^{ws[-1]} = {5**ws[-1]:,} entries")
