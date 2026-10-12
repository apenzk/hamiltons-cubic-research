"""Reviewer 202, claim 4, second half: reproduce the 681 and locate it.

Full factorisation of every distinct nonzero |numerator|, then the three
counts that separate r199's figure from r200's:
  A. primes q with 900000 < q < 1100000 dividing some numerator   (the window)
  B. primes q with q > 900000, NO UPPER BOUND, dividing some numerator
  C. the same, restricted to q > 1100000
"""
import pickle, os, time, collections, sympy
RUNS = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
t0=time.time()
RAW = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))
nums=set()
for cs in RAW.values():
    for c in cs:
        for v in c:
            for (a,b) in v.values():
                for f in (a,b):
                    if f.numerator: nums.add(abs(f.numerator))
pf = collections.Counter()
for v in sorted(nums):
    for q in sympy.factorint(v): pf[q]+=1
ps = sorted(pf)
print(f"distinct |numerators| {len(nums):,}; distinct primes dividing some "
      f"numerator {len(ps):,}; largest {ps[-1]:,}   [{time.time()-t0:.1f}s]")
A = [q for q in ps if 900000 < q < 1100000]
B = [q for q in ps if q > 900000]
C = [q for q in ps if q >= 1100000]
tot = int(sympy.primepi(1100000) - sympy.primepi(900000))
print(f"A  in-window (9e5,1.1e6)      : {len(A)}   -> {100.0*len(A)/tot:.2f}% of the {tot:,} window primes")
print(f"B  q > 9e5, NO upper bound    : {len(B)}   -> r200 divided THIS by {tot:,}: {100.0*len(B)/tot:.2f}%")
print(f"C  q >= 1.1e6 (outside window): {len(C)}   (= B - A = {len(B)-len(A)})")
print(f"primes < 10^6 dividing some numerator: {sum(1 for q in ps if q<10**6):,}")
print(f"1000033 hit: {1000033 in pf};  65537 hit: {65537 in pf} (count {pf.get(65537)})")
