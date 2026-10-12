"""Reviewer 179.  Stable-range dimension of the degree-k O(n)-invariants on Weyl_n,
by Weyl integration + the Diaconis-Evans exact moment formula.

  chi_Weyl(g) = chi_{S^2 Lambda^2}(g) - chi_{Lambda^4}(g) - chi_{S^2}(g),
a universal polynomial in p_j = tr(g^j), j <= 4.

  dim (Sym^k Weyl)^{O(n)} = int_{O(n)} h_k(eig(g|Weyl)) dg,   h_k = sum_{rho|-k} p_rho/z_rho,
  p_j(eig(g|Weyl)) = chi_Weyl(g^j)  [p_m -> p_{jm}].

Diaconis-Evans: for O(n), E[prod_m tr(g^m)^{a_m}] = prod_m E[(sqrt(m) Z_m + eta_m)^{a_m}]
(Z_m iid standard normal, eta_m = 1 if m even else 0) EXACTLY when sum_m m*a_m <= n.
The largest weight occurring at degree k is 4k, so the formula is exact for n >= 4k.
"""
import sympy as sp
from sympy.utilities.iterables import partitions

P = {m: sp.Symbol(f"p{m}") for m in range(1, 200)}

def chi_weyl(j=1):
    """character of Weyl_n at g^j, as a polynomial in p_{jm}."""
    p = lambda m: P[j*m]
    l2   = (p(1)**2 - p(2))/2
    l2sq = (p(2)**2 - p(4))/2          # chi_{Lambda^2}(g^2)
    s2l2 = (l2**2 + l2sq)/2
    e4 = (p(1)**4 - 6*p(1)**2*p(2) + 3*p(2)**2 + 8*p(1)*p(3) - 6*p(4))/24
    s2 = (p(1)**2 + p(2))/2
    return sp.expand(s2l2 - e4 - s2)

def z(rho):
    from collections import Counter
    c = Counter(rho); r = 1
    for part, m in c.items(): r *= part**m * sp.factorial(m)
    return r

def hk(k):
    tot = 0
    for d in partitions(k):
        rho = []
        for part, m in d.items(): rho += [part]*m
        term = sp.Integer(1)
        for j in rho: term *= chi_weyl(j)
        tot += sp.expand(term)/z(rho)
    return sp.expand(tot)

def gauss_moment(m, a):
    """E[(sqrt(m) Z + eta_m)^a], eta_m = 1 iff m even."""
    eta = 1 if m % 2 == 0 else 0
    tot = sp.Integer(0)
    for i in range(a+1):
        if i % 2: continue
        mom = sp.Integer(1)
        for t in range(1, i, 2): mom *= t         # (i-1)!!
        tot += sp.binomial(a, i) * eta**(a-i) * sp.Integer(m)**(i//2) * mom
    return tot

def stable_dim(k, report_weight=False):
    expr = sp.Poly(hk(k), *[P[m] for m in range(1, 4*k+1)])
    total = sp.Integer(0); maxw = 0
    for mono, coeff in zip(expr.monoms(), expr.coeffs()):
        w = sum((i+1)*a for i, a in enumerate(mono))
        maxw = max(maxw, w)
        val = coeff
        for i, a in enumerate(mono):
            if a: val *= gauss_moment(i+1, a)
        total += val
    if report_weight: return sp.nsimplify(total), maxw
    return sp.nsimplify(total)

if __name__ == "__main__":
    for k in range(1, 8):
        d, w = stable_dim(k, True)
        print(f"k={k}: stable dim = {d}   (max power-sum weight {w} -> DE exact for n >= {w})", flush=True)
