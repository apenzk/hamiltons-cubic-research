"""theta on the coordinate-diagonal locus, in closed combinatorial form.

THE FORMULA.  For W = diag(w) in Weyl_n the eigenvectors are the phi_ab, and the
transported structure constants c_abg^2 are 1 exactly on TRIANGLES {a,b},{b,c},{c,a}
and 0 otherwise.  So the whole functional collapses to

    theta(w) = sum_{a<b} w_ab^3 + 3 sum_{a<b<c} w_ab w_bc w_ca,

subject to the two constraints that define the diagonal Weyl locus:

    sum_{a<b} w_ab^2 = 1        (unit norm)
    sum_{b != a} w_ab = 0       (Ricci-flatness: every row sums to zero)

Verified exactly at S^3 x S^3, S^6 x S^6, S^4 x S^8 and the C_5 blow-up.

WHY IT MATTERS.  This is a weighted-graph extremal problem with no curvature in it:
a symmetric weight w on the edges of K_n with zero row sums and unit norm, scored by
its cube sum plus three times its triangle sum.  And S = 0 is the condition that the
NEGATIVE edges carry no triangle, so route B's diagonal residual reads

    maximise theta(w) over triangle-free-negative w  ==  theta_0(n)?
    with equality only at the balanced complete bipartite weight.

The balanced two-block sphere product is exactly that weight: 1/(p(p-1)) inside the
blocks, -1/(pq) across, so its negative graph is K_{p,q}, bipartite and therefore
triangle-free.

WHAT THE FORM BUYS.  Each triangle carries at most two negative edges once the
negative graph is triangle-free, so the triangle sum splits by how many of a
triangle's edges are negative -- zero or two give a positive contribution, one gives
a negative one.  That is a finite case split on a graph, not an estimate on a
tensor.

FALSIFIER.  A diagonal w with zero row sums, unit norm and triangle-free negative
graph whose theta exceeds theta_0(n).
"""
import numpy as np, itertools, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, normalize, Q, sphere_product_W
from b_c5_blowup import c5_operator


def theta_diag(n, w, idx=None):
    """The closed form, from the edge weights alone."""
    if idx is None:
        _, idx = pair_index(n)
    tri = sum(w[idx[(a, b)]] * w[idx[(b, c)]] * w[idx[(a, c)]]
              for a, b, c in itertools.combinations(range(n), 3))
    return float((w ** 3).sum() + 3 * tri)


def negative_graph_triangles(n, w, idx=None, tol=1e-9):
    if idx is None:
        _, idx = pair_index(n)
    neg = {p for p in idx if w[idx[p]] < -tol}
    return sum(1 for a, b, c in itertools.combinations(range(n), 3)
               if (a, b) in neg and (b, c) in neg and (a, c) in neg)


def row_sums(n, w, idx=None):
    if idx is None:
        _, idx = pair_index(n)
    return np.array([sum(w[idx[tuple(sorted((i, j)))]] for j in range(n) if j != i)
                     for i in range(n)])


if __name__ == "__main__":
    print("theta(w) = sum w^3 + 3 sum over triangles, on the diagonal Weyl locus")
    print(f"{'point':14s} {'n':>3s} {'formula':>13s} {'theta':>13s} {'off-diag':>9s} "
          f"{'max|rowsum|':>12s} {'neg triangles':>13s}")
    cases = [('S^3xS^3', 6, sphere_product_W([3, 3])[0]),
             ('S^6xS^6', 12, sphere_product_W([6, 6])[0]),
             ('S^4xS^8', 12, sphere_product_W([4, 8])[0]),
             ('C_5 blow-up', 10, c5_operator([2] * 5)[0])]
    for nm, n, W in cases:
        W = normalize(W); pairs, idx = pair_index(n)
        w = np.array([W[a, a] for a in range(len(pairs))])
        print(f"{nm:14s} {n:3d} {theta_diag(n, w, idx):13.9f} "
              f"{float(np.tensordot(W, Q(n, W))):13.9f} "
              f"{float(np.linalg.norm(W - np.diag(w))):9.1e} "
              f"{float(np.abs(row_sums(n, w, idx)).max()):12.1e} "
              f"{negative_graph_triangles(n, w, idx):13d}")
    print("\n  theta_0(n) = sqrt(2(n-1)(n-2))/n :  "
          + ", ".join(f"n={n}: {np.sqrt(2*(n-1)*(n-2))/n:.6f}" for n in (6, 10, 12)))
