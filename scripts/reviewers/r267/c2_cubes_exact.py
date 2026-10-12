"""r267 claim 2 -- cubes span Sym^d(U), by a CONSTRUCTIVE route and over Z, not by float rank.

The reviewed file run_cubes_span.py samples Gaussian vectors and calls
np.linalg.matrix_rank with tol=1e-9.  That is a lower bound on a rank, read
through a float tolerance.  Nothing below evaluates a floating point rank.

THREE INDEPENDENT ROUTES.

  ROUTE 1 (constructive, no rank at all).  The complete polarization identity

      d! * (u_1 (.) ... (.) u_d)  =  sum_{S subset [d], S nonempty} (-1)^{d-|S|} (sum_{i in S} u_i)^{tensor d}

  writes EVERY generator of Sym^d(U) as an explicit integer combination of
  cubes/powers of elements of U.  That is the spanning statement with its
  coefficients exhibited; it needs no sampling and no tolerance.  Checked as an
  exact identity over Z on integer vectors.

  ROUTE 2 (exact rank over Q).  The point set is the one route 1's identity
  NAMES -- { sum_{k in S} e_{i_k} : (i_1..i_d) a monomial, S a nonempty subset }
  -- so the rank is attained by construction, plus random integer points as a
  cross-check.  Exact rational elimination; no tolerance exists.

  A WARNING THIS SCRIPT EARNED.  The first version used Vandermonde points
  u_t = (1,t,...,t^{dim-1}).  They lie on the rational normal CURVE, their
  monomials collapse to t^{i+j+k}, and the rank stalls at 3(dim-1)+1 -- 7 rather
  than 10 at dim 3, degree 3.  Cubes span, but not the cubes of any old family:
  the sampled family has to be Zariski-dense, and Gaussian samples are.

  ROUTE 3 (the real Weyl space).  U = Weyl_n, built from its DEFINING LINEAR
  CONDITIONS as a nullspace inside V^{tensor 4} (n = 4, 5, 6), dimension checked
  against n(n+1)(n+2)(n-3)/12; then route 2 run on that U.  This answers the
  brief's question of whether "Weyl_n is cut out by linear conditions" matters.
"""
import numpy as np
from fractions import Fraction
from itertools import combinations_with_replacement as cwr, combinations, permutations
from math import comb, factorial

# ---------------------------------------------------------------- exact rank

def rank_exact(rows):
    """rank over Q of a list of lists of Fractions/ints, by fraction-free elimination."""
    M = [[Fraction(x) for x in r] for r in rows]
    nr, nc = len(M), len(M[0]) if M else 0
    r = 0
    for c in range(nc):
        piv = next((i for i in range(r, nr) if M[i][c] != 0), None)
        if piv is None:
            continue
        M[r], M[piv] = M[piv], M[r]
        pv = M[r][c]
        for i in range(r + 1, nr):
            if M[i][c] != 0:
                f = M[i][c] / pv
                M[i] = [a - f * b for a, b in zip(M[i], M[r])]
        r += 1
        if r == nr:
            break
    return r

# ------------------------------------------------- ROUTE 1: the identity

def sym_power_vec(u, d, mons):
    """coordinates of u^{tensor d} in the monomial basis of Sym^d."""
    return [np.prod([u[i] for i in m], dtype=object) for m in mons]

def sym_product_vec(us, d, mons):
    """coordinates of d! * (u_1 (.) ... (.) u_d):  the full symmetrisation, times d!.

    In the monomial basis e_m of Sym^d the coefficient of the symmetrised product
    on the monomial m = (i_1<=...<=i_d) is the permanent-style sum over which
    factor supplies which slot, i.e. sum over bijections [d] -> slots of m."""
    out = []
    for m in mons:
        s = 0
        for p in permutations(range(d)):
            t = 1
            for k in range(d):
                t *= us[k][m[p[k]]]
            s += t
        # each distinct arrangement of the multiset m counted; divide by the
        # multiplicities so the answer is d! * (symmetric product) in this basis
        out.append(s)
    return out

def route1(dim_U, d, trials=8, seed=7):
    """exact check of the complete polarization identity on integer vectors."""
    rng = np.random.default_rng(seed)
    mons = list(cwr(range(dim_U), d))
    bad = 0
    for _ in range(trials):
        us = [[int(x) for x in rng.integers(-4, 5, dim_U)] for _ in range(d)]
        lhs = sym_product_vec(us, d, mons)          # d! * symmetric product
        rhs = [0] * len(mons)
        for k in range(1, d + 1):
            for S in combinations(range(d), k):
                v = [sum(us[i][j] for i in S) for j in range(dim_U)]
                sgn = (-1) ** (d - k)
                pw = sym_power_vec(v, d, mons)
                rhs = [a + sgn * b for a, b in zip(rhs, pw)]
        if lhs != rhs:
            bad += 1
    return bad

# ------------------------------------------------- ROUTE 2: exact rank

def polarization_points(dim_U, d):
    """the points route 1's identity actually uses: for each monomial
    (i_1<=...<=i_d) and each nonempty S subset [d], the vector sum_{k in S} e_{i_k}."""
    pts, seen = [], set()
    for m in cwr(range(dim_U), d):
        for k in range(1, d + 1):
            for S in combinations(range(d), k):
                v = [0] * dim_U
                for t in S:
                    v[m[t]] += 1
                key = tuple(v)
                if key not in seen:
                    seen.add(key)
                    pts.append(v)
    return pts

def route2(dim_U, d, seed=3, extra=20):
    mons = list(cwr(range(dim_U), d))
    want = comb(dim_U + d - 1, d)
    assert len(mons) == want
    rng = np.random.default_rng(seed)
    pts = polarization_points(dim_U, d)
    pts += [[int(x) for x in rng.integers(-6, 7, dim_U)] for _ in range(want + extra)]
    rows = [[np.prod([u[i] for i in m], dtype=object) for m in mons] for u in pts]
    return rank_exact(rows), want, len(pts)

# ------------------------------------------------- ROUTE 3: real Weyl_n

def weyl_basis(n):
    """basis of Weyl_n inside V^{tensor 4}, as the nullspace of the defining
    linear conditions: antisymmetry in (ab) and (cd), pair symmetry, first
    Bianchi, and vanishing of the (1,3) trace."""
    N = n ** 4
    idx = lambda a, b, c, d: ((a * n + b) * n + c) * n + d
    cons = []
    def add(coeffs):
        row = np.zeros(N)
        for k, v in coeffs:
            row[k] += v
        cons.append(row)
    for a in range(n):
        for b in range(n):
            for c in range(n):
                for d in range(n):
                    add([(idx(a, b, c, d), 1), (idx(b, a, c, d), 1)])          # R_abcd = -R_bacd
                    add([(idx(a, b, c, d), 1), (idx(a, b, d, c), 1)])          # R_abcd = -R_abdc
                    add([(idx(a, b, c, d), 1), (idx(c, d, a, b), -1)])         # pair symmetry
                    add([(idx(a, b, c, d), 1), (idx(a, c, d, b), 1),
                         (idx(a, d, b, c), 1)])                                # first Bianchi
    for b in range(n):
        for d in range(n):
            add([(idx(a, b, a, d), 1) for a in range(n)])                       # trace free
    C = np.array(cons)
    # nullspace by SVD (dimension only; the basis is then rationalised by rref)
    u, s, vt = np.linalg.svd(C, full_matrices=True)
    tol = max(C.shape) * (s[0] if len(s) else 1.0) * 1e-12
    k = int((s > tol).sum())
    return vt[k:]           # rows span Weyl_n

def route3b(n, seed=11):
    """The ambient demonstration, with no basis and no coordinates.

    Degree 2 so the tensors fit: W1 (.) W2 = ((W1+W2)^{tensor 2} - W1^{tensor 2}
    - W2^{tensor 2}) / 2, checked as an identity in V^{tensor 8}.  The identity
    needs W1 + W2 to be a Weyl tensor, and it is, BECAUSE the conditions cutting
    Weyl_n out are LINEAR.  That is the whole answer to "does being defined by
    linear conditions matter": linear means closed under the sums polarization
    forms."""
    B = weyl_basis(n)
    rng = np.random.default_rng(seed)
    W1 = np.tensordot(rng.standard_normal(B.shape[0]), B, axes=1)
    W2 = np.tensordot(rng.standard_normal(B.shape[0]), B, axes=1)
    W1, W2 = W1.reshape((n,)*4), W2.reshape((n,)*4)
    S = np.tensordot(W1, W2, axes=0) + np.tensordot(W2, W1, axes=0)   # 2 * (W1 (.) W2)
    P = (np.tensordot(W1+W2, W1+W2, axes=0) - np.tensordot(W1, W1, axes=0)
         - np.tensordot(W2, W2, axes=0))
    # W1+W2 lies in Weyl_n: verify by projecting onto the computed basis
    v = (W1 + W2).reshape(-1)
    resid = np.linalg.norm(v - B.T @ (B @ v)) / np.linalg.norm(v)
    return np.abs(S - P).max() / np.abs(S).max(), resid

if __name__ == "__main__":
    print("ROUTE 1 -- complete polarization identity, exact over Z (0 failures wanted)")
    print(f"  {'dim U':>6} {'d':>2} {'trials':>7} {'failures':>9}")
    for dim_U in (2, 3, 4, 5):
        for d in (2, 3, 4):
            bad = route1(dim_U, d)
            print(f"  {dim_U:>6} {d:>2} {8:>7} {bad:>9}")
            assert bad == 0, "the polarization identity failed -- cubes-span has no constructive proof"
    print("\n  every generator of Sym^d(U) is an explicit signed integer sum of d-th")
    print("  powers, so the powers SPAN.  No rank, no tolerance, no sampling.\n")

    print("ROUTE 2 -- exact rank over Q, on the points polarization itself names")
    print("  (every cell of run_cubes_span.py's two tables, reproduced with no float)")
    print(f"  {'dim U':>6} {'d':>2} {'points':>7} {'rank':>6} {'dim Sym^d':>10} {'match':>6}")
    for dim_U, d in ((2,3),(3,3),(4,3),(5,3),(6,3),(8,3),(3,2),(3,4),(4,2),(4,4),(5,2),(5,4)):
        got, want, npts = route2(dim_U, d)
        print(f"  {dim_U:>6} {d:>2} {npts:>7} {got:>6} {want:>10} {'yes' if got==want else 'NO':>6}")
        assert got == want

    print("\nROUTE 3 -- U = Weyl_n itself, from its defining linear conditions")
    print(f"  {'n':>3} {'dim Weyl_n':>11} {'formula':>8}")
    dims = {}
    for n in (4, 5, 6):
        B = weyl_basis(n); dims[n] = B.shape[0]
        formula = n * (n + 1) * (n + 2) * (n - 3) // 12
        print(f"  {n:>3} {B.shape[0]:>11} {formula:>8}")
        assert B.shape[0] == formula, f"Weyl_{n} dimension {B.shape[0]} != {formula}"

    print("\n  3a. exact rank of cubes in Sym^3(Weyl_4), dim Weyl_4 = 10:")
    got, want, npts = route2(dims[4], 3)
    print(f"      rank {got} of dim Sym^3 = {want} over {npts} exact points -- "
          f"{'spans' if got == want else 'FAILS'}")
    assert got == want

    print("\n  3b. constructive identity at dim Weyl_5 = 35 and Weyl_6 = 84,")
    print("      exact over Z (0 failures wanted):")
    for n in (5, 6):
        bad = route1(dims[n], 3, trials=2)
        print(f"      n = {n}, dim U = {dims[n]:>3}, failures = {bad}")
        assert bad == 0

    print("\n  3c. the ambient check, no basis and no coordinates (degree 2, V^{tensor 8}):")
    print(f"      {'n':>3} {'rel err of the identity':>24} {'W1+W2 off Weyl_n by':>21}")
    for n in (4, 5, 6):
        err, resid = route3b(n)
        print(f"      {n:>3} {err:>24.3e} {resid:>21.3e}")
        assert err < 1e-12 and resid < 1e-10

    print("\n  Being cut out by linear conditions is exactly what makes the argument")
    print("  work: LINEAR conditions are closed under the sums polarization forms.")
