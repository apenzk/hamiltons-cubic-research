"""Check r310's live claim that the diagonal floor sits below the record's 1.025.

CHECKS A REPORTED FINDING independently of the reviewer's route. r310's census reports
a blow-up at n = 12, blocks (1,2,3,3,3), with theta = 0.745853, Delta = 1.7523 and
lambda_max(L_e) = 1.006944 -- below the 1.025 floor committed in 2293bc0 over 282
diagonal points. If a Delta > 0 diagonal point sits below 1.025, that floor is a
property of the population censused rather than a fact about the locus.

TWO PARAMETRISATIONS FAILED BEFORE THIS ONE, and both failed silently by returning
critical points that were not Weyl tensors:

  (a) the fixed three-value blow-up form (within, adjacent, non-adjacent) is critical
      only for EQUAL blocks -- residual 2.0e-01 at (1,2,3,3,3);
  (b) one free value per block pair solves criticality but leaves five of seven
      solutions off Weyl_n by 0.39 to 0.63 in norm, because a block-constant list of
      DIAGONAL ENTRIES is not a curvature tensor.

What makes a diagonal operator Weyl is the matrix M behind it: W = diag(M_ij) over
coordinate pairs, with M hollow, symmetric, and ZERO ROW SUM -- the last being
Ricci-flatness, which is the condition (b) omitted.  So the free parameters here are
the block-pair values of M, restricted to the zero-row-sum subspace, and every
solution is screened against Weyl_n regardless.
"""
import sys
import numpy as np
from scipy.optimize import fsolve

sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, Q
from b_defect_diagonal import W_of, delta_closed
from b_weyl_projector_free import weyl_project
from g1_le_machinery import lambda_max


def block_basis(sizes):
    """Basis of block-constant hollow symmetric zero-row-sum M matrices."""
    k = len(sizes)
    n = sum(sizes)
    lab = []
    for bi, b in enumerate(sizes):
        lab += [bi] * b
    raw = []
    keys = []
    for A in range(k):
        for B in range(A, k):
            if A == B and sizes[A] < 2:
                continue                      # a singleton block has no internal pair
            E = np.zeros((n, n))
            for i in range(n):
                for j in range(n):
                    if i != j and {lab[i], lab[j]} == {A, B}:
                        E[i, j] = 1.0
            raw.append(E)
            keys.append((A, B))
    raw = np.array(raw)
    # impose zero row sums: one linear condition per block
    C = np.array([[raw[t][sum(sizes[:A])].sum() for t in range(len(raw))]
                  for A in range(k)])
    _, _, Vt = np.linalg.svd(C)
    ns = Vt[np.linalg.matrix_rank(C):]
    return np.einsum('rt,tij->rij', ns, raw), keys


def solve(sizes, tries=200, rng_seed=0):
    basis, _ = block_basis(sizes)
    n = sum(sizes)
    m = len(basis)
    if m == 0:
        return [], n

    def M_of_c(c):
        M = np.einsum('r,rij->ij', c, basis)
        W = W_of(M)
        nrm = np.linalg.norm(W)
        return M / nrm, W / nrm

    def resid(c):
        M, W = M_of_c(c)
        QW = Q(n, W)
        th = float(np.tensordot(QW, W))
        R = np.diag(QW - th * W)
        pairs, _ = pair_index(n)
        Rm = np.zeros((n, n))
        for a, (i, j) in enumerate(pairs):
            Rm[i, j] = Rm[j, i] = R[a]
        return np.array([float((b * Rm).sum()) for b in basis])

    rng = np.random.default_rng(rng_seed)
    out = []
    for _ in range(tries):
        c = fsolve(resid, rng.standard_normal(m), full_output=False)
        M, W = M_of_c(c)
        QW = Q(n, W)
        th = float(np.tensordot(QW, W))
        r = float(np.linalg.norm(QW - th * W))
        off = float(np.linalg.norm(W - weyl_project(n, W)))
        if r < 1e-9 and th > 1e-6 and off < 1e-9:
            out.append((th, r, off, M, W))
    return out, n


if __name__ == '__main__':
    print("Delta>0 diagonal critical points, screened for Weyl membership.\n"
          "Record's committed floor: lambda_max(L_e) >= 1.025 over 282 points.\n"
          "r310 reports 1.006944 at n=12, blocks (1,2,3,3,3), theta=0.745853.\n",
          flush=True)
    lowest = None
    for sizes in [[1, 2, 3, 3, 3], [2, 2, 2, 3, 3], [1, 1, 2, 4, 4],
                  [2, 2, 2, 2, 2], [1, 2, 2, 3, 4], [3, 3, 3, 3]]:
        sols, n = solve(sizes)
        seen = []
        for th, r, off, M, W in sorted(sols, key=lambda s: -s[0]):
            if any(abs(th - t) < 1e-7 for t in seen):
                continue
            seen.append(th)
            D = delta_closed(M)
            if D <= 1e-8:
                continue
            th2, lam, res = lambda_max(W, n)
            mark = "  <-- BELOW 1.025" if lam < 1.025 else ""
            print(f"  n={n} blocks={tuple(sizes)}  theta={th:.6f}  Delta={D:.4f}  "
                  f"lambda_max(L_e)={lam:.6f}{mark}", flush=True)
            if lowest is None or lam < lowest[0]:
                lowest = (lam, n, tuple(sizes), th, D)
    if lowest:
        print(f"\n  LOWEST FOUND: lambda_max(L_e) = {lowest[0]:.6f} at n={lowest[1]} "
              f"blocks={lowest[2]}, theta={lowest[3]:.6f}, Delta={lowest[4]:.4f}",
              flush=True)
        print(f"  record's floor 1.025 is {'BROKEN' if lowest[0] < 1.025 else 'intact'} "
              f"on this population", flush=True)
    else:
        print("\n  no Delta>0 Weyl diagonal critical point found on these shapes",
              flush=True)
