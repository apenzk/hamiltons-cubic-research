"""Are all coordinate-diagonal S = 0 critical points blow-ups?

WHAT B1 OWES.  Openness at the diagonal S = 0 points is proved for every known
class, so what is left is completeness of that list.  Unlike the non-diagonal
enumeration -- which Reviewers 56/57 refuted -- this one is combinatorial, and it
can be searched exhaustively enough to be worth trusting.

THE DIAGONAL SUBSPACE IS SMALL AND EXPLICIT.  A diagonal W has W_{ijkl} = 0 unless
{i,j} = {k,l}, so it is a symmetric matrix w with zero diagonal.  Bianchi is then
automatic -- every term of W_{ijkl} + W_{iklj} + W_{iljk} is off-diagonal -- and
Ricci-flatness reduces to EVERY ROW OF w SUMMING TO ZERO.  So

    diagonal Weyl_n  =  {w symmetric, zero diagonal, zero row sums},   dim n(n-3)/2,

which is 35 at n = 10 and 54 at n = 12.

S = 0 IS TRIANGLE-FREENESS, WITHOUT ASSUMING BLOCKS.  The slack is the part of
[m, m] landing back in m for m the negative eigenspace, and for diagonal W that
eigenspace is spanned by the phi_ij with w_ij < 0.  Since [phi_ij, phi_jk] = +-
phi_ik, the slack vanishes exactly when no triple i, j, k has all three of w_ij,
w_jk, w_ik negative -- the negative graph is triangle-free.  This is the record's
S_struct = 3 x (triangles) with the block-constancy hypothesis removed.

THE TRAP THIS SEARCH MUST AVOID.  Criticality WITHIN the diagonal subspace is not
criticality in Weyl_n, since the diagonal locus is a proper subspace; both are
checked separately below and the second is the one that counts.

THE OUTCOME: THIS METHOD CANNOT DO IT, AND THE CONTROL IS WHAT SAYS SO.  The C_5
blow-up is diagonal, exactly critical, triangle-free and block-constant with five
blocks, so any honest census at n = 10 must return it.  Neither solver does, from
hundreds of random starts:

  * power iteration on the projected gradient returns only ATTRACTING critical
    points -- two-block sphere products and nothing else;
  * root-finding returns dozens of low-theta solutions and, with method 'lm',
    stops finding even the two-block products that 'hybr' finds.

The two solvers disagree about which solutions exist, and neither finds the one
known answer.  So the census below is NOT evidence about completeness, and it is
printed with its control attached so it cannot be quoted as if it were.

AND THE REASON IS STRUCTURAL, NOT A TUNING PROBLEM.  The equation is right: F is
2.9e-16 at the C_5 blow-up, which lies exactly in the diagonal subspace.  But the
point is DEGENERATE -- twenty excess directions -- so the Jacobian of F is singular
there and Newton-type root-finding cannot converge to it: seeded 0.05 away, it is
recovered 0 times out of 20.  Multistart root-finding therefore misses precisely
the degenerate critical points, which are the ones a census is for.

WHAT WOULD WORK INSTEAD.  S = 0 is a combinatorial condition on the negative
graph, so the enumeration should run over triangle-free graphs on n vertices and
solve criticality on each support, rather than sampling the 35- or 54-dimensional
diagonal space at random.

FALSIFIER.  A diagonal critical point of Weyl_n with triangle-free negative graph
whose w is not block-constant.
"""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, Q, weyl_basis, normalize


def diag_basis(n):
    """Orthonormal basis of {w symmetric, zero diagonal, zero row sums}, as
    operators on Lambda^2."""
    pairs, idx = pair_index(n); N = len(pairs)
    C = np.zeros((n, N))
    for a, (i, j) in enumerate(pairs):
        C[i, a] = 1.0; C[j, a] = 1.0
    ns = np.linalg.svd(C)[2][np.linalg.matrix_rank(C):]      # null space of C
    B = np.zeros((ns.shape[0], N, N))
    for k, v in enumerate(ns):
        B[k] = np.diag(v)
    return B, pairs


def w_of(W, pairs):
    return np.array([W[a, a] for a in range(len(pairs))])


def negative_graph_triangles(wv, pairs, n, tol=1e-9):
    neg = set()
    for a, (i, j) in enumerate(pairs):
        if wv[a] < -tol:
            neg.add((i, j))
    tri = 0
    for i, j, k in itertools.combinations(range(n), 3):
        if (i, j) in neg and (j, k) in neg and (i, k) in neg:
            tri += 1
    return tri


def block_partition(wv, pairs, n, tol=1e-6):
    """Coarsest partition with w constant on block pairs, or None if w is not
    block-constant.  Vertices go together when their off-i,j rows agree."""
    M = np.zeros((n, n))
    for a, (i, j) in enumerate(pairs):
        M[i, j] = M[j, i] = wv[a]
    lab = [-1] * n; blocks = []
    for i in range(n):
        for b, rep in enumerate(blocks):
            others = [k for k in range(n) if k != i and k != rep]
            if (abs(M[i, rep] - M[rep, i]) < tol
                    and max(abs(M[i, k] - M[rep, k]) for k in others) < tol):
                lab[i] = b; break
        else:
            lab[i] = len(blocks); blocks.append(i)
    k = len(blocks)
    for i in range(n):
        for j in range(n):
            if i == j:
                continue
            for p in range(n):
                for q in range(n):
                    if p == q or lab[i] != lab[p] or lab[j] != lab[q]:
                        continue
                    if abs(M[i, j] - M[p, q]) > tol:
                        return "inconsistent"
    # k == n means every vertex is its own block: block-constancy is vacuous there,
    # so it is reported separately rather than counted as a blow-up
    return k


def solve_in_diagonal(n, Bd, seed, method='lm'):
    """Critical points of P restricted to the diagonal subspace, by ROOT-FINDING.

    Power iteration on the projected gradient was the first attempt and is a blind
    instrument: it converges only to attracting critical points, and at n = 10 it
    never once returned the C_5 blow-up, which is diagonal and critical.  The
    positive control at the bottom of this file exists because of that."""
    from scipy.optimize import root
    rng = np.random.default_rng(seed)

    def F(x):
        nx = np.linalg.norm(x)
        if nx < 1e-12:
            return x
        W = np.einsum('d,dij->ij', x / nx, Bd)
        g = np.einsum('dij,ij->d', Bd, Q(n, W))
        th = float(g @ (x / nx))
        return g - th * (x / nx)

    x0 = rng.normal(size=Bd.shape[0])
    sol = root(F, x0, method=method, tol=1e-13)
    x = sol.x
    if np.linalg.norm(F(x)) > 1e-9:
        sol = root(F, x0, method='hybr', tol=1e-13)
        x = sol.x
    if np.linalg.norm(x) < 1e-9:
        return None
    return normalize(np.einsum('d,dij->ij', x / np.linalg.norm(x), Bd))


if __name__ == "__main__":
    from b_c5_blowup import c5_operator
    n = 10
    Bd, pairs = diag_basis(n)
    Wc = normalize(c5_operator([2] * 5)[0])
    thc = float(np.tensordot(Wc, Q(n, Wc)))
    wc = w_of(Wc, pairs)
    print(f"=== the control: the C_5 blow-up at n = 10 ===")
    print(f"  theta = {thc:.6f}, criticality residual = "
          f"{float(np.linalg.norm(Q(n, Wc) - thc * Wc)):.2e}, triangles = "
          f"{negative_graph_triangles(wc, pairs, n)}, blocks = "
          f"{block_partition(wc, pairs, n)}")
    print(f"  dim diagonal Weyl_{n} = {Bd.shape[0]} (n(n-3)/2 = {n*(n-3)//2})")

    x0 = np.einsum('dij,ij->d', Bd, Wc)

    def F0(x):
        nx = np.linalg.norm(x); W = np.einsum('d,dij->ij', x / nx, Bd)
        g = np.einsum('dij,ij->d', Bd, Q(n, W))
        return g - float(g @ (x / nx)) * (x / nx)

    from scipy.optimize import root as _root
    rng = np.random.default_rng(0); ok = 0
    for _ in range(20):
        sol = _root(F0, x0 + 0.05 * rng.normal(size=len(x0)), method='hybr', tol=1e-13)
        Wr = normalize(np.einsum('d,dij->ij', sol.x / np.linalg.norm(sol.x), Bd))
        if abs(float(np.tensordot(Wr, Q(n, Wr))) - thc) < 1e-6:
            ok += 1
    print(f"  |F| at the C_5 point = {float(np.linalg.norm(F0(x0))):.1e}, yet seeded "
          f"0.05 away it is recovered {ok}/20 times")
    print(f"  -- the Jacobian is singular at a degenerate point, so root-finding "
          f"cannot reach it")

    for method in ('hybr', 'lm'):
        seen = {}
        for s in range(200):
            W = solve_in_diagonal(n, Bd, s, method=method)
            if W is None:
                continue
            th = float(np.tensordot(W, Q(n, W)))
            if th < 1e-9:
                continue
            seen[round(th, 6)] = seen.get(round(th, 6), 0) + 1
        found = any(abs(t - thc) < 1e-4 for t in seen)
        print(f"\n  solver '{method}': {len(seen)} distinct theta from 200 starts, "
              f"largest {max(seen):.6f}")
        print(f"    C_5 blow-up found: "
              f"{'YES' if found else 'NO -- the census is blind and proves nothing'}")
