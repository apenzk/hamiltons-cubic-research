"""Reviewer 200, claim 2: is 1000033 fit for purpose, and does the cache
vanish mod it?

Three scans, in increasing strength:
  A. p divides the numerator of the real or imaginary PART -- exactly what
     reviewer 197 ran against 65537.
  B. p divides a DENOMINATOR -- to_p's assert would fire, so this is a crash
     rather than a false zero, but it is the same scan.
  C. the GAUSSIAN reduction to_p(a+bi) = a + b*IMOD vanishes while (a,b) != 0.
     This is the condition the code actually depends on and it is STRICTLY
     weaker than A: a coefficient with both parts nonzero and neither divisible
     by p still dies if a = -b*IMOD mod p.  197's scan could not see these.
Also: the same three scans against 65537, to reproduce 197's witness, and a
count of how many primes below 10^6 would have produced a part-wise hit.
"""
import pickle, os, sys, collections

RUNS = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                    "..", "..", "runs"))
with open(os.path.join(RUNS, "n5_adapted.pkl"), "rb") as f:
    RAW = pickle.load(f)

NEW, OLD = 1000033, 65537

def imod(p):
    return next(x for x in range(2, p) if pow(x, 2, p) == p - 1)

def scan(p, I):
    a_hits, b_hits, c_hits = [], [], []
    nvec = ncoef = 0
    for lam, cs in RAW.items():
        for ci, copy in enumerate(cs):
            for vi, vec in enumerate(copy):
                nvec += 1
                for mi, (a, b) in vec.items():
                    ncoef += 1
                    if (a.numerator and a.numerator % p == 0) or \
                       (b.numerator and b.numerator % p == 0):
                        a_hits.append((lam, ci, vi, mi, a, b))
                    if a.denominator % p == 0 or b.denominator % p == 0:
                        b_hits.append((lam, ci, vi, mi, a, b))
                    if a.numerator == 0 and b.numerator == 0:
                        continue
                    r = (a.numerator * pow(a.denominator % p, p-2, p)
                         + b.numerator * pow(b.denominator % p, p-2, p) * I) % p
                    if r == 0:
                        c_hits.append((lam, ci, vi, mi, a, b))
    return nvec, ncoef, a_hits, b_hits, c_hits

for p in (OLD, NEW):
    I = imod(p)
    nvec, ncoef, A, B, C = scan(p, I)
    print(f"=== p = {p}  (i -> {I}) ===")
    print(f"  vectors {nvec}, stored coefficients {ncoef}")
    print(f"  A part-numerator divisible by p : {len(A)}")
    for h in A[:6]: print(f"      lambda={h[0]} copy={h[1]} pos={h[2]} mono={h[3]}  re={h[4]} im={h[5]}")
    print(f"  B denominator divisible by p    : {len(B)}")
    print(f"  C full Gaussian reduction zero  : {len(C)}")
    for h in C[:6]: print(f"      lambda={h[0]} copy={h[1]} pos={h[2]} mono={h[3]}  re={h[4]} im={h[5]}")
    sys.stdout.flush()

# how special is 65537?  every prime factor that appears in any numerator.
print("\n=== which primes divide some stored numerator ===")
import sympy
big = collections.Counter()
seen = set()
for lam, cs in RAW.items():
    for copy in cs:
        for vec in copy:
            for mi, (a, b) in vec.items():
                for f in (a.numerator, b.numerator):
                    if f: seen.add(abs(f))
tot = collections.Counter()
for v in seen:
    for q in sympy.factorint(v):
        tot[q] += 1
odd = {q: c for q, c in tot.items() if q > 1000}
print(f"  distinct |numerators|: {len(seen)}")
print(f"  primes > 1000 dividing some numerator: {sorted(odd)}")
print(f"  is 65537 among them: {65537 in tot}   is 1000033: {1000033 in tot}")
print(f"  all primes appearing, with multiplicity of distinct numerators: "
      f"{dict(sorted(tot.items())[:20])}")
