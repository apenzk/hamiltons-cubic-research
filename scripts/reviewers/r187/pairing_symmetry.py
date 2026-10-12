"""Reviewer 187, bonus.  run_n5_pairing.py's cost model rests on

    <P_i conj(P_j), J_b> = 20 * D_b(U_i in slots 1-3 ; conj(U_j) in slots 4-6)

justified by "by symmetry of D_b every one of the C(6,3) = 20 slot-splittings
gives the same value".  D_b as implemented is eval_polarised, the VERTEX-ORDERED
form, which reviewer 185 already showed takes 701 distinct values over the 720
permutations of six distinct tensors.  So the premise is testable directly.
"""
import sys, os, random, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import WI, ep, coeff, coeff_sym

P, K, N = 10007, 6, 5
rng = np.random.default_rng(187); pyrng = random.Random(187)
A = WI.random_weyl(N, P, rng); B = WI.random_weyl(N, P, rng)

print("=== are the 20 slot-splittings of a 3+3 pattern all equal? ===")
for mi in range(3):
    m = WI.random_matching(K, pyrng)
    vals = []
    for pos in itertools.combinations(range(6), 3):
        seq = [A if v in pos else B for v in range(6)]
        vals.append(ep(seq, m, P))
    dist = sorted(set(vals))
    print(f"  matching {mi}: {len(dist)} distinct values among the 20 splittings"
          f"  (min {min(vals)}, max {max(vals)})")
    s = sum(vals) % P
    c = coeff([A, B], [3, 3], m, K, P)
    print(f"     sum of the 20 = {s}, coeff(3,3) = {c}, equal: {s == c}")
    print(f"     20 * (one splitting) = {20*vals[0] % P}, "
          f"equal to coeff(3,3): {20*vals[0] % P == c}")
print()
print("  The symmetric polarisation is the SUM over the 20 placements, which is")
print("  what coeff(3,3) returns.  Multiplying ONE placement by 20 is the same")
print("  error the vertex-ordered coefficient claim was refuted for, reappearing")
print("  in the cost model: the cost is |supp|^2 x 20 x pairs x diagrams, twenty")
print("  times the figure run_n5_pairing.py projects.")
