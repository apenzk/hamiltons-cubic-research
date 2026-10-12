"""
P2: does the graded enumeration's TWO-eigenvalue ansatz miss critical points?

The enumeration (review_r11_graded_law.py) assumes a graded critical point is

    W = ( q Pi_k - p Pi_m ) / sqrt(p q (p+q)),   p = dim k, q = dim m,

i.e. SCALAR on the whole isotropy algebra k.  Petersen-Stanfield
(arXiv:2508.11236, Thm A) show the curvature operator of a compact irreducible
symmetric space has one, TWO or THREE distinct nonzero eigenvalues -- one per
simple factor of h = h_0 + sum h_i, with eigenvalue 1/2 on the centre h_0
(their Prop 2.2) -- and that the complex Grassmannians realise three.

So whenever k splits, k = k_1 + ... + k_r, the honest ansatz is

    W = sum_i a_i Pi_{k_i}  +  c Pi_m,

an (r+1)-parameter family, of which the enumeration keeps only the slice
a_1 = ... = a_r.  This script asks whether criticality actually FORCES that
slice, or whether the off-slice solutions are genuine critical points the
enumeration never saw.

Test bed: k = so(k) + so(l) inside so(k+l), whose m = R^k tensor R^l.  This is
the real Grassmannian pair, and it is the one case where the answer is known
independently -- the sphere product S^{k-1} x S^{l-1} lives here, and its Weyl
operator has THREE distinct entries (alpha on so(k)-planes, beta on so(l)-planes,
gamma on mixed), coinciding only when k = l.  If the method reproduces the sphere
products off the diagonal slice, the two-eigenvalue ansatz is provably partial.
"""
import numpy as np
from scipy.optimize import fsolve

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop


def block_projections(n, k):
    """Pi_1, Pi_2, Pi_m on Lambda^2(R^n) for the split R^k + R^{n-k}:
    so(k)-planes, so(n-k)-planes, mixed planes."""
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    N = len(pairs)
    P1 = np.zeros((N, N)); P2 = np.zeros((N, N)); Pm = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs):
        if i < k and j < k:
            P1[a, a] = 1.0
        elif i >= k and j >= k:
            P2[a, a] = 1.0
        else:
            Pm[a, a] = 1.0
    return P1, P2, Pm


def solve_family(n, k, c, L2, seeds=24, verbose=True):
    """All critical points of P inside span{Pi_1, Pi_2, Pi_m} that are
    Ricci-flat and unit norm.  Returns list of (theta, (a,b,g))."""
    P1, P2, Pm = block_projections(n, k)
    basis = [P1, P2, Pm]

    def build(x):
        W = x[0] * P1 + x[1] * P2 + x[2] * Pm
        return W

    def residual(x):
        W = build(x)
        nrm = np.linalg.norm(W)
        if nrm < 1e-12:
            return [1e3, 1e3, 1e3]
        Wn = W / nrm
        r = ricci_from_mop(L2, Wn)          # Ricci-flatness (trace-free Weyl)
        QW = Q_full(Wn, c)
        th = float(np.sum(Wn * QW))
        grad = QW - th * Wn
        # project criticality residual onto the family (the family is
        # SO(k)xSO(l)-invariant, so criticality within it is criticality)
        g = [float(np.sum(B * grad)) / np.linalg.norm(B) for B in basis]
        # Ricci-flatness gives two independent scalars on this split
        r1 = float(r[0, 0]); r2 = float(r[n - 1, n - 1])
        return [g[0] - g[2], g[1] - g[2], r1 - r2]

    found = []
    rng = np.random.default_rng(0)
    for s in range(seeds):
        x0 = rng.normal(size=3)
        try:
            x, info, ier, _ = fsolve(residual, x0, full_output=True)
        except Exception:
            continue
        if ier != 1:
            continue
        W = build(x)
        if np.linalg.norm(W) < 1e-8:
            continue
        Wn = W / np.linalg.norm(W)
        if np.max(np.abs(ricci_from_mop(L2, Wn))) > 1e-9:
            continue
        QW = Q_full(Wn, c)
        th = float(np.sum(Wn * QW))
        if th < 0:
            Wn, th = -Wn, -th
        if np.linalg.norm(QW - float(np.sum(Wn * Q_full(Wn, c))) * Wn) / max(np.linalg.norm(QW), 1e-30) > 1e-8:
            continue
        ent = np.array([Wn[np.where(np.diag(P1) > 0)[0][0], np.where(np.diag(P1) > 0)[0][0]] if P1.trace() else 0.0,
                        Wn[np.where(np.diag(P2) > 0)[0][0], np.where(np.diag(P2) > 0)[0][0]] if P2.trace() else 0.0,
                        Wn[np.where(np.diag(Pm) > 0)[0][0], np.where(np.diag(Pm) > 0)[0][0]] if Pm.trace() else 0.0])
        if not any(abs(th - t0) < 1e-7 and np.allclose(ent, e0, atol=1e-7) for t0, e0 in found):
            found.append((th, ent))
    found.sort(key=lambda t: -t[0])
    if verbose:
        for th, e in found:
            eq = "TWO-eigenvalue (a=b)" if abs(e[0] - e[1]) < 1e-9 else "THREE-eigenvalue (a != b)"
            print(f"     theta={th:.9f}   (a,b,g)=({e[0]:+.6f},{e[1]:+.6f},{e[2]:+.6f})   {eq}")
    return found


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


for n in (12, 14):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    print(f"n={n}   theta_0={theta0(n):.9f}   sqrt(3/2)={np.sqrt(1.5):.9f}")
    for k in range(2, n // 2 + 1):
        print(f"   split R^{k} + R^{n-k}   (k = so({k}) + so({n-k}))")
        solve_family(n, k, c, L2)
    print()
