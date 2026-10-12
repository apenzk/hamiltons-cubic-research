"""r201, claim 4: how many primes in (9e5, 1.1e6) divide a cached numerator?
Independent route: strip the small-prime part of every DISTINCT numerator, then
trial-divide the surviving cofactors by the 14,4xx primes in the window."""
import pickle, sys
from fractions import Fraction as F

raw = pickle.load(open("scripts/runs/n5_adapted.pkl","rb"))

nums, dens, coeffs, bothparts = set(), set(), 0, 0
for cs in raw.values():
    for c in cs:
        for vec in c:
            for (a, b) in vec.values():
                coeffs += 1
                if a.numerator and b.numerator: bothparts += 1
                for x in (a, b):
                    if x.numerator: nums.add(abs(x.numerator))
                    dens.add(x.denominator)
print(f"coefficients {coeffs}, both parts nonzero {bothparts}")
print(f"distinct nonzero numerators {len(nums)}, distinct denominators {len(dens)}")

def sieve(n):
    s = bytearray([1])*(n+1); s[0]=s[1]=0
    for i in range(2,int(n**0.5)+1):
        if s[i]: s[i*i::i] = bytearray(len(s[i*i::i]))
    return [i for i in range(n+1) if s[i]]

SMALL = sieve(100000)
LO, HI = 900000, 1100000
WIN = [p for p in sieve(HI) if p > LO]
print(f"primes in ({LO},{HI}): {len(WIN)}")

def hits(S, label):
    cof = set()
    for n in S:
        m = n
        for p in SMALL:
            if p*p > m: break
            while m % p == 0: m //= p
        if m > 1: cof.add(m)
    print(f"  [{label}] cofactors > 1 after stripping primes < 1e5: {len(cof)}"
          f"  max bits {max((x.bit_length() for x in cof), default=0)}")
    found = set()
    for p in WIN:
        for m in cof:
            if m % p == 0: found.add(p); break
    print(f"  [{label}] primes in the window dividing one: {len(found)}")
    return found, cof

fn, cofn = hits(nums, "numerators")
fd, cofd = hits(dens, "denominators")
print(f"union numerator|denominator: {len(fn | fd)}")
print(f"sample numerator-hit primes: {sorted(fn)[:12]}")
