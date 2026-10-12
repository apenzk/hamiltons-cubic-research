"""Postscript.  The file under review was rewritten in the worktree while this
review ran (r255's repair).  The new validation is

    COMPS = [(0,1), (1,2), (0,2)]      # distinct entries only
    assert r_ind == 1                  # (W.W, |W|^2 g)
    assert r_dep == 1                  # (W.W, swapped)

Both asserts now demand rank 1.  This re-runs claims 3 and 4 against them.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fractions import Fraction as F
from common import samples, rank_exact, mat_WW, mat_swapped, mat_q_delta

OLD = [(0, 0), (0, 1), (1, 2)]
NEW = [(0, 1), (1, 2), (0, 2)]
NS = (5, 6, 7)

def s_honest(M, i, j, n):    return M[i][j]
def s_indicator(M, i, j, n): return F(1) if M[i][j] != 0 else F(0)
def s_square(M, i, j, n):    return M[i][j]**2
def s_matsq(M, i, j, n):     return sum(M[i][a]*M[a][j] for a in range(n))
def s_const(M, i, j, n):     return F(1)          # reads NOTHING at all
def s_zero(M, i, j, n):      return F(0)

SCHEMES = [("honest   F_ij", s_honest),
           ("indicator [F_ij != 0]", s_indicator),
           ("entrywise square F_ij^2", s_square),
           ("one contraction too many (F.F)_ij", s_matsq),
           ("constant 1 -- reads nothing", s_const),
           ("constant 0", s_zero)]

cache = {}
for n in NS:
    Ws = samples(n, 4, seed=0)
    cache[n] = [(mat_WW(W, n), mat_q_delta(W, n), mat_swapped(W, n)) for W in Ws]

def crank(mats, n, comps, scheme):
    rows = []
    for Ms in mats:
        for (i, j) in comps:
            rows.append([scheme(M, i, j, n) for M in Ms])
    return rank_exact(rows)

print("=== the REVISED asserts (both must be 1) under six schemes ===")
print(f"{'scheme':38s} " + "  ".join(f" n={n} ind/dep " for n in NS) + " passes?")
for name, sc in SCHEMES:
    cells, ok = [], True
    for n in NS:
        ind = crank([(A, B) for (A, B, S) in cache[n]], n, NEW, sc)
        dep = crank([(A, S) for (A, B, S) in cache[n]], n, NEW, sc)
        ok &= (ind == 1 and dep == 1)
        cells.append(f"    {ind}/{dep}     ")
    print(f"{name:38s} " + "  ".join(cells) + f"   {'YES' if ok else 'no'}")

print("\n=== why: the second column is now IDENTICALLY ZERO ===")
A, B, S = cache[5][0]
for (i, j) in NEW:
    print(f"   ({i},{j}):  (W.W)_ij = {A[i][j]}    |W|^2 delta_ij = {B[i][j]}")
print("  both asserts are now collapses: one column of zeros, and one pair of")
print("  identical columns.  Nothing in the revised validation exhibits the test")
print("  CORRECTLY REPORTING INDEPENDENCE, so a scheme that always answers 'rank")
print("  1' passes it -- the constant scheme above does exactly that.")

print("\n=== claim 4 against the NEW components ===")
print("  the adversarial construction of c4_defeat_comps.py is unchanged in form:")
print("  3 components x 4 samples = 12 linear conditions on a 3n-member covariant")
print("  family, so a nonzero covariant vanishing on all of them still exists.")
