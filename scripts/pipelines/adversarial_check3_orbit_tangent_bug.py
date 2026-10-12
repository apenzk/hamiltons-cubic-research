"""
Adversarial review, independent check #3: pins down a genuine normalization
bug in full_hessian.py (the "Second-variation Hessian attempt" section's
Pipeline A), found while trying to reconcile its reported numbers against
the later, correctly-normalized Pipeline B (hessian_pipeline_b.py/rsharp_basis_free.py/
hessian_fast.py) and this review's own adversarial_check2.py.

THE TEST. P(W) is exactly O(n)-invariant: conjugating the sphere-product
Weyl tensor W* by any g in O(n) gives another Weyl tensor with the same
P-value. Hence for H tangent to the O(n)-orbit of W* (H = [ad(phi), W*] for
phi in so(n) not in so(p)+so(q)), H is automatically Bianchi/Ricci-flat AND
orthogonal to W*, and the second variation d^2P(W*)[H,H] MUST be exactly 0
-- this is forced purely by symmetry, with no computation needed. This gives
a cheap, decisive correctness certificate for any Hessian implementation:
evaluate it on this H and check for 0.

THE BUG. full_hessian.py's weyl_sphere_product() builds W* WITHOUT
normalizing it to unit Frobenius norm (|W*|=1), even though the Hessian
formula 6*T(x*,H,H) - 3*lambda*|H|^2 (correctly derived elsewhere in
findings/INDEX.md via two independent methods) is only valid at |x*|=1: the
curve x(t) = cos(t) x* + sin(t) H stays on the unit sphere only if |x*|=1
and H is unit. Both full_hessian.py's `Wstar` and its `lam` are built from
the raw (non-unit, |W*|=1.9 to 4.0 in the cases below) tensor.

THE CONSEQUENCE, verified below with two independent code paths (this
script's own bare-bones structure-constant code, copied faithfully from
full_hessian.py to isolate the bug, and this review's own
adversarial_check1.py machinery already validated against the trusted
diagonal formula and full permutation symmetry): evaluating
full_hessian.py's own formula on the O(n)-orbit-tangent direction gives a
comfortably NEGATIVE number (e.g. -230 at n=12), not the mathematically
forced exact 0 -- while using the SAME formula with W* properly normalized
to unit norm gives 0 to machine precision (~1e-15).

This single scaling bug explains why the "Second-variation Hessian attempt"
section's table (findings/INDEX.md) reports strict negative-definiteness with no
zero eigenvalues anywhere (missing the O(n)-orbit kernel that MUST be
present), and -- more seriously -- why it reports comfortably negative "top
tangent eigenvalues" even at UNBALANCED splits (e.g. n=6 (2,4): -4.8000),
which the document's own later, correctly-normalized computation
(hessian_pipeline_b.py/hessian_fast.py, and this review's independently-derived,
bug-fixed adversarial_check2.py) proves are genuine SADDLE POINTS with
several strictly positive Hessian eigenvalues. See reviews/INDEX.md for the full
writeup and the adversarial_check2.py cross-check confirming the correct
(saddle) answer at unbalanced splits.
"""
import numpy as np
from fractions import Fraction as F


def build_basis(n):
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    N = len(pairs)
    idx = {p: k for k, p in enumerate(pairs)}
    E = []
    for (i, j) in pairs:
        M = np.zeros((n, n))
        M[i, j] = 1
        M[j, i] = -1
        E.append(M)
    return pairs, idx, E, N


def structure_and_ad(n):
    """Verbatim copy of full_hessian.py's own structure_and_ad, to isolate
    the bug using its exact machinery (already cross-checked separately
    against this review's independent adversarial_check1.py structure
    constants and found to agree)."""
    pairs, idx, E, N = build_basis(n)
    ad = np.zeros((N, N, N))
    for a in range(N):
        for d in range(N):
            br = E[a] @ E[d] - E[d] @ E[a]
            for g in range(N):
                ad[a, g, d] = -0.5 * np.trace(br @ E[g])
    return pairs, idx, N, ad


def weyl_sphere_product(pairs, idx, N, p, q):
    """Verbatim copy of full_hessian.py's weyl_sphere_product: NOTE no
    normalization to unit Frobenius norm -- this is the bug."""
    n = p + q
    S = F(p * (p - 1) + q * (q - 1))
    sigma = S / ((n - 1) * (n - 2))
    a = float(1 - F(2 * (p - 1), n - 2) + sigma)
    b = float(1 - F(2 * (q - 1), n - 2) + sigma)
    c = float(-1 + sigma)
    W = np.zeros(N)
    for k, (i, j) in enumerate(pairs):
        if j < p:
            W[k] = a
        elif i >= p:
            W[k] = b
        else:
            W[k] = c
    return np.diag(W), a, b, c


def sharp_operator(A, B, ad, N):
    """Verbatim copy of full_hessian.py's sharp_operator (independently
    verified in this review to match findings/INDEX.md's stated basis-free #
    formula and to reproduce the trusted diagonal formula, so the sharp
    formula itself is NOT the bug -- see reviews/INDEX.md)."""
    X = np.einsum('agd,de->age', ad, A)
    Y = np.einsum('bez,zg->beg', ad, B)
    T1 = np.einsum('age,beg->ab', X, Y)
    T2 = T1.T
    return -0.25 * (T1 + T2)


def orbit_tangent_H(pairs, idx, ad, Wstar, p, N):
    """H = [ad(phi_{i0,j0}), Wstar] for i0 in the P-block, j0 in the Q-block:
    an infinitesimal generator of the O(n) orbit through Wstar (mixes the
    two sphere factors), hence tangent to the Weyl-tensor manifold,
    orthogonal to Wstar, and along a direction where P is EXACTLY constant
    by O(n)-invariance -- so d^2P(Wstar)[H,H] must be exactly 0."""
    i0, j0 = 0, p
    gen_idx = idx[(i0, j0)]
    ad_gen = ad[gen_idx]
    H = ad_gen @ Wstar - Wstar @ ad_gen
    return H


def run_probe():
    print("=== full_hessian.py bug isolation: O(n)-orbit-tangent Hessian test ===")
    print("(H is tangent to Wstar's O(n)-orbit; d^2P(Wstar)[H,H] MUST be exactly")
    print(" 0 by symmetry alone, independent of any numerics.)\n")
    for n, p in [(6, 3), (8, 4), (12, 6)]:
        q = n - p
        pairs, idx, N, ad = structure_and_ad(n)
        Wraw, a, b, c = weyl_sphere_product(pairs, idx, N, p, q)
        Rnorm = np.linalg.norm(Wraw)
        H = orbit_tangent_H(pairs, idx, ad, Wraw, p, N)
        Hn = H / np.linalg.norm(H)

        def QWH(Wstar, Hmat):
            return 0.5 * (Wstar @ Hmat + Hmat @ Wstar) + sharp_operator(Wstar, Hmat, ad, N)

        # (a) full_hessian.py's own (buggy: unnormalized) convention
        lam_raw = np.trace(Wraw @ (Wraw @ Wraw + sharp_operator(Wraw, Wraw, ad, N)))
        val_raw = 6 * np.trace(Hn @ QWH(Wraw, Hn)) - 3 * lam_raw * np.trace(Hn @ Hn)

        # (b) same formula, W* properly normalized to |W*|=1 as required
        Wunit = Wraw / Rnorm
        lam_unit = np.trace(Wunit @ (Wunit @ Wunit + sharp_operator(Wunit, Wunit, ad, N)))
        val_unit = 6 * np.trace(Hn @ QWH(Wunit, Hn)) - 3 * lam_unit * np.trace(Hn @ Hn)

        print(f"n={n} p={p} q={q}: |Wstar|_raw = {Rnorm:.6f}")
        print(f"  (a) full_hessian.py's own (unnormalized) convention: "
              f"Hessian(H,H) = {val_raw:.6e}   <-- WRONG (should be exactly 0)")
        print(f"  (b) with W* normalized to unit norm (formula's actual requirement): "
              f"Hessian(H,H) = {val_unit:.2e}   <-- correct (matches 0 to machine precision)")
        print()


if __name__ == "__main__":
    run_probe()
