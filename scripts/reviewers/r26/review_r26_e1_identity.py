import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r26_core import *
rng = np.random.default_rng(11)

print("=== (d) identity P(W) = sum w^3 + 1/2 sum_{abc} w_a w_b w_c c_abc^2  in the eigenframe ===")
for n in [5,6,7,8]:
    C = struct_const(n); N = C.shape[0]
    B = weyl_basis(n)
    for trial in range(3):
        co = rng.normal(size=B.shape[0]); co /= np.linalg.norm(co)
        W = np.einsum('k,kab->ab', co, B)
        # direct P
        Pd = P(W, C)
        # eigenframe: rotate C by the eigenvectors of W
        w, U = np.linalg.eigh(W)
        Crot = np.einsum('abg,ap,bq,gr->pqr', C, U, U, U, optimize=True)
        T = Crot**2
        val = (w**3).sum() + 0.5*np.einsum('a,b,g,abg->', w, w, w, T, optimize=True)
        # also check the identity via the raw ordered sum with no eigenframe (should equal too)
        print(f"  n={n} trial={trial}: P_direct={Pd: .12f}  P_eigenframe={val: .12f}  diff={abs(Pd-val):.2e}"
              f"  |W|^2={np.trace(W@W):.6f} trW={np.trace(W):.2e}")
    # marginals in the ROTATED frame
    print(f"  n={n}: rotated-frame row marginal min/max = {T.sum(axis=(1,2)).min():.10f}/{T.sum(axis=(1,2)).max():.10f}"
          f"  (kappa={2*(n-2)});  max pair marginal = {T.sum(axis=2).max():.10f}")

print()
print("=== is Q(W) again Weyl for W Weyl?  and tr(W^#) = -tr(W^2)? ===")
for n in [5,6,7,8,9,10]:
    C = struct_const(n); B = weyl_basis(n)
    co = rng.normal(size=B.shape[0]); co /= np.linalg.norm(co)
    W = np.einsum('k,kab->ab', co, B)
    QW = Q(W,C)
    proj = weyl_project(QW, n, B)
    print(f"  n={n}: |Q(W)-Pi_Weyl Q(W)| = {np.abs(QW-proj).max():.3e}   tr(W)={np.trace(W):.2e}"
          f"   tr(W^2)={np.trace(W@W):.10f}   tr(W^#)={np.trace(sharp_fast(W,C)):.10f}"
          f"   tr(Q(W))={np.trace(QW):.3e}")
