"""r235 -- independent lower bounds on the presentation degree k_B of Sym^l(W) over B_n.

Route that uses NEITHER r232's generation-degree argument NOR the coordinate-support
step.  Levin-Chandrasekaran Prop 2.9's proof shows: if a V-module U is presented in
degree k then dim U_n^{G_n} is CONSTANT for all n >= k.  So

        dim Sym^l(W_n)^{B_n} != dim Sym^l(W_{n+1})^{B_{n+1}}   ==>   k_B > n.

Everything is exact rational arithmetic (Fraction), by Burnside over the conjugacy
classes of the hyperoctahedral group B_n.

Class data.  A class of B_n is a pair of partitions (alpha | beta), |alpha|+|beta| = n:
alpha the positive cycles, beta the negative cycles.  Centralizer order
z = prod_L (2L)^{m_L(alpha)} m_L(alpha)! * prod_L (2L)^{m_L(beta)} m_L(beta)!.
Power sums: a positive L-cycle has the L-th roots of unity as eigenvalues; a negative
L-cycle has the roots of z^L = -1.  Hence

        p_j(g) = sum_{L | j} L * ( m_L(alpha) + (-1)^{j/L} m_L(beta) ).

Weyl character.  W_n = S^2(Lambda^2 R^n) - Lambda^4 R^n - S^2(R^n) as a virtual
O(n)-rep (S^2(Lambda^2) = C_n + Lambda^4 by first Bianchi; C_n = W_n + S^2 R^n).
"""
from fractions import Fraction
from functools import lru_cache
import sys

# ---------- partitions ----------
@lru_cache(maxsize=None)
def partitions(n, maxpart=None):
    if maxpart is None:
        maxpart = n
    if n == 0:
        return ((),)
    out = []
    for k in range(min(n, maxpart), 0, -1):
        for rest in partitions(n - k, k):
            out.append((k,) + rest)
    return tuple(out)

def mult(part):
    m = {}
    for k in part:
        m[k] = m.get(k, 0) + 1
    return m

def factorial(k):
    r = 1
    for i in range(2, k + 1):
        r *= i
    return r

def z_hyper(alpha, beta):
    z = 1
    for L, m in mult(alpha).items():
        z *= (2 * L) ** m * factorial(m)
    for L, m in mult(beta).items():
        z *= (2 * L) ** m * factorial(m)
    return z

def z_sym(lam):
    z = 1
    for L, m in mult(lam).items():
        z *= L ** m * factorial(m)
    return z

# ---------- characters ----------
def powersums(alpha, beta, jmax):
    """p[j] = tr(g^j) for j = 1..jmax."""
    ma, mb = mult(alpha), mult(beta)
    p = [0] * (jmax + 1)
    for j in range(1, jmax + 1):
        s = 0
        for L, m in ma.items():
            if j % L == 0:
                s += L * m
        for L, m in mb.items():
            if j % L == 0:
                s += L * m * (1 if (j // L) % 2 == 0 else -1)
        p[j] = s
    return p

def chi_weyl_at(p, k):
    """chi_{W_n}(g^k) from the power sums p[.] of g (needs p up to 4k)."""
    p1, p2, p3, p4 = p[k], p[2 * k], p[3 * k], p[4 * k]
    lam2_g = Fraction(p1 * p1 - p2, 2)          # chi_{Lambda^2}(g^k)
    lam2_g2 = Fraction(p2 * p2 - p4, 2)         # chi_{Lambda^2}(g^{2k})
    s2lam2 = (lam2_g * lam2_g + lam2_g2) / 2    # chi_{S^2(Lambda^2)}(g^k)
    lam4 = Fraction(p1**4 - 6 * p1 * p1 * p2 + 3 * p2 * p2 + 8 * p1 * p3 - 6 * p4, 24)
    s2 = Fraction(p1 * p1 + p2, 2)
    return s2lam2 - lam4 - s2

def classes(n):
    for a in range(n + 1):
        for alpha in partitions(a):
            for beta in partitions(n - a):
                yield alpha, beta

def sym_invariant_dim(n, ell):
    """dim Sym^ell(W_n)^{B_n}, exactly."""
    lams = partitions(ell)
    total = Fraction(0)
    for alpha, beta in classes(n):
        p = powersums(alpha, beta, 4 * ell)
        chi = {k: chi_weyl_at(p, k) for k in range(1, ell + 1)}
        h = Fraction(0)
        for lam in lams:
            t = Fraction(1, z_sym(lam))
            for part in lam:
                t *= chi[part]
            h += t
        total += h / z_hyper(alpha, beta)
    assert total.denominator == 1, f"non-integral dimension {total} at n={n}, l={ell}"
    return int(total)

def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12

if __name__ == "__main__":
    # sanity: class weights sum to 1, and chi_W(e) = dim W_n
    for n in (4, 6, 9):
        s = sum(Fraction(1, z_hyper(a, b)) for a, b in classes(n))
        assert s == 1, (n, s)
        p = powersums(tuple([1] * n), (), 8)
        assert chi_weyl_at(p, 1) == dim_weyl(n), (n, chi_weyl_at(p, 1), dim_weyl(n))
    print("sanity OK: class weights sum to 1; chi_W(identity) = dim W_n")

    ells = [int(x) for x in (sys.argv[1].split(",") if len(sys.argv) > 1 else ["1", "2"])]
    nlo, nhi = (int(sys.argv[2]), int(sys.argv[3])) if len(sys.argv) > 3 else (3, 14)
    for ell in ells:
        print(f"\n  l = {ell}:  dim Sym^{ell}(W_n)^(B_n)   [gen degree predicted 4l = {4*ell}]")
        prev = None
        for n in range(nlo, nhi + 1):
            d = sym_invariant_dim(n, ell)
            flag = ""
            if prev is not None:
                flag = "  same" if d == prev else f"  CHANGED (so k_B > {n-1})"
            print(f"    n={n:>3}  dim W_n={dim_weyl(n):>7}   dim = {d:>12}{flag}", flush=True)
            prev = d
