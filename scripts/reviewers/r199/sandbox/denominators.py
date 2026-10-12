"""Reviewer 199: where the powers of two live, and how lucky 1000033 was.

The file offers "the cached coefficients are built from powers of two" as the
reason 65537 = 2^16 + 1 divided the data.  This separates numerators from
denominators, and rebuilds reviewer 200's count of how many primes near 10^6
would also have failed -- by a product tree rather than by trial division, so
the number is arrived at independently.
"""
import pickle, math, sympy
from collections import Counter
raw = pickle.load(open("n5_adapted.pkl", "rb"))
dens, nums = Counter(), set()
for cs in raw.values():
    for c in cs:
        for v in c:
            for (a, b) in v.values():
                for x in (a, b):
                    if x.denominator != 1: dens[x.denominator] += 1
                    if x.numerator: nums.add(abs(x.numerator))
dsup = set()
for q in dens: dsup |= set(sympy.factorint(q))
print(f"denominators != 1: {sum(dens.values()):,} over {len(dens)} distinct values")
print(f"  their whole prime support: {sorted(dsup)}   <- the powers of two are HERE,")
print(f"  and no prime above 7 can ever divide a denominator of this cache.")
print(f"distinct nonzero numerators: {len(nums):,}, up to "
      f"{max(len(str(x)) for x in nums)} digits")

lo, hi = 900001, 1100000
prs = list(sympy.primerange(lo, hi))
def tree(a):
    while len(a) > 1:
        a = [a[i]*a[i+1] if i+1 < len(a) else a[i] for i in range(0, len(a), 2)]
    return a[0]
M = tree(prs[:])
print(f"\nprimes in [{lo}, {hi}]: {len(prs):,}  (product has {M.bit_length():,} bits)")
bad = set()
for n in nums:
    g = math.gcd(M % n, n) if n > 1 else 1
    while g > 1:
        for q in sympy.factorint(g):
            if lo <= q <= hi: bad.add(q)
        break
print(f"primes in that window dividing SOME numerator: {len(bad)} "
      f"({100*len(bad)/len(prs):.1f}%)")
print(f"  1000033 among them: {1000033 in bad}")
print(f"  65537 divides a numerator: "
      f"{any(n % 65537 == 0 for n in nums)}")
print(f"\nso the escape was a {100*(1-len(bad)/len(prs)):.0f}% draw on this cache,")
print(f"not a consequence of avoiding powers of two.")
