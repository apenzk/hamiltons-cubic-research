"""r276 Claim 3(d): does run_m_falsifier's rand_weyl really produce trace-free Bianchi tensors?

This file is the ONLY place r276 touches scripts/reviewers/r274 -- the question is about
that code, so it is tested directly.  The optimiser reproduction (claim 3a/3b,
r276_c3_opt.py) shares nothing with it.
"""
import sys; sys.path.insert(0, 'scripts/reviewers/r276'); sys.path.insert(0, 'scripts/reviewers/r274')
import numpy as np
from r276_core import Geom
from r274_weyl import Geo
from r274_c2_opt import rand_weyl

for n in (6, 8, 10, 12):
    g = Geo(n); mine = Geom(n); rng = np.random.default_rng(5)
    M = rand_weyl(g, rng)
    R = mine.to_tensor(M)                      # my own 4-tensor conversion
    bia = R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))
    ric = np.einsum('ijkj->ik', R)
    asym = R + np.transpose(R, (1, 0, 2, 3))
    pairsym = R - np.transpose(R, (2, 3, 0, 1))
    proj = np.abs(mine.proj_weyl(M) - M).max()   # fixed by MY Weyl projector?
    print(f"n={n:2d}  |M|={np.linalg.norm(M):.6f}  Bianchi {np.abs(bia).max():.2e}"
          f"  Ricci {np.abs(ric).max():.2e}  antisym {np.abs(asym).max():.2e}"
          f"  pair-sym {np.abs(pairsym).max():.2e}  fixed by r276 proj {proj:.2e}")

# and the projector is an orthogonal projection onto a space of the right dimension
for n in (5, 6, 7, 8):
    mine = Geom(n); rng = np.random.default_rng(11)
    A = rng.standard_normal((mine.N, mine.N)); X = 0.5*(A+A.T)
    B = rng.standard_normal((mine.N, mine.N)); Y = 0.5*(B+B.T)
    P = mine.proj_weyl
    idem = np.abs(P(P(X)) - P(X)).max()
    sa = abs(np.sum(P(X)*Y) - np.sum(X*P(Y)))
    tri = [(a, b) for a in range(mine.N) for b in range(a, mine.N)]
    cols = []
    for (a, b) in tri:
        Z = np.zeros((mine.N, mine.N)); Z[a, b] += 1.0; Z[b, a] += 1.0
        cols.append(P(Z).ravel())
    rk = np.linalg.matrix_rank(np.array(cols), tol=1e-8)
    print(f"n={n}: P^2=P {idem:.1e}  self-adjoint {sa:.1e}  rank {rk} vs (n+2)(n+1)n(n-3)/12 = "
          f"{(n+2)*(n+1)*n*(n-3)//12}")
