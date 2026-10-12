"""Does taking the MINIMUM over frames of the single-frame bound rescue it? (n=6)"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r103'))
import r103_core as C
from r103_claim5 import F_of_K, balanced_vertex, theta0
from itertools import combinations
from scipy.linalg import null_space, expm

rng = np.random.default_rng(4242)
n = 6; prs = list(combinations(range(n), 2))
samples = [C.weyl_from_random(n, rng) for _ in range(40)]
A = np.array([[S[i, j, i, j] for S in samples] for (i, j) in prs])
Wp = sum(cc*S for cc, S in zip(null_space(A)[:, 0], samples)); Wp = Wp/np.linalg.norm(C.M_of(Wp, n))
Wd = C.weyl_from_vertex(balanced_vertex(3)); Wd = Wd/np.linalg.norm(C.M_of(Wd, n))
r2 = np.random.default_rng(7)
print(f"theta0(6) = {theta0(6):.6f}", flush=True)
for c in (0.95, 0.9):
    W = c*Wd + np.sqrt(1-c*c)*Wp
    th = C.theta_bispectral(W, n)[0]
    vals = []
    for k in range(40):
        Q = np.eye(n) if k == 0 else expm(((lambda X: (X-X.T)/2)(r2.standard_normal((n, n))))*(0.3 if k < 20 else 1.0))
        Wr = np.einsum('ai,bj,ck,dl,ijkl->abcd', Q, Q, Q, Q, W)
        K = C.vertex_matrix(Wr, n)
        v, _, _ = F_of_K(K, seed=k, nstart=18)
        vals.append((v, np.linalg.norm(K)**2))
    vals.sort()
    print(f" c={c}: theta(W)={th:.5f}  min_F F(K(F))={vals[0][0]:.4f} (t={vals[0][1]:.3f})  "
          f"median={vals[len(vals)//2][0]:.4f}  max={vals[-1][0]:.4f}  "
          f"{'STILL ABOVE theta0' if vals[0][0] > theta0(6) else 'DIPS BELOW theta0'}", flush=True)
