"""Reviewer 62: audit of C1 (eigenframe form), C2 (exact weighted row sum), C3 (theta <= 9bc(b+c))."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, itertools, sys
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r62_core import *

rng = np.random.default_rng(62)

print("=== C1: theta = sum lam^3 + 3 sum_{a<b<g} T lam lam lam ===")
for m in (4, 5, 6):
    B, idx = so_basis(m); C = struct_consts(B); N = len(B)
    for trial in range(3):
        X = rng.normal(size=(N, N)); W = (X + X.T) / 2
        W /= np.sqrt(np.sum(W * W))
        th = ip_mat(W, W @ W + sharp(W, C))
        lam, V, T, R = eig_data(W, B, C)
        print(f"  m={m} random symmetric: theta={th:+.12f} rhs={c1_rhs(lam,T):+.12f} diff={th-c1_rhs(lam,T):+.2e}")
    # symmetry / vanishing checks of T
    print(f"  m={m} T symmetric err={np.max(np.abs(T-np.transpose(T,(1,2,0)))):.2e}"
          f" diag err={np.max(np.abs(np.einsum('aab->ab',T))):.2e} min T={T.min():.2e}")

print("\n=== facts (i),(ii) sanity on Weyl_m ===")
for m in (4, 5, 6):
    B, idx = so_basis(m); C = struct_consts(B)
    W, _, _ = random_weyl(m, rng)
    lam, V, T, R = eig_data(W, B, C)
    print(f"  m={m} dim Weyl={len(weyl_projector(m)[0])}  ||R lam + 2 lam||={np.linalg.norm(R@lam+2*lam):.2e}"
          f"  rowsum-2(m-2) err={np.max(np.abs(R.sum(1)-2*(m-2))):.2e}  max R_ab={R.max():.6f}")
    th = ip_mat(W, W @ W + sharp(W, C))
    print(f"       theta={th:+.9f}  c1={c1_rhs(lam,T):+.9f}  negatives={np.sum(lam<-1e-9)}")

print("\n=== C2 on the base-case family W4(q,r), padded ===")
for (q, r, m) in [(1, 1, 4), (1, 0.3, 4), (2, 0.5, 6), (1, 1, 6), (0.7, 0.2, 6)]:
    W, B, idx = w4_family(q, r, m)
    C = struct_consts(B)
    lam, V, T, R = eig_data(W, B, C)
    order = np.argsort(lam)          # ascending: lam[0] most negative
    negs = np.sort(lam[lam < -1e-9])
    b = -negs[0]; c = -negs[1]
    P = np.where(lam > 1e-9)[0]
    s = lam[P].sum(); u = (lam[P] ** 2).sum()
    iN = int(np.argmin(lam)); iN1 = int(np.argsort(lam)[1])
    Rpair = R[iN1, iN]
    lhs1 = sum(lam[a] * R[a, iN1] for a in P)
    lhs2 = sum(lam[a] * R[a, iN] for a in P)
    wsum = sum(R[a, bb] * lam[a] * lam[bb] for a in P for bb in P)
    exact = 2 * b ** 2 + 2 * c ** 2 + 2 * b * c * Rpair - 2 * u
    print(f"  q={q} r={r} m={m}: b={b:.6f} c={c:.6f} R={Rpair:.6f} k={len(P)}")
    print(f"     row N-1: {lhs1:+.9f} vs 2c+bR={2*c+b*Rpair:+.9f}   row N: {lhs2:+.9f} vs 2b+cR={2*b+c*Rpair:+.9f}")
    print(f"     weighted PP sum: {wsum:+.9f} vs formula {exact:+.9f}   (b+c)^2+b^2+c^2-1 = {(b+c)**2+b**2+c**2-1:+.3e}")
    th = ip_mat(W, W @ W + sharp(W, C))
    print(f"     theta={th:+.9f}  9bc(b+c)={9*b*c*(b+c):+.9f}  slack={9*b*c*(b+c)-th:+.3e}"
          f"  T_{{1,N-1,N}}={T[P[0],iN1,iN]:.6f}  lam_1={lam[P].max():.6f} s={s:.6f}")
