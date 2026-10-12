"""r238, claim 6.  The UNIVERSAL (stable) count of O(n)-invariants in Sym^k(Weyl_n).

Independent of the repo: nothing is read from it.  Two classical facts only.

  (1) The stable character of the Weyl module is Littlewood's
        omega_(2,2) = s_(2,2) - s_(2),
      and the character of Sym^k of it is the plethysm h_k[omega_(2,2)].

  (2) Littlewood's restriction rule, valid for ell(lambda) <= n/2:
        s_lambda |_{O(n)} = sum_mu ( sum_{delta even} c^lambda_{mu delta} ) [mu]_O.
      Taking mu = () gives c^lambda_{(),delta} = [lambda = delta], so the
      multiplicity of the TRIVIAL O-rep in s_lambda is 1 exactly when every part
      of lambda is even, and 0 otherwise.

  Hence  dim (Sym^k W)^{O} (stable)  =  sum over all-even lambda of the Schur
  coefficient of h_k[omega_(2,2)]  =  < h_k[omega_(2,2)] , sum_{lambda even} s_lambda >.

  The pairing is done in the power-sum basis, where the second factor is the
  classical product prod_{i<=j} (1 - x_i x_j)^{-1} = exp( sum_m (p_m^2+p_2m)/(2m) ),
  so no Schur expansion in degree 24 is ever needed.

  Everything is exact (Fraction).  All parts of h_k[omega_(2,2)] have at most 2k
  rows, so the restriction rule applies whenever n >= 4k -- the classical stable
  range.  The number printed is therefore the value for every n >= 4k.
"""
from fractions import Fraction
from itertools import count

def parts(n, mx=None):
    if mx is None: mx = n
    if n == 0:
        yield ()
        return
    for f in range(min(n, mx), 0, -1):
        for rest in parts(n - f, f):
            yield (f,) + rest

def zmu(mu):
    z = 1
    from collections import Counter
    c = Counter(mu)
    for k, m in c.items():
        z *= (k ** m)
        for i in range(1, m + 1):
            z *= i
    return z

def mul(a, b, D=None):
    out = {}
    for ka, va in a.items():
        for kb, vb in b.items():
            k = tuple(sorted(ka + kb, reverse=True))
            if D is not None and sum(k) > D: continue
            out[k] = out.get(k, Fraction(0)) + va * vb
    return {k: v for k, v in out.items() if v}

def add(a, b):
    out = dict(a)
    for k, v in b.items():
        out[k] = out.get(k, Fraction(0)) + v
        if out[k] == 0: del out[k]
    return out

def scale(a, c):
    return {k: v * c for k, v in a.items() if v * c != 0}

def pk_of(f, k):
    """plethysm p_k o f : send p_j -> p_{jk}."""
    return {tuple(sorted((j * k for j in key), reverse=True)): v for key, v in f.items()}

# --- omega_(2,2) = s_(2,2) - s_(2), in the power-sum basis -------------------
s2   = {(1, 1): Fraction(1, 2), (2,): Fraction(1, 2)}
s22  = {(1, 1, 1, 1): Fraction(1, 12), (2, 2): Fraction(1, 4), (3, 1): Fraction(-1, 3)}
omega22 = add(s22, scale(s2, Fraction(-1)))

def h_pleth(f, d):
    """h_d[f] in the power-sum basis."""
    tot = {}
    for mu in parts(d):
        term = {(): Fraction(1)}
        for k in mu:
            term = mul(term, pk_of(f, k))
        tot = add(tot, scale(term, Fraction(1, zmu(mu))))
    return tot

def H_even(D):
    """sum_{lambda even} s_lambda = exp( sum_m (p_m^2 + p_{2m})/(2m) ), truncated to degree D."""
    H = {(): Fraction(1)}
    for m in range(1, D // 2 + 1):
        u = {(m, m): Fraction(1, 2 * m), (2 * m,): Fraction(1, 2 * m)}
        e = {(): Fraction(1)}
        term = {(): Fraction(1)}
        fac = 1
        for j in count(1):
            term = mul(term, u, D)
            if not term: break
            fac *= j
            e = add(e, scale(term, Fraction(1, fac)))
        H = mul(H, e, D)
    return H

def trivial_mult(f, D):
    H = H_even(D)
    tot = Fraction(0)
    for k, v in f.items():
        if k in H:
            tot += v * H[k] * zmu(k)
    assert tot.denominator == 1, tot
    return int(tot)

if __name__ == "__main__":
    # --- sanity 1: <s_lambda, H> = 1 iff lambda even ------------------------
    # s_lambda in p basis via characters is overkill; instead check H against
    # known small cases directly: degree 2 -> only s_(2); degree 4 -> s_(4)+s_(2,2).
    H4 = H_even(4)
    # h_2 = s_(2), e_2 = s_(1,1):  <s_2,H> should be 1, <s_11,H> 0
    h2 = {(1, 1): Fraction(1, 2), (2,): Fraction(1, 2)}
    e2 = {(1, 1): Fraction(1, 2), (2,): Fraction(-1, 2)}
    def ip(a, H):
        return sum(v * H[k] * zmu(k) for k, v in a.items() if k in H)
    assert ip(h2, H4) == 1 and ip(e2, H4) == 0, (ip(h2, H4), ip(e2, H4))
    print("sanity: <s_(2),H> = 1, <s_(1,1),H> = 0  -- the even-partition pairing is right")

    # --- sanity 2: dim of the module itself, p_k -> n ------------------------
    def at_n(f, n):
        return sum(v * (n ** len(k)) for k, v in f.items())
    assert at_n(omega22, 12) == 1638, at_n(omega22, 12)
    print("sanity: omega_(2,2) at n=12 evaluates to 1638 = dim Weyl_12")

    # --- the counts ---------------------------------------------------------
    print()
    print(" k   deg  universal dim (Sym^k Weyl)^{O(n)}, valid n >= 4k")
    res = {}
    for k in range(1, 7):
        f = h_pleth(omega22, k)
        D = 4 * k
        m = trivial_mult(f, D)
        res[k] = m
        print("  %d   %2d          %d" % (k, D, m))
    print()
    print("RESULT: universal degree-6 count =", res[6])
