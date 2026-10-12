"""r257 claim 3: the coercion in rank_of_block reads real parts only."""
import pickle
from fractions import Fraction as F

def coerce(x):   # verbatim from run_hw_multiplicity_test.py line 65
    return F(x.r if hasattr(x, 'r') else x) if not isinstance(x, tuple) else F(x[0])

RAW = pickle.load(open("scripts/runs/n5_adapted.pkl", "rb"))
MULTI = sorted(((l, len(c)) for l, c in RAW.items() if len(c) > 1), key=lambda t: -t[1])

print("how much of what the test READS is imaginary (positions 0,1,2 of each block)?")
tot = im = 0
for lam, m in MULTI:
    t0 = t1 = 0
    for t in range(3):
        for i in range(m):
            for k, v in RAW[lam][i][t].items():
                t0 += 1; t1 += 1 if v[1] != 0 else 0
    tot += t0; im += t1
    print(f"   lambda={lam}: {t1}/{t0} read coefficients have a nonzero imaginary part")
print(f"   TOTAL: {im}/{tot} = {100*im/tot:.1f}% of the numbers the test reads are complex,")
print("   and coerce() throws every imaginary part away.")

print("\nreal-part rank vs true Q(i) rank -- both error directions exist:")
def rank(M, m):
    M = [row[:] for row in M]; r = 0
    for c in range(m):
        p = next((t for t in range(r, len(M)) if M[t][c] != 0), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        iv = M[r][c]; M[r] = [x/iv for x in M[r]]
        for t in range(len(M)):
            if t != r and M[t][c] != 0:
                f0 = M[t][c]; M[t] = [x - f0*y for x, y in zip(M[t], M[r])]
        r += 1
    return r
J = complex(0, 1)
A = [[1+0j, 0+1j], [0+1j, -1+0j]]        # column 2 = i * column 1
B = [[1+0j, 1+0j], [0+1j, 0+2j]]         # independent over Q(i)
for name, M in (("A (truly DEPENDENT)", A), ("B (truly INDEPENDENT)", B)):
    true = rank([[complex(x) for x in r] for r in M], 2)
    real = rank([[F(int(x.real)) for x in r] for r in M], 2)
    print(f"   {name}: true rank {true}, real-part rank {real}  "
          f"-> {'FALSE PASS' if real > true else 'FALSE DEFICIENT' if real < true else 'agrees'}")
