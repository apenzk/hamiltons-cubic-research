"""r257 claim 2: is position 0 of a copy the highest-weight vector, and is
position 0 a COORDINATE or a whole vector?  Uses the hw cache, no rebuild."""
import json, pickle
from fractions import Fraction as F
from itertools import combinations_with_replacement

HWC = json.load(open("scripts/runs/n5_hw_cache.json"))
def g(x): return (F(x[0][0], x[0][1]), F(x[1][0], x[1][1]))
WWT = [tuple(w) for w in HWC["weights"]]
MONO = list(combinations_with_replacement(range(35), 3))
MW = [tuple(WWT[a][k]+WWT[b][k]+WWT[c][k] for k in (0, 1)) for a, b, c in MONO]

RAW = pickle.load(open("scripts/runs/n5_adapted.pkl", "rb"))
MULTI = sorted(((l, len(c)) for l, c in RAW.items() if len(c) > 1), key=lambda t: -t[1])

print("A. does copies[i][0] equal the hw vector ns[i] from the hw cache?")
for lam, m in MULTI[:4]:
    rec = HWC["hw"][f"{lam[0]},{lam[1]}"]
    cols, vecs = rec["cols"], [[g(x) for x in v] for v in rec["vecs"]]
    ok = True
    for i in range(m):
        u = {cols[j]: vecs[i][j] for j in range(len(cols)) if vecs[i][j] != (F(0), F(0))}
        if u != RAW[lam][i][0]:
            ok = False
    print(f"   lambda={lam}: position 0 == hw vector for every copy: {ok}")

print("\nB. weights carried by positions 0,1,2 of copy 0 (lambda should appear at 0):")
for lam, m in MULTI[:4]:
    for t in range(3):
        ws = {MW[k] for k in RAW[lam][0][t]}
        print(f"   lambda={lam} position {t}: weights {sorted(ws)}")

print("\nC. how many SCALARS does the test read at 'position 0'?")
for lam, m in MULTI[:3]:
    keys = sorted({k for i in range(m) for k in RAW[lam][i][0]})
    print(f"   lambda={lam}: position 0 contributes {len(keys)} monomial rows "
          f"(the test treats each as a separate read)")

print("\nD. free-variable structure: which columns of the nullspace basis are unit?")
for lam, m in MULTI:
    rec = HWC["hw"][f"{lam[0]},{lam[1]}"]
    cols, vecs = rec["cols"], [[g(x) for x in v] for v in rec["vecs"]]
    free = [j for j in range(len(cols))
            if all(vecs[i][j] == ((F(1), F(0)) if i == r else (F(0), F(0)))
                   for r, i in enumerate(range(m)) for _ in [0])]
    # a column j is 'free' if the m-vector (vecs[i][j]) is a standard basis vector
    free = []
    for j in range(len(cols)):
        col = tuple(vecs[i][j] for i in range(m))
        for r in range(m):
            want = tuple((F(1), F(0)) if i == r else (F(0), F(0)) for i in range(m))
            if col == want: free.append((j, cols[j], r))
    print(f"   lambda={lam} m={m}: {len(free)} unit columns "
          f"{'(>= m: identity submatrix, rank m forced)' if len(free) >= m else '(!!)'}")
