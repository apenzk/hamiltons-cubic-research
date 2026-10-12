"""Reviewer 57: counterexamples to 'non-diagonalisable  <=>  unitary isotropy'.

The valid half of the record's argument is:

    W coordinate-diagonal in the frame F  ==>  Iso(W) contains F D_n F^{-1},
    the diagonal sign group; in particular Iso(W) contains an element whose
    (-1)-eigenspace has ODD dimension (n even).  Elements of U(n/2) have even
    (-1)-multiplicity, so unitary isotropy ==> not coordinate-diagonalisable.

The converse -- the direction the enumeration actually uses -- is what is tested
here.  A critical point whose isotropy CONTAINS an odd reflection, and which is
still not coordinate-diagonalisable, refutes it.

Two constructions:
  (1) padded W_CP2 -- the record's own 'Fox S^4(alpha)' -- whose isotropy
      contains O(n-4) acting on the padding;
  (2) orthogonal BLOCK SUMS  W_1 (+) W_2  on complementary coordinate blocks,
      critical by the harmonic-square law  theta^{-2} = theta_1^{-2}+theta_2^{-2},
      with S = 0 whenever both summands have S = 0, non-diagonalisable whenever
      one summand is, and isotropy containing O(p) x O(q) reflections.
"""
import itertools
import numpy as np

from review_r57_core import Alg, Weyl, slack_structural, slack_theta_identity, ricci, bianchi_defect
from review_r57_points import (sphere_product, w_cp2, su_m_kahler, pad, block_sum,
                               unit, orient, crit_residual, commutant_on_weyl, u_m_gens,
                               c5_blowup)
from review_r57_diag import Diagonaliser, odm, decomposability_certificate


def isotropy_algebra_dim(alg, W, tol=1e-8):
    """dim {A in so(n) : [ad(A), W] = 0}."""
    n = alg.n
    gens = []
    for i, j in itertools.combinations(range(n), 2):
        A = np.zeros((n, n)); A[i, j] = 1.0; A[j, i] = -1.0
        gens.append(A)
    rows = []
    for A in gens:
        ad = alg.ad(A)
        rows.append((ad @ W - W @ ad).ravel())
    M = np.array(rows).T
    s = np.linalg.svd(M, compute_uv=False)
    return len(gens) - int(np.sum(s > tol * max(1.0, s[0]))), gens


def sign_flips_in_isotropy(alg, W, tol=1e-9):
    """Which coordinate sign flips diag(+-1) fix W?  Returns the maximal set of
    single-coordinate flips that do, and whether any element of the group they
    generate has odd (-1)-multiplicity."""
    n = alg.n
    ok = []
    for i in range(n):
        R = np.eye(n); R[i, i] = -1.0
        L = alg.lam2(R)
        if np.linalg.norm(L @ W @ L.T - W) < tol:
            ok.append(i)
    return ok


def unitary_isotropy(alg, W, tol=1e-7):
    """Is there a complex structure J in so(n) commuting with the whole isotropy
    ALGEBRA?  (Necessary for the isotropy to sit inside a U(n/2).)  Reported as
    the dimension of the centraliser of the isotropy algebra."""
    n = alg.n
    d, gens = isotropy_algebra_dim(alg, W)
    # basis of the isotropy algebra
    rows = []
    for A in gens:
        ad = alg.ad(A)
        rows.append((ad @ W - W @ ad).ravel())
    M = np.array(rows).T
    u, s, vt = np.linalg.svd(M)
    rank = int(np.sum(s > 1e-8 * max(1.0, s[0])))
    iso = [sum(row[k] * gens[k] for k in range(len(gens))) for row in vt[rank:]]
    # centraliser of iso inside so(n)
    C = []
    for A in gens:
        C.append(np.concatenate([(A @ X - X @ A).ravel() for X in iso]) if iso else np.zeros(1))
    Mc = np.array(C).T
    sc = np.linalg.svd(Mc, compute_uv=False)
    cdim = len(gens) - int(np.sum(sc > 1e-8 * max(1.0, sc[0])))
    return d, cdim, iso


def report(label, n, W, starts=8):
    alg = Alg.get(n)
    th, res = crit_residual(alg, W)
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    Sabs, Sfrac = slack_structural(alg, W)
    Sth = slack_theta_identity(alg, W)
    d, cdim, iso = unitary_isotropy(alg, W)
    flips = sign_flips_in_isotropy(alg, W)
    D = Diagonaliser.get(n)
    o, R = D.best(W, starts=starts, seed=13)
    print(f"{label}\n   n={n}  theta={th:.6f} ({th/th0:.4f} theta_0)  crit={res:.2e}  "
          f"ric={np.abs(ricci(alg,W)).max():.1e} bianchi={np.abs(bianchi_defect(alg,W)).max():.1e}")
    print(f"   S_struct={Sabs:.3e}  S_frac={Sfrac:.3e}  S_theta={Sth:.3e}")
    print(f"   dim isotropy algebra={d}   dim centraliser of it={cdim}   "
          f"single-coordinate sign flips in Iso(W): {flips}")
    print(f"   odm(as built)={odm(W):.6f}   odm* (min over O(n))={o:.6f}")
    return dict(theta=th, ratio=th / th0, S=Sabs, odm=o, flips=flips)


if __name__ == "__main__":
    print("=" * 100)
    print("A. the record's own 'Fox S^4(alpha)' = padded W_CP2: NON-diagonalisable, and its")
    print("   isotropy contains coordinate reflections, so it is NOT unitary.")
    print("=" * 100)
    report("padded W_CP2 -> n=8", 8, w_cp2(8))
    report("padded W_CP2 -> n=12", 12, w_cp2(12))

    print()
    print("=" * 100)
    print("B. orthogonal block sums: critical, S = 0, NON-diagonalisable, non-unitary isotropy,")
    print("   and absent from the unitary-isotropy enumeration.")
    print("=" * 100)
    W1 = w_cp2(4)
    Wss = sphere_product(8, [list(range(4)), list(range(4, 8))])
    report("W_CP2 (+) S^4xS^4, n=12", 12,
           block_sum(12, W1, [0, 1, 2, 3], Wss, list(range(4, 12))))
    W35 = sphere_product(8, [[0, 1, 2], [3, 4, 5, 6, 7]])
    report("W_CP2 (+) S^3xS^5, n=12", 12,
           block_sum(12, W1, [0, 1, 2, 3], W35, list(range(4, 12))))
    W33 = sphere_product(6, [[0, 1, 2], [3, 4, 5]])
    report("W_CP2 (+) S^3xS^3, n=10", 10,
           block_sum(10, W1, [0, 1, 2, 3], W33, list(range(4, 10))))
    report("W_CP2 (+) W_CP2, n=8", 8,
           block_sum(8, W1, [0, 1, 2, 3], W1, [4, 5, 6, 7]))

    print()
    print("=" * 100)
    print("C. controls: points that ARE coordinate-diagonal must show odm* = 0 and a full")
    print("   set of sign flips.")
    print("=" * 100)
    report("S^6xS^6, n=12", 12, sphere_product(12, [list(range(6)), list(range(6, 12))]))
    report("C_5 blow-up, n=10", 10, c5_blowup(10, [2, 2, 2, 2, 2]))
