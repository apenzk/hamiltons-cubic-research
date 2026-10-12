"""Reviewer 66: independent re-implementation of the so(n) Cartan-3-form setting.

Provides: orthonormal basis of so(n), the Cartan 3-form omega(x,y,z)=<[x,y],z>
with <X,Y> = (1/2)tr(X^T Y), isotropy test, symmetric-pair subspaces, and the
triangle-free / Mantel dictionary.  Written from the problem statement only.
"""
import itertools
import numpy as np


def basis(n):
    """Orthonormal basis phi_{ij} = E_ij - E_ji, i<j, of so(n)."""
    B, idx = [], []
    for i in range(n):
        for j in range(i + 1, n):
            M = np.zeros((n, n))
            M[i, j] = 1.0
            M[j, i] = -1.0
            B.append(M)
            idx.append((i, j))
    return np.array(B), idx


def ip(X, Y):
    return 0.5 * np.trace(X.T @ Y)


def omega_tensor(n):
    """omega_{abc} = <[e_a,e_b],e_c> in the phi basis."""
    B, idx = basis(n)
    N = len(B)
    W = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = B[a] @ B[b] - B[b] @ B[a]
            for c in range(N):
                W[a, b, c] = ip(C, B[c])
    return W, idx


def omega_from_matrices(x, y, z):
    return ip(x @ y - y @ x, z)


def isotropy_mass(W, V):
    """V: N x d with orthonormal columns (coords in phi basis).  Returns
    sum over ordered triples of omega(v_a,v_b,v_c)^2."""
    C = np.einsum('abc,ai,bj,ck->ijk', W, V, V, V, optimize=True)
    return float(np.sum(C * C)), C


def symmetric_pair(n, p):
    """Off-block-diagonal part of so(p)+so(q), q=n-p, as columns in phi basis."""
    _, idx = basis(n)
    N = len(idx)
    cols = []
    for t, (i, j) in enumerate(idx):
        if (i < p) != (j < p):
            v = np.zeros(N); v[t] = 1.0
            cols.append(v)
    return np.array(cols).T


if __name__ == '__main__':
    print("=== omega conventions ===")
    for n in [4, 5, 6]:
        W, idx = omega_tensor(n)
        N = len(idx)
        # total antisymmetry
        asym = max(np.abs(W + np.transpose(W, (1, 0, 2))).max(),
                   np.abs(W - np.transpose(W, (1, 2, 0))).max())
        # support: which triples are nonzero
        supp = [(idx[a], idx[b], idx[c]) for a in range(N) for b in range(a+1, N)
                for c in range(b+1, N) if abs(W[a, b, c]) > 1e-12]
        vals = sorted(set(round(abs(W[a, b, c]), 12) for a in range(N)
                          for b in range(N) for c in range(N) if abs(W[a,b,c]) > 1e-12))
        ntri = len(list(itertools.combinations(range(n), 3)))
        print(f"n={n} N={N} antisym_err={asym:.2e} #nonzero_unordered_triples={len(supp)} "
              f"(#triangles in K_n = {ntri}) |values|={vals}")
        # check omega(x,y,z) = -tr(xyz)
        B, _ = basis(n)
        rng = np.random.default_rng(0)
        x, y, z = [sum(rng.normal()*b for b in B) for _ in range(3)]
        print(f"   omega(x,y,z)={omega_from_matrices(x,y,z):.10f}  -tr(xyz)={-np.trace(x@y@z):.10f}")

    print("\n=== symmetric pairs are isotropic; Mantel dictionary ===")
    for n in range(3, 9):
        W, idx = omega_tensor(n)
        best = 0
        for p in range(0, n + 1):
            V = symmetric_pair(n, p)
            if V.size == 0:
                continue
            mass, _ = isotropy_mass(W, V)
            best = max(best, V.shape[1])
            assert mass < 1e-20, (n, p, mass)
        print(f"n={n}: all symmetric pairs isotropic; max dim {best}, floor(n^2/4)={n*n//4}")

    print("\n=== coordinate subspaces: isotropic <=> triangle-free graph ===")
    for n in [4, 5, 6]:
        W, idx = omega_tensor(n)
        N = len(idx)
        bad = 0
        best_tf = 0
        for mask in range(1 << N):
            S = [t for t in range(N) if mask >> t & 1]
            if not S:
                continue
            edges = [idx[t] for t in S]
            tri = any(len({a, b, c}) == 3 and
                      tuple(sorted((a, b))) in map(tuple, edges) and
                      tuple(sorted((a, c))) in map(tuple, edges) and
                      tuple(sorted((b, c))) in map(tuple, edges)
                      for a in range(n) for b in range(a+1, n) for c in range(b+1, n))
            V = np.zeros((N, len(S)))
            for k, t in enumerate(S):
                V[t, k] = 1.0
            iso = isotropy_mass(W, V)[0] < 1e-20
            if iso == tri:
                bad += 1
            if iso:
                best_tf = max(best_tf, len(S))
        print(f"n={n}: mismatches iso vs triangle-free: {bad}; max isotropic coordinate dim {best_tf} "
              f"= Mantel {n*n//4}")
