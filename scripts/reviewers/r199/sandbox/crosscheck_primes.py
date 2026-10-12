"""Reviewer 199: my 103 against reviewer 200's 681 -- brute force on a subwindow.

Two independent methods over the SAME numerator set and the SAME primes:
  (a) gcd against a product tree of the primes, then factor the gcd;
  (b) plain trial division, every prime against every numerator.
If they agree the gcd method is sound and the discrepancy is elsewhere.
"""
import pickle, math, sympy
raw = pickle.load(open("n5_adapted.pkl", "rb"))
nums = set()
for cs in raw.values():
    for c in cs:
        for v in c:
            for (a, b) in v.values():
                for x in (a, b):
                    if x.numerator: nums.add(abs(x.numerator))
nums = sorted(nums)
print(f"{len(nums):,} distinct nonzero numerators")

prs = list(sympy.primerange(900001, 1000000))[:600]
print(f"subwindow: {len(prs)} primes, {prs[0]} .. {prs[-1]}")

def tree(a):
    while len(a) > 1:
        a = [a[i]*a[i+1] if i+1 < len(a) else a[i] for i in range(0, len(a), 2)]
    return a[0]
M = tree(prs[:])
A = set()
for n in nums:
    g = math.gcd(M % n, n)
    if g > 1: A |= {q for q in sympy.factorint(g)}
print(f"(a) gcd + product tree : {len(A)} primes divide some numerator")

B = set()
for p in prs:
    for n in nums:
        if n % p == 0: B.add(p); break
print(f"(b) plain trial division: {len(B)} primes divide some numerator")
print(f"agree: {A == B}")
if A != B: print("   symmetric difference:", sorted(A ^ B)[:10])
