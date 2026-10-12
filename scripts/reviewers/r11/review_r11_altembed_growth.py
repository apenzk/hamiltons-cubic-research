"""P2 residue: the growth argument for alternative embeddings, written out.

An alternative (non-block) embedding of an isotropy algebra k = k1 + k2 into
so(n) requires R^n to contain a summand V1 (x) V2 with BOTH factors nontrivial
-- that is what distinguishes it from the block embedding V1 + V2.  Hence

        n  >=  m(k1) * m(k2),

with m(g) the minimal dimension of a nontrivial irreducible real representation.
Meanwhile dim k = dim k1 + dim k2 must be large enough to be a symmetric isotropy
of so(n), i.e. p <= dim so(n) and (for a two-eigenvalue pair) 2q > p.

Minimal nontrivial real irrep dimensions (classical + exceptional):
    su(r+1): r+1          sp(r): 2r
    so(2r+1): min(2r+1, 2^r)      so(2r): min(2r, 2^(r-1))
    G2: 7   F4: 26   E6: 27 (real form 54)   E7: 56   E8: 248
The spin dimensions are the only ones that can beat the vector representation,
and only at small rank -- which is why the earlier spin-only enumeration found
n = 8 uniquely.  This sweeps ALL types, not just spin.
"""
import itertools

def types(maxrank=40):
    out = []
    for r in range(1, maxrank+1):
        out.append((f"su({r+1})", (r+1)*(r+1)-1, r+1))
        out.append((f"sp({r})",   r*(2*r+1),     2*r))
        if r >= 2:
            v, s = 2*r+1, 2**r
            out.append((f"so({2*r+1})", r*(2*r+1), min(v, s)))
        if r >= 3:
            v, s = 2*r, 2**(r-1)
            out.append((f"so({2*r})", r*(2*r-1), min(v, s)))
    out += [("G2", 14, 7), ("F4", 52, 26), ("E6", 78, 54), ("E7", 133, 56), ("E8", 248, 248)]
    return out

T = types()
NMAX = 200
sols = []
for (n1, d1, m1), (n2, d2, m2) in itertools.combinations_with_replacement(T, 2):
    prod = m1 * m2
    if prod > NMAX:
        continue
    p = d1 + d2
    n = prod
    N = n * (n - 1) // 2
    q = N - p                     # if h = so(n); the most permissive case
    if p > N:                     # k cannot exceed so(n)
        continue
    sols.append((n, f"{n1} x {n2}", m1, m2, p, N, 2*q > p))

print(f"alternative-embedding candidates with m(k1)*m(k2) = n <= {NMAX}:")
print(f"{'n':>5} {'pair':<24} {'m1':>4} {'m2':>4} {'dim k':>7} {'dim so(n)':>10} {'2q>p':>6}")
print("-" * 68)
for n, lab, m1, m2, p, N, ok in sorted(sols):
    print(f"{n:>5} {lab:<24} {m1:>4} {m2:>4} {p:>7} {N:>10} {str(ok):>6}")
print("-" * 68)
print(f"total: {len(sols)}   largest n: {max(s[0] for s in sols) if sols else '-'}")
big = [s for s in sols if s[0] >= 12]
print(f"with n >= 12 (the range the conjecture lives in): {len(big)}")
for n, lab, m1, m2, p, N, ok in sorted(big):
    print(f"   n={n:<4} {lab:<24} dim k = {p}")
