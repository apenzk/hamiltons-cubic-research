"""
Is the n=6 flat direction real, or finite-difference noise?

p3b_local_separation.py found, at the balanced S^3 x S^3 critical point (n=6),
that ker(Hess P) has dimension 18 against an orbit of dimension 9, and that
Hess S on the 9 transverse kernel directions is +-3e-7 -- at the noise floor of
a central difference with h = 1e-4.  At n = 8 both tested points gave
ker = orbit exactly, so nothing transverse exists there at all.

Second order cannot settle n = 6.  This walks a finite distance instead:
along each transverse kernel direction v, it measures S(t) and the criticality
residual for t up to 0.15, and fits the leading power of S(t).  Three outcomes:

  * S(t) ~ t^2 with a real coefficient  -> the Hessian reading was noise,
    the graded point is separated after all;
  * S(t) ~ t^3 or t^4                   -> separated, but only weakly, and the
    compactness argument still applies since S > 0 for t > 0;
  * S(t) = 0 to machine precision while criticality holds -> a genuine graded
    family through the point, and the transverse direction is not a path OUT of
    the graded set at all.

Only the case "S(t) = 0 with criticality LOST" would be uninformative, and it is
reported as such.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from run_unconstrained_search import build_weyl_basis
from review_r11_graded_law import weyl_sphere_product_mop
from p3b_local_separation import slack, orbit_span

n = 6
idx, pos, N, c = build_structure_constants(n)
L2 = Lambda2(n)
alt = build_alt_indices(L2)
Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
Nl = L2.N

W0 = weyl_sphere_product_mop(L2, 3, 3)
W0 = W0 / np.linalg.norm(W0)
th0 = float(np.sum(W0 * Q_full(W0, c)))
if th0 < 0:
    W0, th0 = -W0, -th0
w = Eflat @ W0.reshape(-1)
B = np.linalg.svd(np.outer(w, w))[0][:, 1:]

M = np.zeros((D, D))
for b in range(D):
    Hb = Eflat[b].reshape(Nl, Nl)
    M[:, b] = Eflat @ ((Q_full(W0 + Hb, c) - Q_full(W0 - Hb, c)) / 4.0).reshape(-1)
M = 0.5 * (M + M.T)
HP = B.T @ (6 * M - 3 * th0 * np.eye(D)) @ B
evP, VP = np.linalg.eigh(HP)
ker = VP[:, np.abs(evP) < 1e-7]

orb = orbit_span(W0, n, Eflat)
sv = np.linalg.svd(orb @ B, full_matrices=False)
rk = int(np.sum(sv[1] > 1e-8 * max(sv[1][0], 1e-300)))
Ob = sv[2][:rk].T
Ok = ker.T @ Ob
s_ = np.linalg.svd(Ok, compute_uv=False) if Ok.size else np.array([])
comp = np.linalg.svd(Ok)[0][:, int(np.sum(s_ > 1e-6)):] if Ok.size else np.eye(ker.shape[1])
T = ker @ comp

print(f"S^3 x S^3 at n=6:  theta={th0:.9f}  ker(Hess P)={ker.shape[1]}  orbit={rk}"
      f"  transverse={T.shape[1]}\n")
print(f"{'dir':>4} {'t':>8} {'S(t)':>14} {'crit resid':>12} {'theta(t)':>12}")
ts = [0.01, 0.03, 0.06, 0.10, 0.15]
for a in range(T.shape[1]):
    v = T[:, a]
    row = []
    for t in ts:
        W = (Eflat.T @ (w + t * (B @ v))).reshape(Nl, Nl)
        W = 0.5 * (W + W.T); W /= np.linalg.norm(W)
        QW = Q_full(W, c); th = float(np.sum(W * QW))
        res = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
        row.append((t, slack(L2, W, c, alt), res, th))
    for (t, S, res, th) in row:
        print(f"{a:>4} {t:>8.3f} {S:>14.6e} {res:>12.2e} {th:>12.8f}")
    # leading power of S(t), from the two largest t
    (t1, S1, _r1, _x1), (t2, S2, _r2, _x2) = row[-2], row[-1]
    if S1 > 1e-13 and S2 > 1e-13:
        p = np.log(S2 / S1) / np.log(t2 / t1)
        print(f"     -> S(t) ~ t^{p:.2f}")
    else:
        print(f"     -> S stays at machine zero out to t={ts[-1]}")
    print()
