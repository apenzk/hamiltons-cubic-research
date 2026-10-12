"""r239, claim 1.  dim (Sym^k W_n)^{O(n)} in the stable range, by Haar integration
over O(n) -- a third route, sharing nothing with the Hall pairing (r238) or the
Littlewood restriction rule (r224).

THE ROUTE.
  (a) The Weyl character is built from scratch out of traces of powers:
        A_n  = S^2(Lambda^2 V) - Lambda^4 V           (algebraic curvature tensors,
                                                       first Bianchi removed)
        W_n  = A_n - S^2_0(V) - triv                  (Ricci and scalar removed)
      so  chi_W(g) = chi_{S^2 Lam^2}(g) - e_4(g) - (p_1^2+p_2)/2,
      a polynomial in p_j(g) = tr(g^j), j <= 4.  Checked against
      dim W_n = n(n+1)(n+2)(n-3)/12 at g = 1.
  (b) chi_{Sym^k W}(g) = sum_{rho |- k} z_rho^{-1} prod_i chi_W(g^{rho_i}),
      and chi_W(g^m) is the same polynomial with p_j -> p_{jm}.  So the whole
      character is an explicit polynomial in p_1..p_{4k} with rational coefficients.
  (c) dim (Sym^k W)^{O(n)} = int_{O(n)} chi_{Sym^k W}(g) dg.  By the exact-moment
      theorem for the orthogonal group (Diaconis-Shahshahani; Diaconis-Evans,
      TAMS 353 (2001), Thm 4), for Haar g on O(n),
        E[ prod_j tr(g^j)^{a_j} ]  =  E[ prod_j (eta_j + sqrt(j) Z_j)^{a_j} ]
      EXACTLY whenever sum_j j*a_j <= n, with Z_j iid N(0,1) and eta_j = 1 for j
      even, 0 for j odd.  Every monomial here has weighted degree exactly 4k, so
      the answer produced is the exact value of the integral for every n >= 4k.

Everything is Fractions; the output is an exact integer.
"""
from fractions import Fraction
from itertools import product as iproduct
import sys

# ---------- polynomials in p_1, p_2, ... : dict {exponent-tuple: Fraction} ----------

def pmul(A, B):
    C = {}
    for ea, ca in A.items():
        for eb, cb in B.items():
            L = max(len(ea), len(eb))
            e = tuple((ea[i] if i < len(ea) else 0) + (eb[i] if i < len(eb) else 0)
                      for i in range(L))
            C[e] = C.get(e, Fraction(0)) + ca * cb
    return {e: c for e, c in C.items() if c != 0}

def padd(A, B):
    C = dict(A)
    for e, c in B.items():
        C[e] = C.get(e, Fraction(0)) + c
    return {e: c for e, c in C.items() if c != 0}

def pscale(A, s):
    s = Fraction(s)
    return {e: c * s for e, c in A.items() if c * s != 0}

def pvar(j, power=1):
    """p_j^power"""
    return {tuple([0] * (j - 1) + [power]): Fraction(1)}

ONE = {(): Fraction(1)}

def adams(A, m):
    """substitute p_j -> p_{jm}"""
    C = {}
    for e, c in A.items():
        L = len(e) * m
        new = [0] * L
        for i, a in enumerate(e):
            if a:
                new[(i + 1) * m - 1] = a
        C[tuple(new)] = C.get(tuple(new), Fraction(0)) + c
    return C

# ---------- Newton: e_k and h_k of the eigenvalues, as polynomials in p_j ----------

def elementary(k):
    """e_k in power sums, by Newton's identity  k e_k = sum_{i=1}^k (-1)^{i-1} e_{k-i} p_i."""
    e = [ONE]
    for m in range(1, k + 1):
        acc = {}
        for i in range(1, m + 1):
            term = pmul(e[m - i], pvar(i))
            acc = padd(acc, pscale(term, Fraction((-1) ** (i - 1))))
        e.append(pscale(acc, Fraction(1, m)))
    return e[k]

# ---------- chi_W, from definitions ----------

p1, p2, p3, p4 = pvar(1), pvar(2), pvar(3), pvar(4)

lam2 = pscale(padd(pmul(p1, p1), pscale(p2, -1)), Fraction(1, 2))          # e_2
lam2_sq_arg = pscale(padd(pmul(p2, p2), pscale(p4, -1)), Fraction(1, 2))    # e_2 at g^2
s2lam2 = pscale(padd(pmul(lam2, lam2), lam2_sq_arg), Fraction(1, 2))        # S^2(Lambda^2)
lam4 = elementary(4)
s2_0 = padd(pscale(padd(pmul(p1, p1), p2), Fraction(1, 2)), pscale(ONE, -1))

CHI_W = padd(padd(s2lam2, pscale(lam4, -1)),
             pscale(padd(pmul(p1, p1), p2), Fraction(-1, 2)))               # = s2lam2 - lam4 - s2_0 - 1

CHI_V = p1
CHI_S20 = s2_0
CHI_LAM2 = lam2

def at_identity(A, n):
    """evaluate with every p_j = n"""
    tot = Fraction(0)
    for e, c in A.items():
        v = c
        for a in e:
            v *= Fraction(n) ** a
        tot += v
    return tot

# ---------- partitions, z_rho ----------

def partitions(k, maxpart=None):
    if maxpart is None:
        maxpart = k
    if k == 0:
        yield ()
        return
    for first in range(min(k, maxpart), 0, -1):
        for rest in partitions(k - first, first):
            yield (first,) + rest

def zrho(rho):
    from collections import Counter
    c = Counter(rho)
    z = 1
    for part, mult in c.items():
        z *= part ** mult
        for i in range(1, mult + 1):
            z *= i
    return z

def sym_power_char(chi, k):
    """chi_{Sym^k}(g) = sum_{rho |- k} z_rho^{-1} prod chi(g^{rho_i})"""
    tot = {}
    for rho in partitions(k):
        term = ONE
        for part in rho:
            term = pmul(term, adams(chi, part))
        tot = padd(tot, pscale(term, Fraction(1, zrho(rho))))
    return tot

# ---------- the Haar moment functional on O(n), exact for weighted degree <= n ----------

def dfact(m):
    """(m-1)!! for even m>=0"""
    r = 1
    x = m - 1
    while x > 1:
        r *= x
        x -= 2
    return r

from math import comb

def moment_one(j, a):
    """E[(eta_j + sqrt(j) Z)^a],  eta_j = 1 if j even else 0."""
    if j % 2 == 1:
        return Fraction(0) if a % 2 else Fraction(j ** (a // 2) * dfact(a))
    tot = Fraction(0)
    for i in range(0, a + 1, 2):
        tot += Fraction(comb(a, i) * (j ** (i // 2)) * dfact(i))
    return tot

def haar_O(A):
    tot = Fraction(0)
    for e, c in A.items():
        v = c
        for i, a in enumerate(e):
            if a:
                v *= moment_one(i + 1, a)
        tot += v
    return tot

def weighted_degree(A):
    return max((sum((i + 1) * a for i, a in enumerate(e)) for e in A), default=0)

# ---------- run ----------

def report(name, chi, kmax, expected=None):
    print(f"--- {name} ---")
    out = []
    for k in range(0, kmax + 1):
        ch = sym_power_char(chi, k)
        val = haar_O(ch)
        deg = weighted_degree(ch)
        assert val.denominator == 1, (name, k, val)
        out.append(int(val))
        print(f"  k={k}: dim (Sym^k)^O(n) = {int(val)}   (exact for n >= {deg})")
    if expected is not None:
        print(f"  expected {expected}")
        print("  MATCH" if out[1:len(expected) + 1] == expected else "  *** MISMATCH ***")
    return out

if __name__ == "__main__":
    # sanity: dim W_n = n(n+1)(n+2)(n-3)/12
    for n in range(4, 15):
        got = at_identity(CHI_W, n)
        want = Fraction(n * (n + 1) * (n + 2) * (n - 3), 12)
        assert got == want, (n, got, want)
    print("chi_W(1) = n(n+1)(n+2)(n-3)/12 for n=4..14: OK")
    print("chi_W in power sums:", {tuple(e): str(c) for e, c in sorted(CHI_W.items())})
    print()

    # CONTROLS with independently known answers
    report("vector rep V  (expect 0,1,0,1,0,1 : only |x|^2)", CHI_V, 6, [0, 1, 0, 1, 0, 1])
    report("S^2_0 V  (expect partitions of k into parts >=2: 0,1,1,2,2,4)",
           CHI_S20, 6, [0, 1, 1, 2, 2, 4])
    report("Lambda^2 V  (expect partitions of k into even parts: 0,1,0,2,0,3)",
           CHI_LAM2, 6, [0, 1, 0, 2, 0, 3])
    print()

    seq = report("WEYL  W_n  -- THE CLAIM: 0,1,2,7,19,89", CHI_W, 6, [0, 1, 2, 7, 19, 89])
    print()
    print("VERDICT sequence k=1..6:", seq[1:])
