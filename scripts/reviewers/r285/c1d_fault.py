"""r285 Claim 1(c): NAME the fault behind the 2e-2 residuals.

Candidate: scripts/weyl.py's Q_general assembles Q from DIAGONAL entries only in
R's own eigenbasis -- Q = V diag(w^2 + sharp_diag) V^T.  That is exact for
P(R)=<R,Q(R)> (a diagonal pairing) but drops every off-diagonal entry of R# in
that basis, so <Q(R),V> against a generic Weyl direction V is wrong.
"""
import numpy as np, sys
sys.path.insert(0, "scripts/reviewers/r285"); sys.path.insert(0, "scripts/lib")
from c1_gradient import struct, Q, P, weyl_basis, proj
from weyl import build_structure_constants, Q_general

rng = np.random.default_rng(285285)
for n in (6, 8):
    pr, N, c = struct(n)
    idx_, pos_, N_, c_repo = build_structure_constants(n)
    B, _, _ = weyl_basis(n)
    d = B.shape[0]
    print(f"=== n={n} dimWeyl={d} ===")
    for trial in range(3):
        co = rng.standard_normal(d); co /= np.linalg.norm(co)
        W = np.einsum('k,kab->ab', co, B)
        cv = rng.standard_normal(d); cv /= np.linalg.norm(cv)
        V = np.einsum('k,kab->ab', cv, B)
        Qtrue = Q(c, W)
        Qrepo = Q_general(W, c_repo)
        # how far apart, and is the difference purely off-diagonal in W's eigenbasis?
        w, U = np.linalg.eigh(W)
        Dt = U.T @ Qtrue @ U
        print(f"  trial {trial}: ||Qtrue-Qrepo||={np.linalg.norm(Qtrue-Qrepo):.4e}"
              f"  ||Qtrue||={np.linalg.norm(Qtrue):.4f}"
              f"  ||offdiag(Qtrue in W-eigbasis)||={np.linalg.norm(Dt-np.diag(np.diag(Dt))):.4e}"
              f"  P agree: {abs(P(c,W)-float(np.trace(W@Qrepo))):.2e}")
        h = 1e-5
        fd = (P(c, W+h*V) - P(c, W-h*V))/(2*h)
        pt = 3.0*float(np.sum(Qtrue*V)); pr_ = 3.0*float(np.sum(Qrepo*V))
        print(f"      fd={fd:.10f}  3<Qtrue,V>={pt:.10f} (res {abs(fd-pt):.2e})"
              f"   3<Qrepo,V>={pr_:.10f} (res {abs(fd-pr_):.2e})")
