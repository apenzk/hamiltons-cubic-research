"""r214: independent rank of the sampled matrix A (40x47) and [A|F_5] (40x48),
mod each of the four primes, by my own Gaussian elimination over F_p.

rank_{F_p}(A mod p) <= rank_Q(A) for any A over Z_(p).  So attaining 13 mod p
gives rank_Q(A) >= 13 with no trust in the CRT lift at all.
"""
import json, glob, os, sys

d = "scripts/runs"
def rank_fp(rows, p):
    M = [r[:] for r in rows]; nr = len(M); nc = len(M[0]); r = 0
    for c in range(nc):
        pv = None
        for t in range(r, nr):
            if M[t][c] % p: pv = t; break
        if pv is None: continue
        M[r], M[pv] = M[pv], M[r]
        inv = pow(M[r][c] % p, p-2, p)
        M[r] = [(x*inv) % p for x in M[r]]
        for t in range(nr):
            if t != r and M[t][c] % p:
                f = M[t][c] % p
                M[t] = [(x - f*y) % p for x, y in zip(M[t], M[r])]
        r += 1
        if r == nr: break
    return r

# self-test on planted ranks
import random
random.seed(7)
for p in (1000003,):
    for k in (0, 1, 5, 13, 14, 20):
        U = [[random.randrange(p) for _ in range(47)] for _ in range(k)]
        R = []
        for _ in range(40):
            co = [random.randrange(p) for _ in range(k)]
            R.append([sum(co[a]*U[a][j] for a in range(k)) % p for j in range(47)])
        got = rank_fp(R, p)
        assert got == k, f"self-test failed: planted {k}, got {got}"
print("rank_fp self-test on planted ranks 0,1,5,13,14,20: OK")

for f in sorted(glob.glob(os.path.join(d, "n5_rows_*.json"))):
    D = json.load(open(f))
    p = D["prime"]; A = D["rows"]; B = D["rhs"]
    AUG = [A[i] + [B[i]] for i in range(len(A))]
    print(f"p={p}: rank(A)={rank_fp(A,p)}  rank([A|F5])={rank_fp(AUG,p)}  "
          f"(shape {len(A)}x{len(A[0])})")
