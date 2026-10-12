"""r265 claim 3 -- reproduce run_restitution_kernel.py by an EXACT route, and then
run the case the record actually cares about: functionals restricted to the cube of
a tensor that lives in a PROPER SUBSPACE with symmetries.

Route shares no code with the reviewed script:
  * ranks are taken over F_p with integer evaluation points (two primes), never floats;
  * the nine cells are also settled with NO evaluation at all, by counting the
    distinct monomials that the restituted basis functionals produce -- which is what
    the rank of the evaluation map is, whenever the points are unisolvent.
"""
from itertools import product
from math import comb
from fractions import Fraction

P1, P2 = (1 << 31) - 1, 2147483629


def rank_mod(rows, p):
    rows = [r[:] for r in rows]
    ncol = len(rows[0]) if rows else 0
    r = 0
    for c in range(ncol):
        piv = None
        for i in range(r, len(rows)):
            if rows[i][c] % p:
                piv = i
                break
        if piv is None:
            continue
        rows[r], rows[piv] = rows[piv], rows[r]
        inv = pow(rows[r][c], p - 2, p)
        rows[r] = [(x * inv) % p for x in rows[r]]
        for i in range(len(rows)):
            if i != r and rows[i][c] % p:
                f = rows[i][c]
                rows[i] = [(a - f * b) % p for a, b in zip(rows[i], rows[r])]
        r += 1
        if r == len(rows):
            break
    return r


# ---------------------------------------------------------------- part 1
# The nine cells, exactly.  M[point][multilinear basis functional] = the value of
# that functional's restitution at the point.  Integer points, exact arithmetic.
print("PART 1 -- the nine cells of run_restitution_kernel.py, exactly\n")
print(f"  {'dimV':>5} {'d':>2} {'multilinear':>12} {'rank(R_d) mod p':>16}"
      f" {'dim Sym^d':>10} {'#distinct monomials':>20}")
rows_out = []
for V in (2, 3, 4):
    for d in (2, 3, 4):
        idx = list(product(range(V), repeat=d))
        npts = 4 * comb(V + d - 1, d) + 20
        pts = [[pow(k + 2, j + 1, 101) for j in range(V)] for k in range(npts)]
        M = [[eval_pt(p, t) if False else __import__('math').prod(p[i] for i in t)
              for t in idx] for p in pts]
        r1 = rank_mod([[x % P1 for x in row] for row in M], P1)
        r2 = rank_mod([[x % P2 for x in row] for row in M], P2)
        assert r1 == r2, (V, d, r1, r2)
        # the no-evaluation route: the restitution of the basis functional indexed by
        # t is the monomial prod x_{t_j}; its span has dimension = #distinct monomials
        mons = {tuple(sorted(t)) for t in idx}
        sd = comb(V + d - 1, d)
        print(f"  {V:>5} {d:>2} {len(idx):>12} {r1:>16} {sd:>10} {len(mons):>20}")
        rows_out.append((V, d, len(idx), r1, sd, len(mons)))
        assert r1 == sd == len(mons)
print("\n  Every cell agrees exactly.  And the middle column is DETERMINED by the last:")
print("  restituting the basis functional e_{i_1..i_d}^* gives the MONOMIAL x_{i_1}..x_{i_d},")
print("  so the image is spanned by monomials and its dimension is the number of")
print("  DISTINCT ones, which is comb(V+d-1,d) by definition.  No theorem is used.\n")

# ---------------------------------------------------------------- part 2
# The second assert of the reviewed script, symbolically.
print("PART 2 -- is `total - r == total - sd` a second fact?\n")
for (V, d, total, r, sd, _) in rows_out:
    a1 = (r == sd)
    a2 = (total - r == total - sd)
    assert a1 == a2
print("  At all nine cells assert-2 holds exactly when assert-1 holds, and it is the")
print("  same equation with `total` added to both sides.  It tests nothing further:")
print("  in particular it never looks at ker(R_d) as a SUBSPACE -- only at its dimension.\n")

# ---------------------------------------------------------------- part 3
# The case the record cares about.  U = V tensor V (a space of TENSORS), and the
# cube is taken of an element of a PROPER SUBSPACE S of U with symmetries.
print("PART 3 -- the cube of a tensor with symmetries: is the kernel still the")
print("          non-symmetric complement?\n")


def sym_basis(n, kind):
    """basis of a subspace S of V tensor V, as a list of n x n integer matrices."""
    B = []
    if kind == "all":
        for i in range(n):
            for j in range(n):
                m = [[0] * n for _ in range(n)]
                m[i][j] = 1
                B.append(m)
    elif kind == "sym":
        for i in range(n):
            for j in range(i, n):
                m = [[0] * n for _ in range(n)]
                m[i][j] = 1
                m[j][i] = 1
                B.append(m)
    elif kind == "symtl":                       # symmetric traceless
        for i in range(n):
            for j in range(i + 1, n):
                m = [[0] * n for _ in range(n)]
                m[i][j] = 1
                m[j][i] = 1
                B.append(m)
        for i in range(n - 1):
            m = [[0] * n for _ in range(n)]
            m[i][i] = 1
            m[n - 1][n - 1] = -1
            B.append(m)
    elif kind == "anti":
        for i in range(n):
            for j in range(i + 1, n):
                m = [[0] * n for _ in range(n)]
                m[i][j] = 1
                m[j][i] = -1
                B.append(m)
    return B


def restitution_rank_on_subspace(n, kind, d=3, seed=7):
    """rank of {F |-> F(T,..,T) : F multilinear on (V tensor V)^d}, T ranging over S."""
    B = sym_basis(n, kind)
    dS = len(B)
    # multilinear basis functionals on U^d are indexed by d pairs (a,b)
    pairs = [(a, b) for a in range(n) for b in range(n)]
    idx = list(product(range(len(pairs)), repeat=d))
    npts = 4 * comb(dS + d - 1, d) + 30
    st = seed
    Ts = []
    for _ in range(npts):
        T = [[0] * n for _ in range(n)]
        for m in B:
            st = (st * 1103515245 + 12345) % 2147483647
            c = st % 97 - 48
            for i in range(n):
                for j in range(n):
                    T[i][j] += c * m[i][j]
        Ts.append(T)
    M = []
    for T in Ts:
        flat = [T[a][b] for (a, b) in pairs]
        M.append([__import__('math').prod(flat[k] for k in t) for t in idx])
    r = rank_mod([[x % P1 for x in row] for row in M], P1)
    return r, len(idx), dS


print(f"  {'n':>2} {'S':>7} {'dim S':>6} {'multilinear on U^3':>19} {'rank(R_3 on S)':>15}"
      f" {'dim Sym^3(S*)':>14} {'dim Sym^3(U*)':>14}")
for n in (2, 3):
    for kind in ("all", "sym", "symtl", "anti"):
        r, total, dS = restitution_rank_on_subspace(n, kind)
        sS = comb(dS + 2, 3) if dS else 0
        sU = comb(n * n + 2, 3)
        print(f"  {n:>2} {kind:>7} {dS:>6} {total:>19} {r:>15} {sS:>14} {sU:>14}")
        assert r == sS, (n, kind, r, sS)

print()
print("  rank is ALWAYS dim Sym^3(S*) -- the dimension of the SUBSPACE's symmetric")
print("  cube, never dim Sym^3(U*).  So for every proper S the kernel has dimension")
print("     total - dim Sym^3(S*)   >   total - dim Sym^3(U*),")
print("  and the excess is a set of SYMMETRIC multilinear functionals on U^3 that")
print("  restitution sends to zero ON S.  The non-symmetric complement is a PROPER")
print("  SUBSPACE of the kernel as soon as S is a proper subspace of U.\n")
for n in (2, 3, 4, 5):
    U = n * n
    for kind in ("sym", "symtl", "anti"):
        dS = len(sym_basis(n, kind))
        print(f"    n={n:<2} S={kind:<6} dim Sym^3(U*)={comb(U+2,3):>8}"
              f"  dim Sym^3(S*)={comb(dS+2,3) if dS else 0:>8}"
              f"  symmetric dimensions killed = {comb(U+2,3)-(comb(dS+2,3) if dS else 0):>8}")
