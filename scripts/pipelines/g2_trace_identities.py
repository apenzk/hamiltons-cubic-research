"""Two exact trace identities for the multiplication operator, and the
reformulation of the conjecture they give.

Weyl_n is an irreducible O(n)-module, so any invariant tensor built from the
algebra is forced:

  (T1)  tr(L_e) = 0 at every critical point.  The trace is <e, tau> with
        tau = sum_k B_k o B_k an invariant element of Weyl_n, hence zero.

  (T2)  tr(L_x L_y) = kappa_W <x,y> with kappa_W = (2n-1)(n-1)/4, an invariant
        symmetric bilinear form on an irreducible module.  This is the Killing
        constant of Fox's algebra, computed independently in this project.

Together, at a critical point with e = W/theta,

        theta^2 = kappa_W / ||L_e||_F^2 ,

so MAXIMISING P is exactly MINIMISING the Frobenius norm of the multiplication
operator over the critical set -- with the spectrum pinned by lambda = 1 once
(e itself), lambda = 1/2 on the orbit tangent, and sum lambda = 0.

The bound this yields via Cauchy-Schwarz on the unpinned part is loose by a
factor 1.5 (trivial stabiliser) to 2.0 (sphere product), so it does not close
the conjecture; it constrains symmetry-free points hardest, which is the
population no construction or search reaches.
"""
import itertools

import numpy as np

from g1_le_machinery import weyl_basis, Le_matrix
from rsharp_basis_free import Q_full


def kappa_W(n):
    return (2*n - 1)*(n - 1)/4.0


def check_identities(n, seed=0):
    N, c, L2, alt_idx, B = weyl_basis(n)
    rng = np.random.default_rng(seed)
    ratios = []
    for _ in range(6):
        x = np.einsum('k,kmn->mn', rng.normal(size=len(B)), B)
        y = np.einsum('k,kmn->mn', rng.normal(size=len(B)), B)
        ratios.append(float(np.trace(Le_matrix(x, B, c) @ Le_matrix(y, B, c)))
                      / float(np.sum(x*y)))
    return min(ratios), max(ratios), kappa_W(n)


def at_critical_point(n, W):
    """Returns theta, tr(L_e), ||L_e||_F^2 and theta^2 ||L_e||^2 (= kappa_W)."""
    N, c, L2, alt_idx, B = weyl_basis(n)
    W = W/np.linalg.norm(W)
    QW = Q_full(W, c)
    th = float(np.sum(W*QW))
    assert np.linalg.norm(QW - th*W) < 1e-7, "not a critical point"
    M = Le_matrix(W/th, B, c)
    ev = np.linalg.eigvalsh(M)
    return th, float(np.trace(M)), float(np.sum(ev**2)), th*th*float(np.sum(ev**2))


def cs_bound(n, orbit):
    """theta^2 <= kappa_W / [1 + orb/4 + (1+orb/2)^2/(D-1-orb)]."""
    D = n*(n+1)*(n+2)*(n-3)//12
    den = 1 + orbit/4 + (1 + orbit/2)**2/(D - 1 - orbit)
    return np.sqrt(kappa_W(n)/den)


if __name__ == "__main__":
    print("(T2) tr(L_x L_y) / <x,y>, against (2n-1)(n-1)/4")
    for n in (5, 6, 8):
        lo, hi, k = check_identities(n)
        print(f"  n={n}: measured [{lo:.6f}, {hi:.6f}]  predicted {k:.6f}")
    print("\nbound vs theta_0")
    for n in (8, 12, 20):
        t0 = np.sqrt(2*(n-1)*(n-2))/n
        print(f"  n={n:3d}: sphere-product orbit {cs_bound(n,(n//2)**2)/t0:.2f}x, "
              f"trivial stabiliser {cs_bound(n, n*(n-1)//2)/t0:.2f}x")
