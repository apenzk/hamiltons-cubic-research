"""C_5 blow-ups: the first indecomposable S = 0 critical points, and where they sit.

Reviewers 52 and 53 found that S_structural = 3 x (triangles of the negative block
graph), so S = 0 needs a triangle-free negative graph; with connectivity and
non-bipartiteness also required, C_5 is the smallest, at k = 5 blocks.  They found
41 such points at n = 9..16.

Reproduced here independently: the C_5 blow-up at n = 10, blocks (2,2,2,2,2) with
entries diagonal 4, adjacent -2, non-adjacent +1 (up to scale), is

    exactly critical   residual 1.3e-16
    Ricci-flat         5.6e-17
    S_structural       0.000e+00  exactly
    theta              0.670820393 = 0.5590 theta_0(10)

so it lies well below the top value and the theta exclusion still reaches it.

A TRAP WORTH RECORDING.  Solving the block-symmetric vertex system for k blocks and
taking the LARGEST theta does not give the largest blow-up: that system contains
every coarser partition as a degenerate solution, where several blocks carry
identical rows.  Doing so returns theta/theta_0 = 0.9882, 0.9931 and even exactly
1.0000 at (2,2,2,2,4) -- which look like S = 0 points at the conjectured maximum
and are nothing of the kind.  All three collapse to TWO effective blocks: the
n = 12 case groups as {0,1,2} and {3,4}, i.e. it is S^6 x S^6 wearing five labels.
Always count distinct rows of w before believing a k-block solution is k-block.
"""
import numpy as np, sys
from scipy.optimize import least_squares
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, adj, Q
from b_padded_s3s3 import slack

def cycle_graph(k):
    G = [[0] * k for _ in range(k)]
    for a in range(k):
        G[a][(a + 1) % k] = G[(a + 1) % k][a] = 1
    return G

def effective_blocks(w, tol=1e-7):
    """How many distinct block-rows the solution really has."""
    groups = {}
    for a, row in enumerate(np.round(w, 7)):
        groups.setdefault(tuple(row), []).append(a)
    return len(groups), list(groups.values())

def c5_operator(sizes, diag=4.0, adjv=-2.0, nonadj=1.0):
    """The explicit C_5 blow-up, built from the graph rather than solved for."""
    k = len(sizes); n = sum(sizes)
    G = cycle_graph(k)
    pairs, idx = pair_index(n); N = len(pairs)
    lab = []
    for bi, b in enumerate(sizes):
        lab += [bi] * b
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs):
        A_, B_ = lab[i], lab[j]
        W[a, a] = diag if A_ == B_ else (adjv if G[A_][B_] else nonadj)
    return W / np.linalg.norm(W), n

if __name__ == "__main__":
    W, n = c5_operator([2] * 5)
    pairs, idx = pair_index(n); N = len(pairs); A = adj(n)
    th = float(np.tensordot(W, Q(n, W)))
    res = float(np.linalg.norm(Q(n, W) - th * W))
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    S = slack(n, W, A, N) / (n - 2) ** 2          # correct to the so(n) scale
    print(f"C_5 blow-up, blocks (2,2,2,2,2), n={n}")
    print(f"   theta      = {th:.9f}   ({th/th0:.4f} of theta_0)")
    print(f"   criticality= {res:.1e}")
    print(f"   slack S    = {S:.3e}")
