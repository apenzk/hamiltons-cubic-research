"""
Is every graded critical point Morse-Bott nondegenerate?  Sphere products, via
the published SO(k) x SO(l) decomposition.

WHY THIS CLOSES THE CRUX.  A critical point is Morse-Bott nondegenerate when
ker(Hess) equals the tangent space to the critical orbit through it.  If every
graded critical point is nondegenerate, each graded orbit is ISOLATED in
Crit(P) -- no nearby critical point outside the orbit -- so the graded set is a
union of connected components of Crit(P).  The remaining components are compact
with S > 0, hence S >= c > 0 there, and the exact theta formula turns that into
theta below the graded ceiling.  No estimate anywhere.

LITERATURE.  Nienhaus (arXiv:2311.02404) Prop 4.6 and Ch. 4.2 decompose Weyl_n
under SO(k) x SO(l) for any k + l = n, and identify the orbit tangent space
explicitly as R^k (x) R^l, of dimension k*l:

    T_{W_{S^k x S^l}} SO(n).W_{S^k x S^l}  ~=  R^k (x) R^l          [line 3910]

    Weyl_n = <W> + Weyl_k + Weyl_l + T(orbit) + S^2_0(R^k) + S^2_0(R^l)
             + S^2_0(R^k)(x)S^2_0(R^l) + Lambda^2_+(R^k)(x)Lambda^2(R^l)
             + Lambda^2_-(R^k)(x)Lambda^2(R^l) + X_k(x)R^l + X_l(x)R^k

His Ch. 4.4 computes the Hessian only at W_CP2; there is no sphere-product
analogue of Thm 4.14 in the thesis, which is the open item this fills.

Method, as in p0_schur_free.py: F_W commutes with SO(k) x SO(l), so splitting
Weyl_n by that group's Casimir gives F_W = sum F_lambda (x) Id, with no
multiplicity-free hypothesis needed.  Reported per block: the Casimir value, the
block dimension, and spec(F_W) there; then ker(Hess P) against k*l.

CORRECTED AFTER REVIEW.  The kernel identity holds for every two-block sphere
product EXCEPT S^3 x S^3, where Lambda^2(R^3) (x) Lambda^2(R^3) = R^3 (x) R^3 is
the orbit's own representation and the kernel is 18 against an orbit of 9 -- an
isomorphism holding for no other (k,l), so the exception is the split, not the
dimension (S^2 x S^4 at the same n = 6 is fine).  Schur is NOT the mechanism:
the kernel is still 18 under O(3) x O(3), where the decomposition IS
multiplicity-free, because multiplicity-freeness forces one scalar per piece but
never forces the scalars apart.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from review_r11_graded_law import weyl_sphere_product_mop


def gens_so_kl(n, k):
    """so(k) + so(l) acting on Lambda^2(R^n)."""
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    pidx = {p: t for t, p in enumerate(pairs)}
    out = []
    for (lo, hi) in ((0, k), (k, n)):
        for a in range(lo, hi):
            for b in range(a + 1, hi):
                A = np.zeros((n, n)); A[a, b] = 1.0; A[b, a] = -1.0
                rho = np.zeros((len(pairs), len(pairs)))
                for (i, j), col in pidx.items():
                    for m in range(n):
                        if A[i, m] != 0.0 and m != j:
                            p = (min(m, j), max(m, j))
                            rho[pidx[p], col] += A[i, m] * (1 if m < j else -1)
                        if A[j, m] != 0.0 and i != m:
                            p = (min(i, m), max(i, m))
                            rho[pidx[p], col] += A[j, m] * (1 if i < m else -1)
                out.append(rho)
    return out


def orbit_dim(W, n, Eflat):
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    pidx = {p: t for t, p in enumerate(pairs)}
    vecs = []
    for a in range(n):
        for b in range(a + 1, n):
            A = np.zeros((n, n)); A[a, b] = 1.0; A[b, a] = -1.0
            rho = np.zeros((len(pairs), len(pairs)))
            for (i, j), col in pidx.items():
                for m in range(n):
                    if A[i, m] != 0.0 and m != j:
                        p = (min(m, j), max(m, j))
                        rho[pidx[p], col] += A[i, m] * (1 if m < j else -1)
                    if A[j, m] != 0.0 and i != m:
                        p = (min(i, m), max(i, m))
                        rho[pidx[p], col] += A[j, m] * (1 if i < m else -1)
            vecs.append(Eflat @ (rho @ W - W @ rho).reshape(-1))
    sv = np.linalg.svd(np.array(vecs), compute_uv=False)
    return int(np.sum(sv > 1e-8 * max(sv[0], 1e-300)))


def run(n, k):
    l = n - k
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    W = weyl_sphere_product_mop(L2, k, l)
    W = W / np.linalg.norm(W)
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    if th < 0:
        W, th = -W, -th
        QW = Q_full(W, c)
    res = np.linalg.norm(QW - th * W) / np.linalg.norm(QW)
    Nl = W.shape[0]

    M = np.zeros((D, D))
    for b in range(D):
        Hb = Eflat[b].reshape(Nl, Nl)
        M[:, b] = Eflat @ ((Q_full(W + Hb, c) - Q_full(W - Hb, c)) / 4.0).reshape(-1)
    M = 0.5 * (M + M.T)

    print(f"S^{k} x S^{l}   n={n}  dim Weyl={D}  theta={th:.9f}  res={res:.1e}")

    gs = gens_so_kl(n, k)
    Cas = np.zeros((D, D))
    comm = 0.0
    for t, rho in enumerate(gs):
        A = np.zeros((D, D))
        for b in range(D):
            Hb = Eflat[b].reshape(Nl, Nl)
            A[:, b] = Eflat @ (rho @ Hb - Hb @ rho).reshape(-1)
        Cas -= A @ A
        comm = max(comm, np.max(np.abs(M @ A - A @ M)))   # all generators, not a sample
    Cas = 0.5 * (Cas + Cas.T)
    print(f"      max |[F_W, ad_A]| = {comm:.1e}  {'EQUIVARIANT' if comm < 1e-8 else 'NOT'}")

    ev, V = np.linalg.eigh(Cas)
    blocks, lo = [], 0
    while lo < len(ev):
        hi = lo
        while hi + 1 < len(ev) and abs(ev[hi + 1] - ev[lo]) < 1e-6 * max(1.0, abs(ev[lo])):
            hi += 1
        blocks.append((ev[lo], lo, hi))
        lo = hi + 1
    print(f"      SO({k})xSO({l})-blocks: {len(blocks)}")
    half = 0
    for cv, a, b in blocks:
        Bk = V[:, a:b + 1]
        sv = np.linalg.eigvalsh(Bk.T @ M @ Bk) / th
        vals, i = [], 0
        svs = np.sort(sv)
        while i < len(svs):
            j = i
            while j + 1 < len(svs) and abs(svs[j + 1] - svs[i]) < 1e-7:
                j += 1
            if abs(svs[i] - 0.5) < 1e-7:
                half += j - i + 1
            vals.append(f"{svs[i]:+.4f}x{j-i+1}")
            i = j + 1
        print(f"       Cas={cv:9.3f}  dim {b-a+1:5d}   {'  '.join(vals[:7])}")

    w = Eflat @ W.reshape(-1)
    Bc = np.linalg.svd(np.outer(w, w))[0][:, 1:]
    H = Bc.T @ (6 * M - 3 * th * np.eye(D)) @ Bc
    hev = np.linalg.eigvalsh(H)
    kd = int(np.sum(np.abs(hev) < 1e-7))
    od = orbit_dim(W, n, Eflat)
    print(f"      spec(F)/theta = 1/2 total: {half}   (k*l = {k*l})")
    print(f"      ker(Hess P) = {kd},  orbit = {od},  k*l = {k*l}   "
          f"{'MORSE-BOTT NONDEGENERATE' if kd == od == k*l else 'DEGENERATE'}")
    print(f"      next Hessian eigenvalue below 0: {hev[len(hev)-kd-1]:+.6f}\n", flush=True)


if __name__ == "__main__":
    for (n, k) in ((8, 4), (10, 5), (12, 6), (12, 5), (14, 7)):
        run(n, k)
