"""A complete diagonal S = 0 census at small n, run over graphs instead of starts.

WHY NOT SAMPLING.  Fence post 13: multistart methods cannot census the diagonal
critical set.  Root-finding cannot converge to degenerate zeros at all -- the C_5
blow-up is recovered 0/20 from seeds 0.05 away -- and least_squares, which can
(5/20 from the same seeds), still never finds it from 150 random starts in 35
dimensions, nor the two-block sphere product: the set has dozens of branches with
tiny basins and random starts sample a biased slice of them.

WHAT REPLACES IT.  On the diagonal subspace, S = 0 is exactly triangle-freeness of
the negative graph, so the enumeration can run over GRAPHS.  For each triangle-free
G on n vertices, seed w negative on the edges and nonnegative off them, solve
criticality, and keep the solution only if its own negative graph is still G.  At
n = 6 and 7 every edge set can be enumerated outright -- 2^15 and 2^21 -- so the
census is complete rather than sampled.

WHAT IT TESTS.  Whether every diagonal S = 0 critical point is a blow-up, i.e.
block-constant with fewer blocks than vertices.  That is the diagonal analogue of
the enumeration question Reviewers 56/57 refuted on the non-diagonal side, and it
is the last thing B1 owes.

THE CONTROL THAT MATTERS.  Seeded on the C_5 blow-up's own negative graph at
n = 10 -- 20 edges, triangle-free -- this recovers theta = 0.670820 exactly, the
point root-finding could not reach from 0.05 away and random-start least_squares
missed in 150 tries.  The same graph carries 23 distinct critical solutions, four
of them with S = 0: 0.670820 and 0.612372 on five blocks, 0.666576 and 0.641091 on
six.  All four are block-constant.

RESULT AT n = 6, COMPLETE OVER GRAPHS.  5788 triangle-free graphs, four S = 0
values -- 1.054093 and 0.968246 on two blocks, 0.942809 and 0.866025 on three --
and NOT ONE that fails block-constancy or degenerates to singleton blocks.

WHAT IS AND IS NOT CERTIFIED.  The enumeration over graphs is exhaustive; the solve
on each graph is three seeds, so a branch with a small basin on some graph could
still be missed.  The claim is therefore "no counterexample in a complete sweep of
supports", not "the solve is complete".

FALSIFIER.  A critical solution whose negative graph is triangle-free and whose w
is not block-constant.
"""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from scipy.optimize import least_squares
from review_r30_core import pair_index, Q, normalize
from b_diagonal_census import diag_basis, w_of, negative_graph_triangles, block_partition


def triangle_free_graphs(n):
    """Every triangle-free graph on n labelled vertices, as a set of pair indices."""
    pairs, idx = pair_index(n)
    tris = [(idx[(i, j)], idx[(j, k)], idx[(i, k)])
            for i, j, k in itertools.combinations(range(n), 3)]
    for bits in range(1 << len(pairs)):
        E = frozenset(a for a in range(len(pairs)) if bits >> a & 1)
        if not E:
            continue
        if any(a in E and b in E and c in E for a, b, c in tris):
            continue
        yield E


def solve_on_graph(n, Bd, pairs, E, seeds=3, seed0=0):
    """Critical points of P on the diagonal subspace seeded to have negative graph E."""
    D = Bd.shape[0]
    rng = np.random.default_rng(seed0)

    def F(x):
        nx = np.linalg.norm(x)
        if nx < 1e-12:
            return np.zeros(D)
        W = np.einsum('d,dij->ij', x / nx, Bd)
        g = np.einsum('dij,ij->d', Bd, Q(n, W))
        return g - float(g @ (x / nx)) * (x / nx)

    out = []
    base = np.array([-1.0 if a in E else 1.0 for a in range(len(pairs))])
    for s in range(seeds):
        w0 = base + 0.3 * rng.normal(size=len(pairs))
        x0 = np.einsum('dij,ij->d', Bd, np.diag(w0))
        if np.linalg.norm(x0) < 1e-9:
            continue
        sol = least_squares(F, x0 / np.linalg.norm(x0), xtol=1e-15, ftol=1e-15,
                            gtol=1e-15)
        if np.linalg.norm(F(sol.x)) > 1e-9 or np.linalg.norm(sol.x) < 1e-9:
            continue
        W = normalize(np.einsum('d,dij->ij', sol.x / np.linalg.norm(sol.x), Bd))
        th = float(np.tensordot(W, Q(n, W)))
        if th < 1e-6:
            W, th = -W, -th
        if th < 1e-6:
            continue
        out.append((th, W))
    return out


def census_over_classes(n, seeds=6, log=print):
    """The census run over ISOMORPHISM CLASSES of triangle-free graphs.

    Labelled edge sets explode past n = 7 -- 133501 there, millions at n = 8 --
    while the classes number 410, 1897, 12172 at n = 8, 9, 10.  Relabelling
    coordinates is an O(n) symmetry, so one representative per class suffices."""
    from b_trianglefree_classes import triangle_free_classes
    Bd, pairs = diag_basis(n)
    idx = {p: a for a, p in enumerate(pairs)}
    reps = triangle_free_classes(n)[n]
    found = {}
    for gi, A in enumerate(reps):
        E = frozenset(idx[(i, j)] for i in range(n) for j in range(i + 1, n) if A[i, j])
        if not E:
            continue
        for th, W in solve_on_graph(n, Bd, pairs, E, seeds=seeds, seed0=gi + 1):
            wv = w_of(W, pairs)
            if negative_graph_triangles(wv, pairs, n) != 0:
                continue
            k = block_partition(wv, pairs, n)
            found[(round(th, 6), str(k))] = found.get((round(th, 6), str(k)), 0) + 1
        if (gi + 1) % 2000 == 0:
            log(f"  {gi+1}/{len(reps)} classes, {len(found)} distinct S=0 solutions")
    return len(reps), found


if __name__ == "__main__":
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 6
    Bd, pairs = diag_basis(n)
    print(f"=== complete diagonal census at n = {n}: dim = {Bd.shape[0]}, "
          f"{len(pairs)} pairs ===")
    found = {}
    ngraph = 0
    for E in triangle_free_graphs(n):
        ngraph += 1
        for th, W in solve_on_graph(n, Bd, pairs, E, seed0=ngraph):
            wv = w_of(W, pairs)
            if negative_graph_triangles(wv, pairs, n) != 0:
                continue                       # solution left {S = 0}
            k = block_partition(wv, pairs, n)
            key = (round(th, 7), str(k))
            found[key] = found.get(key, 0) + 1
    print(f"  triangle-free graphs enumerated: {ngraph}")
    print(f"{'theta':>10s} {'blocks':>14s} {'hits':>6s}")
    for (th, k), c in sorted(found.items(), reverse=True):
        print(f"{th:10.6f} {k:>14s} {c:6d}")
    bad = [(th, k) for (th, k) in found if k == "inconsistent"]
    sing = [(th, k) for (th, k) in found if k == str(n)]
    print(f"  S=0 diagonal critical points that are NOT block-constant: {len(bad)}")
    print(f"  with all-singleton blocks (vacuous block structure): {len(sing)}")
