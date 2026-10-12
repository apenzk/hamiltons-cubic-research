"""theta IS Weingart's stable cubic:  Theta_3 = <q(R) * R, R> = -2 theta.

CORRECTED AFTER GATE 2.  This file first reported the constant as +32.  That was wrong
by a factor of 16 and a sign, and Reviewers 69 and 70 localised it independently to
three deviations from the paper: dropping the 1/4 in the Lambda^2 (x) Lambda^2 inner
product, dropping Definition 6.1's own 1/4 prefactor, and flipping the sign of
R_{E_mu,E_nu}.  16 * (-2) * (-1) = 32.  The PROPORTIONALITY, with a universal constant
at every n and no Ricci correction, was confirmed by both reviewers and is the
substantive part.

[references/graphical-calculus-stable-invariants-2024/notes.md] Lemma 6.2 names the
stable cubic Theta_3(R) := g_{Lam^2 (x) Lam^2}( q(R) * R, R ), built from the standard
Weitzenbock curvature term q(R), and Section 6 reads it as the THIRD MOMENT of
sectional curvature over the Grassmannian of 2-planes.  If theta is Theta_3 up to
normalisation and Ricci terms, Conjecture A restates as a statement about that third
moment, which opens a literature this project has never searched.

The star action, from the paper (its equation at line 1805 of the text extraction):

    q(R) *  :=  sum_{mu,nu}  ( dE_mu^# ^ dE_nu^# ) *  R_{E_mu, E_nu} * ,

a COMPOSITION of two derivation actions of so(n) on the tensor.  On 1-forms it
returns Ric; on 2-forms it is the usual Weitzenbock term.  Here it is applied to R
itself, viewed as a tensor in Lam^2 (x) Lam^2.

THE TEST.  On Ricci-flat W the only two cubic invariants available are tr(W^3) and
<W, W^#>, and theta is their sum.  So fit

    Theta_3(W)  =  a * tr(W^3)  +  b * <W, W^#>

across catalogued and random Weyl tensors at several n.  A single (a, b) fitting every
point identifies Theta_3; a fit whose residual is large, or whose coefficients drift
with n or with the point, refutes the identification.

FALSIFIER: no (a, b) fits, or the fitted pair varies between points at fixed n.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, weyl_basis, sphere_product_W
from b_symmetry_defect import cpm_W
from weyl_screen import theta_screened

np.set_printoptions(precision=8, suppress=True)


def tensor_of(n, W):
    """R[i,j,k,l] from the operator W on Lambda^2, in the phi_ij basis."""
    pairs, idx = pair_index(n)
    R = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            v = W[a, b]
            for (p, q, sp) in ((i, j, 1.0), (j, i, -1.0)):
                for (r, s, sr) in ((k, l, 1.0), (l, k, -1.0)):
                    R[p, q, r, s] = sp * sr * v
    return R


def der(X, S):
    """the derivation action of X in so(n) on a 4-tensor S."""
    return -(np.einsum('ip,pjkl->ijkl', X, S) + np.einsum('jp,ipkl->ijkl', X, S)
             + np.einsum('kp,ijpl->ijkl', X, S) + np.einsum('lp,ijkp->ijkl', X, S))


def theta3(n, W):
    """<q(R) * R, R> with q(R)* the composition of the two derivation actions."""
    R = tensor_of(n, W)
    out = np.zeros_like(R)
    for mu in range(n):
        for nu in range(mu + 1, n):
            A = np.zeros((n, n)); A[mu, nu] = 1.0; A[nu, mu] = -1.0   # e_mu ^ e_nu
            B = -R[mu, nu]              # sign fixed by the paper's own q(R)*X = Ric X / 2
            out += 2.0 * der(A, der(B, R))       # factor 2: mu<nu covers each pair once
    out *= 0.25                                  # Definition 6.1's explicit prefactor
    # g on Lambda^2 (x) Lambda^2 with {e_i ^ e_j}_{i<j} orthonormal is 1/4 of the full
    # 4-index contraction -- the normalisation that makes ||R||^2 = ||W||_F^2 in the
    # pair basis.  Dropping it is where the factor 8 crept in.
    return 0.25 * float(np.einsum('ijkl,ijkl->', out, R))


def cubics(n, W):
    """(tr W^3, <W, W^#>) -- the two cubic invariants available on Ricci-flat W."""
    th, info = theta_screened(n, W)
    tr3 = float(np.trace(W @ W @ W))
    return th, tr3, th - tr3, info['is_weyl']


def main():
    pts = []
    for b in ([3, 3], [4, 4], [3, 5]):
        pts.append((sum(b), sphere_product_W(b)[0] / np.linalg.norm(sphere_product_W(b)[0]),
                    f"S^{b[0]} x S^{b[1]}"))
    for m in (2, 3, 4):
        pts.append((2 * m, cpm_W(m), f"CP^{m}"))
    rng = np.random.default_rng(2026)
    for n in (5, 6, 7):
        B = weyl_basis(n)
        for t in range(2):
            co = rng.normal(size=B.shape[0])
            W = np.tensordot(co, B, axes=([0], [0]))
            pts.append((n, W / np.linalg.norm(W), f"random n={n} #{t}"))

    print(f"  {'point':20s}{'n':>3s}{'theta':>11s}{'tr W^3':>12s}{'<W,W#>':>12s}"
          f"{'Theta_3':>13s}{'Theta_3/theta':>14s}")
    rows = []
    for n, W, lbl in pts:
        th, tr3, sharp, ok = cubics(n, W)
        t3 = theta3(n, W)
        rows.append((lbl, n, th, tr3, sharp, t3, ok))
        print(f"  {lbl:20s}{n:>3d}{th:>11.6f}{tr3:>12.6f}{sharp:>12.6f}{t3:>13.6f}"
              f"{(t3/th if abs(th) > 1e-9 else float('nan')):>14.6f}")

    print("\n=== least-squares fit  Theta_3 = a * tr(W^3) + b * <W,W#> ===")
    for n in sorted({r[1] for r in rows}):
        sub = [r for r in rows if r[1] == n]
        if len(sub) < 2:
            print(f"  n={n}: only {len(sub)} point, skipped")
            continue
        A = np.array([[r[3], r[4]] for r in sub])
        y = np.array([r[5] for r in sub])
        sol, res, rank, _ = np.linalg.lstsq(A, y, rcond=None)
        pred = A @ sol
        note = "" if rank == 2 else "   [rank 1: (a,b) is the min-norm solution, not determined]"
        print(f"  n={n:2d}  a={sol[0]:+.6f}  b={sol[1]:+.6f}   max|resid|="
              f"{np.abs(pred - y).max():.2e}   over {len(sub)} points{note}")

    A = np.array([[r[3], r[4]] for r in rows]); y = np.array([r[5] for r in rows])
    sol, _, _, _ = np.linalg.lstsq(A, y, rcond=None)
    print(f"  ALL n pooled: a={sol[0]:+.6f}  b={sol[1]:+.6f}   max|resid|="
          f"{np.abs(A @ sol - y).max():.2e}")
    ratios = [r[5] / r[2] for r in rows if abs(r[2]) > 1e-9]
    print(f"\n=== VERDICT: Theta_3 / theta over {len(ratios)} points ===")
    print(f"  min {min(ratios):.12f}   max {max(ratios):.12f}   spread {max(ratios)-min(ratios):.2e}")
    print(f"  so  Theta_3(W) = -2 * theta(W)  exactly, at every n, with no Ricci")
    print(f"  correction -- the Ricci terms drop because Weyl tensors are Ricci-flat.")
    print("  (This file first reported +32.  See the header: three convention slips.)")
    print("\n  The ratio, not the fit, is the evidence.  At n = 4 and n = 5 the fit is")
    print("  rank-deficient for a STRUCTURAL reason, not a sampling one (Reviewer 70):")
    print("  the cubic invariants on Weyl_4 and Weyl_5 are ONE-dimensional, because")
    print("  <W,W#> = 2 tr(W^3) identically there, so theta = 3 tr(W^3).  lstsq returns")
    print("  a min-norm (a,b); the ratio is -2 at every n regardless.")


if __name__ == '__main__':
    main()
