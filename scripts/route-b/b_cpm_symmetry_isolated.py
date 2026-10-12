"""CP^m is critical BECAUSE its symmetry pins it: dim Weyl_{2m}^{U(m)} = 1.

WHY THIS IS THE RIGHT QUESTION.  The non-diagonal census attains its maximum, exactly
sqrt(3/2), at W_CP^2 and nowhere else, so the extremal mechanism lives there.  Fence post
22 closed ker Phi_W as a handle on theta.  What is left is the u(m)-isotypic structure.

THE MECHANISM, and it is one line.  If K is a subgroup of SO(n) and the K-invariant
subspace of Weyl_n is ONE-dimensional, then the invariant W is automatically CRITICAL:
Q is O(n)-equivariant, so Q(W) is again K-invariant, hence a multiple of W.  Criticality
needs no computation at all -- only the uniqueness.

    dim Weyl_{2m}^{U(m)}  measured:   m = 2: 1 of 10      m = 3: 1 of 84
                                      m = 4: 1 of 300

computed as the nullity of W -> [ad(X), W] over a basis of u(m) = {X in so(2m) : XJ = JX},
restricted to Weyl_n.  So CP^m is the unique U(m)-invariant Weyl tensor up to scale.

RELATION TO THE RECORDED SUBALGEBRA FAMILY.  The record's item 12 asks for
(Lambda^4 R^n)^K = 0 AND dim Weyl_n^K = 1, and concludes the invariant W is critical with
TWO eigenvalues.  CP^m has THREE eigenvalues, so it is outside that family -- but it is
critical anyway, because the equivariance argument above uses ONLY dim Weyl^K = 1.  The
(Lambda^4)^K = 0 hypothesis is doing other work there, not carrying criticality.

WHAT THIS BUYS.  It explains why CP^m is the equality case rather than merely observing
it: the point is forced by its symmetry group, so the extremal problem restricted to
U(m)-invariant tensors is zero-dimensional and theta is a function of m alone -- which is
exactly Lemma 28's closed form theta^2 = (m+1)(2m-1)/(3m(m-1)), maximised at m = 2 with
value 3/2.

WHAT IT DOES NOT BUY.  It says nothing about non-diagonal S = 0 points with NO symmetry,
which is where the target's proof has to live.  Recorded so that is not mistaken for
progress on the target itself.

FALSIFIER: dim Weyl^{U(m)} > 1 at some m, or a K-invariant Weyl tensor with
dim Weyl^K = 1 that is not critical.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import weyl_basis
from b_symmetry_defect import phis, cpm_W
from weyl_screen import critical_screened


def um_generators(m):
    """u(m) = {X in so(2m) : XJ = JX}, as real skew matrices."""
    n = 2 * m
    J = np.zeros((n, n))
    for t in range(m):
        J[2 * t, 2 * t + 1] = 1.0
        J[2 * t + 1, 2 * t] = -1.0
    P = phis(n)
    N = P.shape[0]
    M = np.array([(P[a] @ J - J @ P[a]).ravel() for a in range(N)])
    w, V = np.linalg.eigh(M @ M.T)
    return [np.einsum('a,aij->ij', V[:, i], P) for i in range(N) if w[i] < 1e-9], J


def ad_on_lambda2(n, X, P):
    N = P.shape[0]
    D = np.zeros((N, N))
    for b in range(N):
        Y = X @ P[b] - P[b] @ X
        D[:, b] = 0.5 * np.einsum('aij,ij->a', P, Y)
    return D


def dim_invariant_weyl(m):
    n = 2 * m
    P = phis(n)
    B = weyl_basis(n)
    D = B.shape[0]
    gens, _ = um_generators(m)
    blocks = []
    for X in gens:
        Dx = ad_on_lambda2(n, X, P)
        blocks.append(np.array([(Dx @ B[d] - B[d] @ Dx).ravel() for d in range(D)]))
    A = np.concatenate(blocks, axis=1)
    sv = np.linalg.svd(A, compute_uv=False)
    rank = int((sv > 1e-8 * max(1.0, sv[0])).sum())
    return D - rank, D, len(gens)


def main():
    print(f"  {'m':>3s}{'n':>4s}{'dim u(m)':>10s}{'dim Weyl_n':>12s}"
          f"{'dim Weyl^U(m)':>15s}{'theta':>11s}{'crit res':>11s}")
    for m in (2, 3, 4):
        n = 2 * m
        dinv, D, g = dim_invariant_weyl(m)
        th, info = critical_screened(n, cpm_W(m))
        assert dinv == 1, f"invariant space is {dinv}-dimensional at m={m}"
        print(f"  {m:>3d}{n:>4d}{g:>10d}{D:>12d}{dinv:>15d}{th:>11.6f}"
              f"{info['crit_res']:>11.1e}")

    print("\n  dim Weyl^{U(m)} = 1 at every m tested, so CP^m is the UNIQUE U(m)-invariant")
    print("  Weyl tensor up to scale.  Criticality then follows with no computation: Q is")
    print("  O(n)-equivariant, so Q(W) is U(m)-invariant, hence a multiple of W.")
    print("\n  This EXPLAINS the equality case rather than observing it -- the extremal")
    print("  problem restricted to U(m)-invariant tensors is zero-dimensional, so theta is")
    print("  a function of m alone, which is Lemma 28's closed form, maximised at m = 2 at")
    print("  exactly 3/2.")
    print("\n  It says NOTHING about non-diagonal S = 0 points with no symmetry, which is")
    print("  where the target's proof has to live.  Not progress on the target itself.")


if __name__ == '__main__':
    main()
