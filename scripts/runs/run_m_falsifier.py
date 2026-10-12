"""ROUTE M'S FALSIFIER: is there a unit Weyl operator with tr(M^3) + ||M#||_F > sqrt(3)?

WHY THIS RUNS FIRST.  Route M would prove M(n) <= sqrt(3) on circ-indecomposable
unit Weyl operators, which caps every non-diagonal critical point at
sqrt(3/2) = 1.2247 < theta_0(n) for n >= 12 and closes Conjecture A.  A single
tensor above sqrt(3) kills the route before its crux (M2) is attempted.

NUMERICS AS REFUTATION, which is what they are for.  A hit is decisive; a miss
establishes nothing and is recorded as establishing nothing.

METHOD.  Riemannian ascent on the unit sphere of Weyl_n, maximising
F(M) = tr(M^3) + ||M#||_F, reusing the machinery r274 built for its claim 2 -- the
projection, the sharp operator and the gradient of ||M#||^2 -- rather than a fresh
implementation, since the object here is r274's own measured maximum extended.
Many restarts per dimension, because the previous number came from few.
"""
import sys, numpy as np
sys.path.insert(0, "scripts/reviewers/r274")
from r274_c2_opt import Geo, theta0, rand_weyl, ascend

SQRT3 = np.sqrt(3.0)
print(f"  target to beat: sqrt(3) = {SQRT3:.6f}\n")
print(f"  {'n':>3} {'restarts':>9} {'best F':>10} {'F/sqrt3':>9} {'theta_0':>9} {'margin':>9}")
overall = []
for n in (6, 8, 10, 12, 14):
    g = Geo(n); rng = np.random.default_rng(31415 + n)
    best, bM = -9.0, None
    R = 60 if n <= 10 else 30
    for _ in range(R):
        M, v = ascend(g, rand_weyl(g, rng), 'F', iters=900)
        if v > best: best, bM = v, M
    overall.append((n, best))
    print(f"  {n:>3} {R:>9} {best:>10.6f} {best/SQRT3:>8.3f} {theta0(n):>9.6f}"
          f" {SQRT3-best:>+9.6f}")

hits = [(n, v) for n, v in overall if v > SQRT3]
print(f"\n  tensors found above sqrt(3): {hits if hits else 'none'}")
if hits:
    print("  ROUTE M IS REFUTED -- the cap it would prove is false.")
else:
    print("  NO FALSIFIER FOUND.  This establishes NOTHING about whether the cap")
    print("  holds: ascent finds local maxima, the search is finite, and the")
    print("  quantity is not concave.  It licenses spending a cycle on M2, and")
    print("  that is the whole of what it licenses.")
assert True
