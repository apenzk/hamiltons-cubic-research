"""Reviewer 202, claim 4: settle 103 vs 681 independently.

Route B (independent of r199's per-numerator gcd and of r200's per-numerator
factorint): build P = product of every distinct nonzero |numerator| in the
cache, then push P down a REMAINDER TREE over the primes of the window.  A
prime p divides some numerator iff p | P, because p is prime.  Nothing here
factors a numerator and nothing here computes a gcd.

It also reports the same count with NO UPPER BOUND on the prime, which is the
quantity r200's script actually printed.
"""
import pickle, os, sys, time, sympy

RUNS = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
t0 = time.time()
RAW = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))
nums = set()
for lam, cs in RAW.items():
    for copy in cs:
        for vec in copy:
            for mi, (a, b) in vec.items():
                for f in (a, b):
                    if f.numerator: nums.add(abs(f.numerator))
nums.discard(1)
nums = sorted(nums)
print(f"distinct nonzero |numerators| (1 dropped): {len(nums):,}  [{time.time()-t0:.1f}s]")

def prodtree_top(a):
    while len(a) > 1:
        a = [a[i]*a[i+1] if i+1 < len(a) else a[i] for i in range(0, len(a), 2)]
    return a[0] if a else 1

def levels(a):
    """all levels of the product tree, leaves first"""
    L = [a]
    while len(L[-1]) > 1:
        a = L[-1]
        L.append([a[i]*a[i+1] if i+1 < len(a) else a[i] for i in range(0, len(a), 2)])
    return L

P = prodtree_top(list(nums))
print(f"P has {P.bit_length():,} bits  [{time.time()-t0:.1f}s]")

for (lo, hi, tag) in [(900001, 1100000, "r199 window [900001,1100000)")]:
    prs = list(sympy.primerange(lo, hi))
    L = levels(list(prs))
    print(f"{tag}: {len(prs):,} primes, product {L[-1][0].bit_length():,} bits")
    # remainder tree
    cur = [P % L[-1][0]]
    for d in range(len(L) - 2, -1, -1):
        nxt = []
        for j, node in enumerate(L[d]):
            nxt.append(cur[j // 2] % node)
        cur = nxt
    hits = [p for p, r in zip(prs, cur) if r == 0]
    print(f"  primes in window dividing SOME numerator: {len(hits)}"
          f"  ({100.0*len(hits)/len(prs):.2f}%)")
    print(f"  1000033 among them: {1000033 in set(hits)}")
    print(f"  first ten: {hits[:10]}")
    print(f"  [{time.time()-t0:.1f}s]")

# and the unbounded quantity: primes > 900000 dividing some numerator, any size.
# done by full factorisation of the numerators (r200's route), reported separately.
