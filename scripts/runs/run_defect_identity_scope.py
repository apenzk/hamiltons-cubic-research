"""Where the diagonal defect identity stops: the natural lift dies at CP^m.

On the diagonal locus, criticality turns the Petersen-Wink density into an affine
function of the eigenvalue (see scripts/lib/b_defect_diagonal.py):

    g_ab = 2 (s_a + s_b) - 4 theta M_ab ,      s_a = sum_b M_ab^2 .

The quantity s_a is Ric(W^2) in disguise -- for a diagonal W the operator square
W^2 has pair entries M_ab^2, so Ric(W^2)_aa = s_a -- and the pair (a,b) enters
through the derivation action of that Ricci tensor on Lambda^2.  So the coordinate-
free statement the diagonal identity SUGGESTS is

    g_gamma  =  2 <hatN v_gamma, v_gamma>  -  4 theta lambda_gamma ,
    N := Ric(W^2),   hatN(x ^ y) := Nx ^ y + x ^ Ny .                        (*)

THE ANSWER IS NO, AND THE WITNESSES ARE THE KAHLER POINTS.  (*) holds to machine
precision at every diagonal critical point tried, the C_5 blow-up included -- so it
is not a gradedness or symmetry artefact, since that point is ungraded.  It fails by
an O(1) margin at every CP^m, which are exactly the non-diagonal critical points:
the residual is 2.00, 2.22 and 2.33 at m = 2, 3, 4, against |g| of order 6, 3.3, 2.3.

WHAT THAT COSTS.  Route R10's live half is {critical, S = 0, Delta > 0}, and the
diagonal identity converts defect into a theta deficit there exactly.  This run says
the conversion is a fact about the diagonal locus and does not travel: a successor
must either find a different coordinate-free carrier for s_a, or work the
non-diagonal half by other means.  The diagonal half is granted by the problem
statement in any case, so (*) failing is where the interesting half begins.

The random Weyl rows are the control that (*) is not an identity on all of Weyl_n:
it fails off the critical set too, by 0.32 to 0.75.
"""
import sys
import numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, weyl_basis, sphere_product_W
from b_symmetry_defect import phis, cpm_W
from b_c5_blowup import c5_operator
from weyl_screen import theta_screened


def ric_of_pairmatrix(n, A):
    """Ricci contraction of the 4-tensor whose pair-basis matrix is A."""
    pairs, _ = pair_index(n)
    T = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            v = A[a, b]
            T[i, j, k, l] = v; T[j, i, k, l] = -v
            T[i, j, l, k] = -v; T[j, i, l, k] = v
    return np.einsum('ikjk->ij', T)


def hatN(n, N):
    """N as a derivation on Lambda^2, in the orthonormal pair basis."""
    pairs, _ = pair_index(n)
    P = phis(n) / np.sqrt(2.0)
    I = np.eye(n)
    out = np.zeros((len(pairs), len(pairs)))
    for a, (i, j) in enumerate(pairs):
        X = np.outer(N[:, i], I[j]) - np.outer(I[j], N[:, i]) \
            + np.outer(I[i], N[:, j]) - np.outer(N[:, j], I[i])
        out[:, a] = np.einsum('bij,ij->b', P, X) / np.sqrt(2.0)
    return out


def residual(n, W):
    W = W / np.linalg.norm(W)
    th, info = theta_screened(n, W)
    lam, V = np.linalg.eigh(W)
    P = phis(n)
    v = np.einsum('ag,gij->aij', V.T, P)
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    T = (0.5 * np.einsum('abij,cij->abc', br, v)) ** 2
    g = np.einsum('dab,ab->d', T, (lam[:, None] - lam[None, :]) ** 2)
    H = hatN(n, ric_of_pairmatrix(n, W @ W))
    pred = 2 * np.einsum('ga,gh,ha->a', V, H, V) - 4 * th * lam
    return th, float(np.abs(g - pred).max()), float(np.abs(g).max()), info['is_weyl']


def main():
    rows = []
    for blocks in ([6, 6], [3, 3], [3, 5], [4, 8]):
        rows.append((f"S^{blocks[0]} x S^{blocks[1]}", sum(blocks),
                     sphere_product_W(blocks)[0], "diagonal, graded"))
    W, n = c5_operator([2] * 5)
    rows.append(("C_5 blow-up", n, W, "diagonal, UNGRADED"))
    for m in (2, 3, 4):
        rows.append((f"CP^{m}", 2 * m, cpm_W(m), "NON-diagonal"))
    rng = np.random.default_rng(5)
    for n in (6, 8):
        B = weyl_basis(n)
        for t in range(2):
            rows.append((f"random Weyl #{t}", n,
                         np.tensordot(rng.normal(size=B.shape[0]), B, axes=([0], [0])),
                         "non-critical control"))

    print("=== (*)  g_gamma = 2 <hatN v, v> - 4 theta lambda,  N = Ric(W^2) ===")
    print(f"  {'point':22s}{'n':>3s}{'theta':>11s}{'residual':>11s}{'|g|max':>9s}  kind")
    for lbl, n, W, kind in rows:
        th, r, gm, ok = residual(n, W)
        flag = "exact" if r < 1e-12 else "FAILS"
        print(f"  {lbl:22s}{n:>3d}{th:>11.6f}{r:>11.2e}{gm:>9.3f}  {kind}   {flag}")
    print("\n  Exact at every DIAGONAL critical point, the ungraded C_5 blow-up included,")
    print("  so it is not an artefact of symmetry.  It FAILS at every CP^m, which are the")
    print("  non-diagonal critical points -- the identity is a fact about the diagonal")
    print("  locus and does not lift through Ric(W^2).")


if __name__ == '__main__':
    main()
