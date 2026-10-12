"""Reviewer 31: L_e spectrum / orbit comparison at an arbitrary critical W."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r31_core import *
from review_r31_spec import sym_basis, build_L, orbit_tangent, all_gens


def analyse_point(alg, W, label, tol=1e-8):
    n = alg.n
    W = W / np.sqrt(np.sum(W * W))
    th = float(np.sum(alg.Q(W) * W))
    if th < 0:
        W = -W; th = -th
    res = float(np.abs(alg.Q(W) - th * W).max())
    e = W / th
    M, D = build_L(alg, e)
    evals, evecs = np.linalg.eigh(M)
    wd = weyl_dim(n)
    clusters = []
    for v in evals:
        if clusters and abs(v - clusters[-1][0]) < 1e-7:
            clusters[-1][1] += 1
        else:
            clusters.append([v, 1])
    out = []
    for v, m in clusters:
        if abs(v) < 1e-7:
            m -= (D - wd)
        if m > 0:
            out.append((v, m))
    idx = np.where(np.abs(evals - 0.5) < tol)[0]
    others = np.sort(np.abs(evals[np.abs(evals - 0.5) >= tol] - 0.5))
    Ta = orbit_tangent(alg, W, all_gens(n))
    sa = np.linalg.svd(Ta, compute_uv=False)
    dorb = int((sa > 1e-9 * sa[0]).sum())
    Bs = sym_basis(alg.N); Bf = np.array([b.ravel() for b in Bs]).T
    Eh = Bf @ evecs[:, idx]
    def onb(Mx, r=None):
        U, s_, _ = np.linalg.svd(Mx, full_matrices=False)
        if r is None:
            r = int((s_ > 1e-9 * s_[0]).sum())
        return U[:, :r]
    cos = np.linalg.svd(onb(Eh).T @ onb(Ta, dorb), compute_uv=False)
    print(f"=== {label}  n={n} theta={th:.10f} |Q-thW|={res:.2e}")
    print(f"    dim E(1/2)={len(idx)}  orbit dim={dorb}  gap to nearest other eigenvalue={others[0]:.6e}")
    print(f"    principal cosines: min={cos.min():.10f} max={cos.max():.10f} (k={len(cos)})")
    print("    spectrum:", "  ".join(f"{v:+.8f}^{m}" for v, m in out))
    sys.stdout.flush()
    return th, len(idx), dorb
