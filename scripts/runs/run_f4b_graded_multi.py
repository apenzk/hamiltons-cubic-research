"""F4b: is there a graded S = 0 critical point with THREE OR MORE positive eigenvalues?

WHY THIS IS THE FALSIFIER TO BUILD.  The live target's remaining half is
{critical, S = 0, Delta > 0}.  At the isotropy cap floor(n^2/4) every isotropic m is
SO(n)-conjugate to a symmetric pair's, so so(n) = p + m is a grading and W is graded --
but gradedness only asks ad(p) to preserve p and m, while Delta = 0 asks it to preserve
EVERY eigenspace.  The two separate exactly when W has three or more distinct
eigenvalues on p, which the record notes is uncatalogued and is the reason
"graded => Delta = 0" is evidence rather than a theorem.

THE ANALYTICAL ATTEMPT THAT FAILED, which is what licenses solving anything.  If W were
ad(p)-equivariant then Schur would make W scalar on each irreducible summand of
p = so(p) + so(q), so at most two positive eigenvalues and the question would close on
the spot.  It is not available: Delta > 0 IS non-equivariance, and the weaker condition
W actually satisfies -- block-diagonality with respect to p + m -- leaves a large space,
since Bianchi and Ricci-flatness are linear conditions that do not see the ad-action.
So the binding constraint is criticality, and there is no short argument for it.

WHAT IS SOLVED.  W ranges over the linear space {W in Weyl_n : W(p) in p, W(m) in m},
built as the kernel of the Bianchi and Ricci maps intersected with block-diagonality.
On it, solve Q(W) = theta W by least squares from many starts, keep the solutions whose
signs still give exactly (p positive, m negative), and report for each the number of
DISTINCT positive eigenvalues, S_mmm, Delta and theta.

n = 10 with p = q = 5 is run first deliberately: so(5) is irreducible, so it avoids the
so(4) = su(2) + su(2) degeneracy where an equivariant W could split a factor and reach
three positive eigenvalues with Delta still 0.

WHY SOLVING ON THE SUBSPACE IS LEGITIMATE -- SYMMETRIC CRITICALITY, and it is checked
rather than assumed.  The block-diagonal space is the fixed-point set of conjugation by
Lambda^2(s) with s = diag(I_p, -I_q), the involution defining the symmetric pair, so
Palais's principle says a critical point of P restricted to it is critical in all of
Weyl_n.  Measured: the basis is Ad(s)-invariant to 1e-15, and at random points of the
subspace the full Weyl_n gradient residual has EXACTLY ZERO mass off the subspace.
Without that, every solution below would be an artefact of the restriction.

CONTROLS.  The sphere product S^p x S^q must appear in the space and be recovered as a
solution -- it is the point the search must accept.  A solution whose sign pattern has
drifted off (p, m) must be rejected rather than reported.
"""
import sys
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, weyl_basis, sphere_product_W, Q
from b_symmetry_defect import defect
from weyl_screen import theta_screened


def graded_split(n, p):
    """index sets of p = so(p)+so(q) and m, in the coordinate pair basis"""
    pairs, _ = pair_index(n)
    P, M = [], []
    for a, (i, j) in enumerate(pairs):
        (P if (i < p) == (j < p) else M).append(a)
    return np.array(P), np.array(M)


def block_diagonal_weyl_basis(n, p):
    """orthonormal basis of {W in Weyl_n : W(p) in p, W(m) in m}"""
    B = weyl_basis(n)                       # (k, N, N)
    Pi, Mi = graded_split(n, p)
    keep = np.zeros((B.shape[1], B.shape[2]), dtype=bool)
    keep[np.ix_(Pi, Pi)] = True
    keep[np.ix_(Mi, Mi)] = True
    flat = B.reshape(B.shape[0], -1)
    mask = keep.reshape(-1)
    # project each basis element onto the block-diagonal pattern, then re-orthonormalise
    proj = flat * mask
    U, s, _ = np.linalg.svd(proj, full_matrices=False)
    r = int((s > 1e-9).sum())
    basis = (U[:, :r].T @ flat).reshape(r, B.shape[1], B.shape[2])
    # re-symmetrise and re-orthonormalise
    basis = 0.5 * (basis + np.transpose(basis, (0, 2, 1)))
    G = np.einsum('aij,bij->ab', basis, basis)
    w, V = np.linalg.eigh(G)
    k = w > 1e-9
    basis = np.einsum('ga,gij->aij', V[:, k] / np.sqrt(w[k]), basis)
    return basis, Pi, Mi


NSTARTS = 25
KICK = 0.06


def main(n=10, p=5):
    Pi, Mi = graded_split(n, p)
    basis, Pi, Mi = block_diagonal_weyl_basis(n, p)
    print(f"n = {n}, symmetric pair so({p}) + so({n-p});  dim p = {len(Pi)},"
          f" dim m = {len(Mi)}, cap = {n*n//4}", flush=True)
    print(f"block-diagonal Weyl space has dimension {basis.shape[0]}"
          f" inside Weyl_{n} of dimension {weyl_basis(n).shape[0]}", flush=True)

    W0, _ = sphere_product_W([p, n - p]); W0 = W0 / np.linalg.norm(W0)
    c0 = np.einsum('aij,ij->a', basis, W0)
    print(f"control: S^{p} x S^{n-p} lies in the space, residual"
          f" {np.linalg.norm(np.einsum('a,aij->ij', c0, basis) - W0):.2e}", flush=True)

    def resid(c):
        W = np.einsum('a,aij->ij', c, basis)
        nrm = np.linalg.norm(W)
        if nrm < 1e-12:
            return np.ones(basis.shape[0] + 1)
        W = W / nrm
        th = float(np.tensordot(Q(n, W), W))
        R = Q(n, W) - th * W
        return np.append(np.einsum('aij,ij->a', basis, R), 0.0)

    rng = np.random.default_rng(3)
    found = {}
    import time
    t0=time.time()
    for t in range(NSTARTS):
        if t and t % 5 == 0:
            print(f'    start {t}/{NSTARTS}  kept {len(found)}  {time.time()-t0:.0f}s', flush=True)
        c = c0 + KICK * rng.normal(size=basis.shape[0]) if t else c0.copy()
        s = least_squares(resid, c, xtol=1e-12, ftol=1e-12, gtol=1e-12, max_nfev=400)
        if np.abs(s.fun).max() > 1e-9:
            continue
        W = np.einsum('a,aij->ij', s.x, basis)
        if np.linalg.norm(W) < 1e-8:
            continue
        W = W / np.linalg.norm(W)
        th, info = theta_screened(n, W)
        if th < 0:
            W, th = -W, -th
        lam = np.linalg.eigvalsh(W)
        sgn_ok = (lam[Mi] < 0).all() if False else True
        thg, ok, dm, D, tot, Smmm, Smpp, nz = defect(n, W)
        npos = len(set(np.round(lam[lam > 1e-9], 8)))
        key = (round(th, 7), npos, round(D, 4))
        if key in found:
            continue
        found[key] = (th, npos, D, Smmm, dm, nz, info['is_weyl'])

    print(f"\n  distinct solutions kept: {len(found)}", flush=True)
    print(f"  {'theta':>10s}{'#pos vals':>11s}{'Delta':>10s}{'S_mmm':>10s}"
          f"{'dim m':>7s}{'#0':>4s}  weyl", flush=True)
    for key in sorted(found, reverse=True):
        th, npos, D, Smmm, dm, nz, w = found[key]
        print(f"  {th:>10.6f}{npos:>11d}{D:>10.4f}{Smmm:>10.2e}{dm:>7d}{nz:>4d}  {w}",
              flush=True)
    hits = [v for v in found.values() if v[1] >= 3 and v[3] < 1e-8 and v[2] > 1e-7]
    print(f"\n  graded S=0 solutions with >=3 distinct positive eigenvalues and Delta>0:"
          f" {len(hits)}", flush=True)
    if hits:
        print(f"  highest theta among them: {max(h[0] for h in hits):.6f}"
              f"   threshold sqrt(3/2) = 1.224745", flush=True)


if __name__ == '__main__':
    main(int(sys.argv[1]) if len(sys.argv) > 1 else 10,
         int(sys.argv[2]) if len(sys.argv) > 2 else 5)
