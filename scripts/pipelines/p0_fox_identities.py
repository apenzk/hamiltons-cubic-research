"""
Fox's Theorem 3.2 applied to the Weyl algebra: two identities never used here.

Fox (arXiv:1901.04012) Theorem 3.2: a Euclidean metrized commutative algebra on
which a Lie group acts irreducibly by isometric automorphisms is exact and
Killing metrized.  SO(n) acts irreducibly on MC_W by isometric automorphisms, so
both conclusions apply to this project's setting, where P is the algebra's cubic
form, critical points are idempotents, and F_u IS the multiplication operator
L(u) of the idempotent u:

  (1)  tr L(x) = 0                     for every x
  (2)  tr( L(x) L(y) ) = kappa h(x,y)  for a single nonzero kappa

and at a unit idempotent, kappa = 1 + sum_i lambda_i^2 over the spectrum of L(u).

These constrain the eigenvalue multiplicities twice over -- against the
eigenvalues, and against their squares -- and the second must give the SAME kappa
at every idempotent, including ones whose spectra differ.  Checked here for
W_CP2 against the multiplicity formulas already established.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix
from review_r11_graded_law import weyl_sphere_product_mop

SQ32 = np.sqrt(1.5)


def spectrum_report(name, W, n, c, Eflat, D):
    Nl = W.shape[0]
    M = F_matrix(W, c, Eflat)
    ev = np.linalg.eigvalsh(M)
    th = float(np.sum(W * Q_full(W, c)))
    tr1 = float(np.sum(ev))
    tr2 = float(np.sum(ev ** 2))
    print(f"   {name:22s} theta={th:.9f}  dim={D}")
    print(f"      (1) tr L      = {tr1:+.3e}   {'ZERO' if abs(tr1) < 1e-8 * max(1, D) else 'NONZERO'}")
    print(f"      (2) tr L^2    = {tr2:.6f}   (kappa per unit idempotent, after scaling)")
    return th, tr1, tr2


def run(n):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    print(f"n={n}")
    u, _, _ = fox_point(n, L2, Eflat, c)
    a = spectrum_report("W_CP2", u, n, c, Eflat, D)
    k = n // 2
    Ws = weyl_sphere_product_mop(L2, k, n - k)
    Ws = Ws / np.linalg.norm(Ws)
    if float(np.sum(Ws * Q_full(Ws, c))) < 0:
        Ws = -Ws
    b = spectrum_report(f"S^{k} x S^{n-k}", Ws, n, c, Eflat, D)
    # Theorem 3.2 is stated for UNIT vectors, so the RAW values must agree --
    # dividing by theta^2 compares quantities the identity does not mention and
    # manufactures a discrepancy.
    kap = (2 * n - 1) * (n - 1) / 4.0
    print(f"      tr L^2 :  W_CP2 {a[2]:.6f}   sphere {b[2]:.6f}"
          f"   predicted (2n-1)(n-1)/4 = {kap:.6f}"
          f"   {'AGREE' if max(abs(a[2]-kap), abs(b[2]-kap)) < 1e-6 else 'DIFFER'}")
    # the cross term is vacuous between these two -- they are orthogonal -- so
    # test the bilinear form on a random pair with nonzero inner product instead
    rng = np.random.default_rng(0)
    x = (Eflat.T @ rng.normal(size=D)).reshape(Nl, Nl); x = 0.5 * (x + x.T); x /= np.linalg.norm(x)
    y = (Eflat.T @ rng.normal(size=D)).reshape(Nl, Nl); y = 0.5 * (y + y.T); y /= np.linalg.norm(y)
    lhs = float(np.sum(F_matrix(x, c, Eflat) * F_matrix(y, c, Eflat)))
    ip = float(np.sum(x * y))
    print(f"      tr L(x)L(y) = {lhs:+.6f}   kappa <x,y> = {kap*ip:+.6f}"
          f"   |diff| {abs(lhs - kap*ip):.2e}   (random non-critical pair)")
    print(flush=True)


if __name__ == "__main__":
    for n in (8, 10, 12):
        run(n)
