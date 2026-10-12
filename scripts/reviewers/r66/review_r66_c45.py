"""Reviewer 66 / C4+C5: the maximality rank criterion, and the spectrum of
maximal isotropic dimensions in so(n).

C4: m isotropic extends iff some w outside m lies in [m,m]^perp; the condition
on w is linear (omega(u,v,w)=0 for u,v in m) because triples repeating w die by
antisymmetry.  Hence maximal <=> [m,m]^perp = m <=> rank[m,m] = N - dim m,
and rank[m,m] <= N - dim m always holds for isotropic m.

C5: the spectrum at n=6.  Checked three ways: (i) every symmetric pair,
(ii) every edge-maximal triangle-free graph (coordinate subspaces),
(iii) random polished isotropic subspaces of each dimension.
"""
import itertools, sys
import numpy as np
from review_r66_core import basis, ip, omega_tensor, isotropy_mass, symmetric_pair
from review_r66_c2_search import hunt


def bracket_span(W, V, tol=1e-9):
    """rank of span{[u,v] : u,v in m} in the phi basis, given orthonormal V."""
    N, d = V.shape
    cols = []
    for i in range(d):
        for j in range(i + 1, d):
            cols.append(np.einsum('abc,a,b->c', W, V[:, i], V[:, j]))
    if not cols:
        return 0, np.zeros((N, 0))
    A = np.array(cols).T
    u, s, _ = np.linalg.svd(A, full_matrices=True)
    r = int((s > tol * max(1.0, s[0])).sum())
    return r, u[:, :r]


def report(W, V, name):
    N, d = V.shape
    mass, _ = isotropy_mass(W, V)
    r, _ = bracket_span(W, V)
    maximal = (r == N - d)
    print(f"  {name:34s} dim={d:2d} mass={mass:.1e} rank[m,m]={r:2d} "
          f"N-d={N-d:2d} -> {'MAXIMAL' if maximal else 'EXTENDS by ' + str(N-d-r)}")
    return maximal, r


def maximal_triangle_free_graphs(n):
    """All edge-maximal triangle-free graphs on n labelled vertices, up to nothing."""
    E = list(itertools.combinations(range(n), 2))
    m = len(E)
    idx = {e: t for t, e in enumerate(E)}

    def tri_free(mask):
        for a, b, c in itertools.combinations(range(n), 3):
            if (mask >> idx[(a, b)] & 1) and (mask >> idx[(a, c)] & 1) and (mask >> idx[(b, c)] & 1):
                return False
        return True

    out = []
    for mask in range(1 << m):
        if not tri_free(mask):
            continue
        if all((mask >> t & 1) or not tri_free(mask | (1 << t)) for t in range(m)):
            out.append(mask)
    return out, E


if __name__ == '__main__':
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 6
    W, idx = omega_tensor(n)
    N = W.shape[0]
    print(f"=== so({n}), N={N}, floor(n^2/4)={n*n//4} ===")

    print("\n-- C4 sanity: rank[m,m] <= N - d for isotropic m, and > for non-isotropic --")
    rng = np.random.default_rng(3)
    for d in [4, 7, 9]:
        Q, _ = np.linalg.qr(rng.normal(size=(N, d)))
        mass, _ = isotropy_mass(W, Q)
        r, _ = bracket_span(W, Q)
        print(f"  random (NON-isotropic) d={d}: mass={mass:.2f} rank[m,m]={r} vs N-d={N-d} "
              f"({'violates the isotropic bound, as it must' if r > N-d else 'ok'})")

    print("\n-- every symmetric pair --")
    dims_sym = {}
    for p in range(1, n // 2 + 1):
        V = symmetric_pair(n, p)
        mx, r = report(W, V, f"so({p})+so({n-p}) off-diagonal")
        if mx: dims_sym[V.shape[1]] = True

    print("\n-- every edge-maximal triangle-free graph (coordinate subspaces) --")
    masks, E = maximal_triangle_free_graphs(n)
    seen = {}
    for mask in masks:
        S = [t for t in range(len(E)) if mask >> t & 1]
        V = np.zeros((N, len(S)))
        for k, t in enumerate(S):
            V[t, k] = 1.0
        r, _ = bracket_span(W, V)
        d = len(S)
        key = (d, r == N - d)
        seen.setdefault(key, 0)
        seen[key] += 1
    print(f"  {len(masks)} edge-maximal triangle-free graphs on {n} labelled vertices")
    for (d, mx) in sorted(seen):
        print(f"    dim {d:2d}: {seen[(d,mx)]:5d} graphs, isotropic-subspace-maximal = {mx}")
    print(f"  => coordinate maximal-isotropic dimensions: "
          f"{sorted({d for (d, mx) in seen if mx})}")

    print("\n-- random polished isotropic subspaces, per dimension --")
    for d in range(2, n * n // 4 + 2):
        cnt_max = 0; trials = 0; masses = []
        for s in range(8):
            best, V = hunt(n, d, starts=1, seed=9000 + 100 * d + s, verbose=False)
            masses.append(best)
            if best > 1e-18:
                continue
            trials += 1
            r, _ = bracket_span(W, V)
            if r == N - d:
                cnt_max += 1
        status = "no isotropic subspace found" if trials == 0 else f"{cnt_max}/{trials} maximal"
        print(f"  d={d:2d}: {status}   (best mass {min(masses):.2e})")
