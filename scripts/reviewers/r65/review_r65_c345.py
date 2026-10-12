"""Reviewer 65 / C3 rigidity, C4 maximality criterion, C5 dimension spectrum.

C4: m isotropic extends iff there is w not in m with <[u,v],w> = 0 for all u,v in m.
    A triple containing w twice vanishes by antisymmetry, so the new vector's own
    brackets impose NO further condition -- the extension condition really is linear.
    Hence: maximal  <=>  [m,m]^perp = m  <=>  rank[m,m] = N - dim m, and
    rank[m,m] <= N - dim m holds automatically because [m,m] is contained in m^perp.
C5: additionally rank[m,m] <= C(d,2), so maximality FORCES d(d+1)/2 >= N.
    At n=6 (N=15) that rules out every d <= 4 outright.
    And the symmetric pair so(2)+so(4) gives an explicit MAXIMAL isotropic subspace
    of dimension 8, contradicting the claimed gap at 8.
"""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from review_r65_lib import (structure_tensor, orth, mu, iso_residual,
                            sympair_subspace, basis)
from review_r65_c2_search import descend


def bracket_span_rank(V, C, tol=1e-8):
    d = V.shape[1]
    rows = []
    for a in range(d):
        for b in range(a + 1, d):
            rows.append(np.einsum('ijk,i,j->k', C, V[:, a], V[:, b]))
    if not rows:
        return 0
    s = np.linalg.svd(np.array(rows), compute_uv=False)
    return int((s > tol * max(1.0, s[0])).sum())


def u_k_subspace(n):
    """m for the symmetric pair so(2k)/u(k):  {X in so(2k) : XJ + JX = 0}, dim k(k-1)."""
    k = n // 2
    J = np.zeros((n, n))
    for r in range(k):
        J[2 * r, 2 * r + 1] = 1.0
        J[2 * r + 1, 2 * r] = -1.0
    B, _ = basis(n)
    N = B.shape[0]
    # linear map L: so(n) -> so(n)-ish,  X |-> XJ + JX (symmetric-valued); use full n^2 target
    L = np.zeros((n * n, N))
    for i in range(N):
        L[:, i] = (B[i] @ J + J @ B[i]).ravel()
    U, s, Vt = np.linalg.svd(L)
    ker = Vt[(s > 1e-9).sum():].T if L.shape[1] > (s > 1e-9).sum() else np.zeros((N, 0))
    return ker


if __name__ == "__main__":
    n = 6
    C = structure_tensor(n); N = C.shape[0]
    print(f"n={n}, N={N}\n")
    print("A. combinatorial obstruction: maximality needs rank[m,m] = N-d and rank <= C(d,2),")
    print("   so d(d-1)/2 >= N-d, i.e. d(d+1)/2 >= N.")
    for d in range(1, N + 1):
        ok = d * (d + 1) // 2 >= N
        if d <= 8:
            print(f"     d={d}: C(d,2)={d*(d-1)//2:>3}  N-d={N-d:>3}  "
                  f"{'possible' if ok else 'IMPOSSIBLE -- always extends'}")
    print()
    print("B. structured isotropic subspaces at n=6 and their maximality")
    cands = [("so(1)+so(5) off-block", sympair_subspace(n, 1)),
             ("so(2)+so(4) off-block", sympair_subspace(n, 2)),
             ("so(3)+so(3) off-block", sympair_subspace(n, 3)),
             ("so(6)/u(3)  m-part  ", u_k_subspace(n))]
    for name, V in cands:
        if V.shape[1] == 0:
            continue
        d = V.shape[1]
        r = bracket_span_rank(V, C)
        print(f"     {name}  d={d:>2}  iso_res={iso_residual(V,C):.2e}  rank[m,m]={r:>2}  "
              f"N-d={N-d:>2}  -> {'MAXIMAL' if r == N-d else 'extends'}")
    print()
    print("C. random polished isotropic subspaces, maximality census (rank criterion)")
    rng = np.random.default_rng(6501)
    for d in range(2, 11):
        got = []
        for t in range(20):
            f, V = descend(C, d, rng, iters=3000)
            if f < 1e-16:
                got.append(bracket_span_rank(V, C))
        if not got:
            print(f"     d={d:>2}: NO isotropic subspace found in 20 polished starts")
            continue
        got = np.array(got)
        nmax = int((got == N - d).sum())
        print(f"     d={d:>2}: {len(got)}/20 isotropic; maximal {nmax}/{len(got)}; "
              f"rank[m,m] values {sorted(set(got.tolist()))} (N-d={N-d})")
