"""r262 claim 4(d) -- is a two-prime agreement grounds to read a modular rank as exact?

The reviewed script's justification: "a modular rank can only UNDERSTATE the
rational one, so agreement between two unrelated primes is what licenses reading
it as exact."  The premise is true and the inference does not follow: rank_p <=
rank_Q for EVERY p, so k primes agreeing at v establish rank_Q >= v and nothing
above.  What settles it here is that the Gram is POSITIVE SEMIDEFINITE over the
integers, so rank_Q = rank_R and a spectral computation gives the upper bound the
modular one cannot.

Below: for every (f,n) the reviewed script tests, the modular rank at SIX primes,
the eigenvalue count of the PSD Gram with its spectral gap, and (at f <= 4) the
exact rational rank.
"""
import sys, os
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r262_gram import matchings, loops_uf, rank_exact, rank_mod, restricted_updown

PRIMES = (2147483647, 2147483629, 1000003, 999983, 65537, 46337)

def gram(f, n):
    Ds = list(matchings(tuple(range(2*f))))
    N = len(Ds)
    return [[n ** loops_uf(Ds[i], Ds[j], f) for j in range(N)] for i in range(N)], N

print(f"  {'f':>2} {'n':>2} {'N':>4} {'pred sum m^2':>12} {'ranks mod 6 primes':>20} {'PSD eig>gap':>11} {'gap ratio':>12} {'exact Q':>8}")
for f in (2, 3, 4, 5):
    for n in range(1, 7):
        G, N = gram(f, n)
        pred = sum(c*c for c in restricted_updown(f, n).values())
        mods = sorted({rank_mod([r[:] for r in G], N, q) for q in PRIMES})
        A = np.array(G, dtype=float)
        ev = np.sort(np.abs(np.linalg.eigvalsh(A)))[::-1]
        # locate the largest multiplicative gap in the spectrum
        nz = ev[ev > 0]
        ratios = nz[:-1] / np.maximum(nz[1:], 1e-300)
        k = int(np.argmax(ratios)) + 1 if len(ratios) else len(nz)
        gapr = float(ratios[k-1]) if len(ratios) else float('inf')
        ex = rank_exact([r[:] for r in G], N) if f <= 4 else '-'
        print(f"  {f:>2} {n:>2} {N:>4} {pred:>12} {str(mods):>20} {k:>11} {gapr:>12.3e} {str(ex):>8}")
        sys.stdout.flush()
