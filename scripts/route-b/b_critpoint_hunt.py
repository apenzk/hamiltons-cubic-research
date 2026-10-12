"""Ascent hunt for critical points of P, to test for unknown S = 0 points.

Route B needs { S = 0 } to be a union of connected components of Crit(P).  Every
known member is nondegenerate (Lemmas 27, 28, and b_cp2_nondegenerate.py), so the
open question is whether unknown S = 0 critical points exist -- plan item F.

Results so far, and their weight:

  n = 10, gradient ascent, 60 starts, 40 converged: two attractors, sqrt(3/2)
    (the W_{CP^2} orbit) and theta_0(10) = 1.2.

  n = 12, POWER ITERATION W -> Q(W)/|Q(W)|, 607 starts, 566 converged (93%):
    theta_0(12) = 1.236033081 (S^6 x S^6, orbit 36) x413
    1.228239158 (S^5 x S^7, orbit 35)             x137
    1.115546702 (HP^2 padded, orbit 47, stabiliser dim 19 = 13 + 6) x16
    All three have slack S ~ 1e-14, i.e. all are graded, and all are known.

Power iteration is the right map here -- critical points are idempotents -- and it
converges at 93% where fixed-step gradient ascent managed 1.8% at the same n.

THE LIMITATION, which is the point.  This hunt finds ATTRACTORS.  W_{CP^2} is a
known S = 0 critical point at n = 12 and does NOT appear in 566 convergences,
because it is not an attractor of the iteration there.  So the method demonstrably
fails to enumerate known points, and finding nothing new is weak evidence for
plan item F.  Settling F needs a method that reaches saddles -- Newton on the
criticality equation from many starts, or a homotopy/degree argument -- not more
starts of this one.
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, adj, weyl_basis, Q

def hunt(n, budget_s=300, seed=0, step=0.05, iters=300, tol=1e-7):
    pairs, idx = pair_index(n); N = len(pairs)
    B = np.array(weyl_basis(n)); D = len(B); Bf = B.reshape(D, -1)
    tens = lambda c: np.einsum('d,dij->ij', c, B)
    rng = np.random.default_rng(seed); t0 = time.time()
    found, starts = [], 0
    while time.time() - t0 < budget_s:
        starts += 1
        c = rng.normal(size=D); c /= np.linalg.norm(c)
        for _ in range(iters):
            W = tens(c); g = 3.0 * (Bf @ Q(n, W).ravel()); g -= (g @ c) * c
            if np.linalg.norm(g) < 1e-11: break
            c = c + step * g; c /= np.linalg.norm(c)
        W = tens(c); th = float(np.tensordot(W, Q(n, W)))
        if th < 0: W, th = -W, -th
        if np.linalg.norm(Q(n, W) - th * W) > tol: continue
        found.append(th)
    return found, starts

if __name__ == "__main__":
    for n, budget in ((10, 60), (12, 300)):
        found, starts = hunt(n, budget_s=budget, seed=n)
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        found.sort(reverse=True); cl = []
        for th in found:
            if cl and abs(th - cl[-1][0]) < 1e-7: cl[-1][1] += 1
            else: cl.append([th, 1])
        rate = len(found) / starts if starts else 0
        print(f"n={n}: {len(found)}/{starts} converged ({rate:.1%})  theta_0={th0:.9f}"
              + ("   [rate too low to be evidence]" if rate < 0.1 else ""))
        for th, cnt in cl:
            print(f"   {th:13.9f} x{cnt:<4} {'ABOVE' if th > th0 + 1e-9 else 'below'} theta_0", flush=True)
