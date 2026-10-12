"""
W*'s Hessian spectrum from the SO(k) x SO(l) decomposition, rather than fitted.

The five rational families in the Hessian spectrum at the balanced sphere product
were fitted on n = 6..14 and confirmed on a held-out n = 16.  What is owed is a
derivation: where the values and multiplicities come from.

The route is the one that worked at the CP^2 point.  There, F_u commutes with the
stabiliser and the isotypic decomposition gives F_u = sum_lambda F_lambda (x) Id,
with the multiplicity spaces and their spectra independent of n -- which is what
made the eigenvalue list dimension-free.  W* has stabiliser SO(k) x SO(l), and
Nienhaus Ch. 4.2 decomposes Weyl_n under exactly that group, so the same
mechanism should apply and the five families should be the F_lambda spectra.

This splits Weyl_n by the SO(k) x SO(l) Casimir, restricts F_{W*} to each block,
and reports the block dimensions and spectra.  If the multiplicity spaces and
per-block spectra are n-independent, the five families are explained; if the
spectra vary with n, the fit is capturing something the decomposition does not.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import F_matrix
from review_r11_graded_law import weyl_sphere_product_mop
from p3b_morse_bott_spheres import gens_so_kl


def run(n):
    k = n // 2
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    W = weyl_sphere_product_mop(L2, k, n - k)
    W = W / np.linalg.norm(W)
    th = float(np.sum(W * Q_full(W, c)))
    if th < 0:
        W, th = -W, -th
    Nl = W.shape[0]
    M = F_matrix(W, c, Eflat)

    gs = gens_so_kl(n, k)
    Cas = np.zeros((D, D))
    comm = 0.0
    for t, rho in enumerate(gs):
        A = np.zeros((D, D))
        for b in range(D):
            H = Eflat[b].reshape(Nl, Nl)
            A[:, b] = Eflat @ (rho @ H - H @ rho).reshape(-1)
        Cas -= A @ A
        comm = max(comm, np.max(np.abs(M @ A - A @ M)))
    Cas = 0.5 * (Cas + Cas.T)

    print(f"n={n:3d}  k={k}  dim Weyl={D}  theta={th:.9f}")
    print(f"      max |[F_W*, ad_A]| = {comm:.1e}"
          f"   {'EQUIVARIANT' if comm < 1e-8 else 'NOT equivariant'}")

    ev, V = np.linalg.eigh(Cas)
    blocks, lo = [], 0
    while lo < len(ev):
        hi = lo
        while hi + 1 < len(ev) and abs(ev[hi + 1] - ev[lo]) < 1e-6 * max(1.0, abs(ev[lo])):
            hi += 1
        blocks.append((ev[lo], lo, hi))
        lo = hi + 1
    print(f"      SO({k})xSO({n-k})-blocks: {len(blocks)}")
    print(f"      {'Casimir':>10} {'dim':>6}   Hessian spectrum (6F - 3theta)/theta on the block")
    for cv, a, b in blocks:
        B = V[:, a:b + 1]
        sub = B.T @ (6 * M - 3 * th * np.eye(D)) @ B
        sv = np.sort(np.linalg.eigvalsh(sub)) / th
        vals, i = [], 0
        while i < len(sv):
            jj = i
            while jj + 1 < len(sv) and abs(sv[jj + 1] - sv[i]) < 1e-7:
                jj += 1
            vals.append(f"{sv[i]:+.4f}x{jj-i+1}")
            i = jj + 1
        print(f"      {cv:10.3f} {b-a+1:>6}   {'  '.join(vals[:6])}")
    print(flush=True)


if __name__ == "__main__":
    for n in (8, 10, 12):
        run(n)
