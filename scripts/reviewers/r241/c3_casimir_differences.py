"""r241 / claim 3: the Casimir-difference denominators on the REAL interval [12, oo).

A2 asserts block projection is Lagrange interpolation in "the six separating
Casimirs", prod_j (C - c_j)/(c_i - c_j), and that each difference c_i - c_j
merely joins A5's Sturm checklist.  This script computes the differences.

Setup.  The block table is constant for n >= 12 (A1), so a block is a partition
lambda with at most 6 rows and |lambda| in {0,2,...,12}; the O(n) labels are the
77 SO(12) constituents of scripts/runs/n12_sym3_blocks.pkl with the six
chirality pairs (lambda_6 = +-t) fused, giving 71.

Infinitesimal character: l_i(lambda; n) = lambda_i + n/2 - i, i = 1..rank.
For i > 6 both labels have lambda_i = 0, so those entries are common and cancel
in every difference.  The six separating invariants are p_2, p_4, ..., p_12
(sym3-blocks.md), so

    D_k^{lambda,mu}(n) = sum_{i=1}^{6} [ l_i(lambda)^{2k} - l_i(mu)^{2k} ],

a polynomial in n with rational coefficients, of degree 2k-1 at most.
"""
import pickle, itertools
from fractions import Fraction as F
import sympy as sp

n = sp.symbols('n')

blocks_so = pickle.load(open('scripts/runs/n12_sym3_blocks.pkl', 'rb'))
# fuse chirality pairs: an O(n) label has lambda_6 >= 0
o_labels = sorted({tuple(list(l[:5]) + [abs(l[5])]) for l in blocks_so}, reverse=True)
print(f"O(n) block labels (stable range): {len(o_labels)}")
assert len(o_labels) == 71, len(o_labels)

def ell(lam):
    return [sp.Integer(lam[i]) + sp.Rational(1, 2)*n - (i+1) for i in range(6)]

ELL = {lam: ell(lam) for lam in o_labels}

def diff_poly(lam, mu, k):
    a, b = ELL[lam], ELL[mu]
    return sp.expand(sum(a[i]**(2*k) - b[i]**(2*k) for i in range(6)))

def roots_ge_12(p):
    """real roots of p in [12, oo), exactly."""
    p = sp.Poly(sp.expand(p), n)
    if p.total_degree() == 0:
        return []
    out = []
    for r in sp.real_roots(p):
        if r >= 12:
            out.append(r)
    return out

pairs = list(itertools.combinations(o_labels, 2))
print(f"pairs: {len(pairs)}")

# ---------------------------------------------------------------- D_1 scan
print("\n== quadratic Casimir (k=1): D_1 is linear in n, slope |lambda|-|mu| ==")
bad1 = []
ident_zero = []
for lam, mu in pairs:
    p = diff_poly(lam, mu, 1)
    pp = sp.Poly(p, n)
    if pp.degree() < 1:
        if pp.is_zero:
            ident_zero.append((lam, mu))
        continue
    r = sp.Rational(-pp.all_coeffs()[1], pp.all_coeffs()[0])
    if r >= 12:
        bad1.append((lam, mu, r, sp.expand(p)))
print(f"pairs whose QUADRATIC Casimir difference has a root in [12,oo): {len(bad1)} of {len(pairs)}")
bad1.sort(key=lambda t: t[2])
for lam, mu, r, p in bad1[:6]:
    print(f"   {lam} vs {mu}:  D_1 = {p},  root n = {r}")
print("   ... largest root:", bad1[-1][:3] if bad1 else None)
integer_collisions = [t for t in bad1 if t[2].is_integer]
print(f"pairs whose QUADRATIC Casimir difference is IDENTICALLY ZERO: {len(ident_zero)}")
for lam, mu in ident_zero[:5]:
    print(f"      never separated by c_2: {lam} vs {mu}")
print(f"   of these, roots at INTEGER n >= 12: {len(integer_collisions)}")
for lam, mu, r, p in integer_collisions[:5]:
    print(f"      c_2 collision at n = {r}: {lam} vs {mu}")

# ------------------------------------------------- all six invariants
print("\n== all six separating invariants p_2, p_4, ..., p_12 ==")
import time
t0 = time.time()
DP = {}
for lam, mu in pairs:
    DP[(lam, mu)] = [sp.Poly(diff_poly(lam, mu, k), n) for k in range(1, 7)]
print(f"  built {6*len(pairs)} difference polynomials in {time.time()-t0:.1f}s")

t0 = time.time()
rootfree_count = []          # per pair: which k are root-free on [12,oo)
all_six_bad = []
zero_everywhere = []
for key, polys in DP.items():
    ok = []
    for k, pp in enumerate(polys, start=1):
        if pp.is_zero:
            continue                      # never separates: not root-free
        if pp.degree() < 1:
            ok.append(k)                  # nonzero constant: root-free
            continue
        if pp.count_roots(12, sp.oo) == 0:
            ok.append(k)
    rootfree_count.append((key, ok))
    if not ok:
        all_six_bad.append(key)
    if all(pp.is_zero for pp in polys):
        zero_everywhere.append(key)
print(f"  root counting done in {time.time()-t0:.1f}s")

hist = {}
for key, ok in rootfree_count:
    hist[len(ok)] = hist.get(len(ok), 0) + 1
print("  histogram: #invariants (of 6) whose difference is root-free on [12,oo)")
for m in sorted(hist):
    print(f"    {m} root-free : {hist[m]} pairs")
print(f"\n  PAIRS WITH NO ROOT-FREE INVARIANT AT ALL: {len(all_six_bad)}")
for key in all_six_bad[:10]:
    print(f"    {key[0]} vs {key[1]}")
    for k, pp in enumerate(DP[key], start=1):
        rs = [] if pp.is_zero else sp.real_roots(pp)
        rs = [r for r in rs if r >= 12]
        print(f"       p_{2*k}: {sp.factor(pp.as_expr())}   roots>=12: {rs}")
print(f"  pairs where ALL six differences vanish identically: {len(zero_everywhere)}")
