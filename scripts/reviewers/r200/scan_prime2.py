"""Reviewer 200, claim 2 part b: how much of the escape is STRUCTURE and how
much is luck?  If the numerators' prime factors were bounded well below 10^6,
then any prime near 10^6 works and the choice is principled.  If primes near
10^6 do divide numerators, then 1000033 is a lucky draw and the next cache
rebuild can undo it."""
import pickle, os, collections, sympy

RUNS = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                    "..", "..", "runs"))
RAW = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))

nums, dens = set(), set()
for lam, cs in RAW.items():
    for copy in cs:
        for vec in copy:
            for mi, (a, b) in vec.items():
                for f in (a, b):
                    if f.numerator: nums.add(abs(f.numerator))
                    dens.add(f.denominator)
print(f"distinct |numerators| {len(nums)}, distinct denominators {len(dens)}")
print(f"largest numerator has {len(str(max(nums)))} digits")
print(f"denominator prime support: "
      f"{sorted({q for d in dens for q in sympy.factorint(d)})}")

pf = collections.Counter()
for v in nums:
    for q in sympy.factorint(v): pf[q] += 1
ps = sorted(pf)
print(f"distinct primes dividing some numerator: {len(ps)}, "
      f"largest {ps[-1]}")
big = [q for q in ps if q > 900000]
print(f"primes in (9*10^5, 10^6+] dividing some numerator: {len(big)} -> {big[:20]}")
import bisect
lo = bisect.bisect_left(ps, 900000)
print(f"count of primes p with 9e5 < p < 1.1e6 that are hit: {len(big)}")
tot_range = sympy.primepi(1100000) - sympy.primepi(900000)
print(f"primes in that window: {tot_range}; hit fraction "
      f"{len(big)/float(tot_range):.4f}")
print(f"is 1000033 hit: {1000033 in pf};  is 65537 hit: {65537 in pf} "
      f"(count {pf.get(65537)})")
# how many primes below 1e6 are hit at all
hit_below = sum(1 for q in ps if q < 1000000)
print(f"primes < 10^6 dividing some numerator: {hit_below} of "
      f"{sympy.primepi(1000000)}")
