"""
P0 step (1a): close the residual risk in Theorem 4.14 WITHOUT the multiplicity-free
Schur argument.

Reviewer 14's one unclosed gap: alpha <= 1/3 is verified at n = 8,10,12,14 but
asserted for all n >= 9 on the thesis's Lemma 4.13 (Schur), which is valid only
on multiplicity-free isotypic components.  If the
Pin(2).SU(2)_+ x SO(n-4)-decomposition of Weyl_n acquires multiplicities at large
n, that proof has a hole.

There is a cheaper and more robust reason the spectrum cannot depend on n.
W_CP2 is supported entirely inside Lambda^2(R^4), so the whole construction is
equivariant for G = SO(n-4) acting on the LAST n-4 coordinates and fixing R^4.
Hence F_u commutes with G and, decomposing

    Weyl_n  =  sum_lambda  M_lambda (x) V_lambda

into G-isotypic pieces (V_lambda irreducible, M_lambda the multiplicity space),
Schur forces

    F_u  =  sum_lambda  F_lambda (x) Id_{V_lambda},

with NO multiplicity-free hypothesis -- multiplicities are exactly what M_lambda
absorbs.  So spec(F_u) = union_lambda spec(F_lambda), and the claim becomes:
the list of lambdas occurring, the dimensions dim M_lambda, and the operators
F_lambda are all independent of n.  That is a statement about a FIXED
4-dimensional problem, which is why the eigenvalues are n-free.

This script tests exactly that.  It builds the SO(n-4) Casimir on Weyl_n,
splits Weyl_n into its eigenspaces (the isotypic pieces), and reports for each:
the Casimir value, the block dimension, and spec(F_u) restricted to it.  If the
per-lambda spectra and multiplicity-space dimensions agree across n, the
n-independence is structural rather than coincidental.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix

SQ32 = np.sqrt(1.5)


def so_lower_action(n, k=4):
    """Generators of so(n-k) acting on Lambda^2(R^n), fixing the first k coords.
    Returns a list of antisymmetric matrices rho(A) on Lambda^2."""
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    pidx = {p: t for t, p in enumerate(pairs)}
    gens = []
    for a in range(k, n):
        for b in range(a + 1, n):
            A = np.zeros((n, n)); A[a, b] = 1.0; A[b, a] = -1.0
            rho = np.zeros((len(pairs), len(pairs)))
            for (i, j), col in pidx.items():
                for m in range(n):
                    if A[i, m] != 0.0 and m != j:
                        p = (min(m, j), max(m, j))
                        rho[pidx[p], col] += A[i, m] * (1 if m < j else -1)
                    if A[j, m] != 0.0 and i != m:
                        p = (min(i, m), max(i, m))
                        rho[pidx[p], col] += A[j, m] * (1 if i < m else -1)
            gens.append(rho)
    return gens


def run(n):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, _ = fox_point(n, L2, Eflat, c)
    Nl = u.shape[0]
    M = F_matrix(u, c, Eflat)

    # SO(n-4) acts on operators by X -> [rho, X]; build the Casimir on Weyl_n
    gens = so_lower_action(n, 4)
    Cas = np.zeros((D, D))
    for rho in gens:
        # ad_rho as a matrix in the Weyl basis
        A = np.zeros((D, D))
        for b in range(D):
            H = Eflat[b].reshape(Nl, Nl)
            A[:, b] = Eflat @ (rho @ H - H @ rho).reshape(-1)
        Cas -= A @ A                      # -sum ad^2 = Casimir, psd
    Cas = 0.5 * (Cas + Cas.T)

    # check equivariance: F_u must commute with the whole action
    comm = 0.0
    for rho in gens[:6]:
        A = np.zeros((D, D))
        for b in range(D):
            H = Eflat[b].reshape(Nl, Nl)
            A[:, b] = Eflat @ (rho @ H - H @ rho).reshape(-1)
        comm = max(comm, np.max(np.abs(M @ A - A @ M)))
    print(f"n={n:3d}  dim Weyl={D:5d}   max |[F_u, ad_A]| over 6 generators = {comm:.2e}"
          f"   {'EQUIVARIANT' if comm < 1e-9 else 'NOT equivariant'}")

    ev, V = np.linalg.eigh(Cas)
    # group Casimir eigenvalues
    blocks, lo = [], 0
    while lo < len(ev):
        hi = lo
        while hi + 1 < len(ev) and abs(ev[hi + 1] - ev[lo]) < 1e-6 * max(1.0, abs(ev[lo])):
            hi += 1
        blocks.append((ev[lo], lo, hi))
        lo = hi + 1

    print(f"      SO({n-4})-isotypic blocks: {len(blocks)}")
    print(f"      {'Casimir':>10} {'blockdim':>9}  spec(F_u)/sqrt(3/2) on the block")
    for cv, lo, hi in blocks:
        B = V[:, lo:hi + 1]
        sub = B.T @ M @ B
        sv = np.linalg.eigvalsh(sub) / SQ32
        vals, i = [], 0
        svs = np.sort(sv)
        while i < len(svs):
            j = i
            while j + 1 < len(svs) and abs(svs[j + 1] - svs[i]) < 1e-7:
                j += 1
            vals.append(f"{svs[i]:+.4f}x{j-i+1}")
            i = j + 1
        print(f"      {cv:10.4f} {hi-lo+1:9d}  {'  '.join(vals)}")
    print()


if __name__ == "__main__":
    for n in (10, 12, 14):
        run(n)
