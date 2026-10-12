"""r201: the mod-p pair h against the exact Q(i) h, entry by entry."""
import pickle
from fractions import Fraction as F
S = "/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad/"
P = 1000033
ex = {k: [[(F(a), F(b)) for (a, b) in r] for r in v]
      for k, v in pickle.load(open(S+"r201_h_exact.pkl","rb")).items()}
mp = pickle.load(open(S+"r201_hmat_p.pkl","rb"))
def red(x):
    n, d = x.numerator, x.denominator
    return n * pow(d % P, P-2, P) % P
bad = tot = 0
for k in sorted(ex):
    m = len(ex[k])
    for i in range(m):
        for j in range(m):
            e = (red(ex[k][i][j][0]), red(ex[k][i][j][1]))
            g = tuple(mp[k][i][j])
            tot += 1
            if e != g:
                bad += 1; print(f"  MISMATCH {k} [{i}][{j}] exact->p {e}  code {g}")
print(f"entries compared {tot}, mismatches {bad}")
# 192's measured value on (2,0)
want = [[(F(1),F(0)), (F(0),F(55,37))], [(F(0),F(-55,37)), (F(5075,1628),F(0))]]
print("(2,0) equals 192's [[1,55i/37],[-55i/37,5075/1628]] EXACTLY:",
      ex[(2,0)] == want)
for k in sorted(mp):
    if len(mp[k]) == 1: continue
    m = len(mp[k])
    print(f"  {k}: complex off-diagonals  code(mod p) "
          f"{sum(1 for i in range(m) for j in range(m) if i!=j and mp[k][i][j][1])}"
          f"   exact "
          f"{sum(1 for i in range(m) for j in range(m) if i!=j and ex[k][i][j][1])}")
