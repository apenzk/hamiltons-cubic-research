"""T1: does Krasnov-Tkachev's fusion rule discriminate graded from ungraded?

At an extremal idempotent, KT Proposition 6.7 gives

    A_c(1/2) A_c(1/2)  contained in  A_c(1/2)^perp,

equivalently <z^2, z> = 0 for z in A_c(1/2), proven by third- and
fourth-variation conditions along the 1/2-eigenspace.

It was adopted because it constrains PRODUCTS OF EIGENVECTORS rather than
spectra, which is what the project's recorded obstruction demands of any new
tool.  The measurement here closes it as a discriminator: the rule holds at the
ungraded points too -- 1e-15 at the su(3) bi-invariant and at so(3) in so(5),
alongside the maximizers -- and fails only at (S^3)^3, by 0.46 relative, which
is the non-primitive point.  What it tracks is primitivity of the idempotent,
and non-primitivity already forces lambda_max = 1 by an argument on record.

Unexercised: the fourth-order INEQUALITY, as opposed to the third-order
identity measured below.
"""
import numpy as np

from g1_le_machinery import weyl_basis, Le_matrix
from rsharp_basis_free import Q_full


def fusion_defect(n, W, samples=8, seed=0):
    """Returns (dim A(1/2), relative component of products landing back inside
    A(1/2), max |<z^2,z>| over samples, multiplicity of lambda = 1).

    The rule holds when the second entry is at machine precision.
    """
    N, c, L2, alt_idx, B = weyl_basis(n)
    W = W/np.linalg.norm(W)
    QW = Q_full(W, c)
    th = float(np.sum(W*QW))
    assert np.linalg.norm(QW - th*W) < 1e-7, "not a critical point"
    M = Le_matrix(W/th, B, c)
    ev, U = np.linalg.eigh(M)
    half = U[:, np.abs(ev - 0.5) < 1e-8]
    mult_one = int(np.sum(np.abs(ev - 1.0) < 1e-8))
    k = half.shape[1]
    if k == 0:
        return 0, float('nan'), float('nan'), mult_one

    def circ(X, Y):
        return 0.5*(Q_full(X + Y, c) - Q_full(X, c) - Q_full(Y, c))

    rng = np.random.default_rng(seed)
    worst = 0.0
    cube = 0.0
    for _ in range(samples):
        Z1 = np.einsum('i,imn->mn', half @ rng.normal(size=k), B)
        Z2 = np.einsum('i,imn->mn', half @ rng.normal(size=k), B)
        Z1 /= np.linalg.norm(Z1)
        Z2 /= np.linalg.norm(Z2)
        co = np.einsum('imn,mn->i', B, circ(Z1, Z2))
        worst = max(worst,
                    np.linalg.norm(half.T @ co)/max(np.linalg.norm(co), 1e-30))
        cube = max(cube, abs(float(np.sum(Z1*circ(Z1, Z1)))))
    return k, worst, cube, mult_one
