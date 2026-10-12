"""r258 claim 4, part A -- can the n=5 test fail on any input?

The file under review ranks, for each block lambda of multiplicity m, the
coefficient vectors of the copies at a few positions t of the WORD LIST.  This
script asks what the rank depends on.  Everything is exact over Fraction.
"""
import pickle, random, sys
from fractions import Fraction as F

RAW = pickle.load(open("scripts/runs/n5_adapted.pkl", "rb"))

def coerce(x):
    return F(x[0]) if isinstance(x, tuple) else F(x.r if hasattr(x, 'r') else x)

def rank_cols(rows, m):
    M = [r[:] for r in rows]
    rk = 0
    for c in range(m):
        pr = next((t for t in range(rk, len(M)) if M[t][c] != 0), None)
        if pr is None: continue
        M[rk], M[pr] = M[pr], M[rk]
        iv = M[rk][c]; M[rk] = [x/iv for x in M[rk]]
        for t in range(len(M)):
            if t != rk and M[t][c] != 0:
                f0 = M[t][c]; M[t] = [x - f0*y for x, y in zip(M[t], M[rk])]
        rk += 1
    return rk

def rows_at(copies, positions):
    m = len(copies); rows = []
    for t in positions:
        keys = sorted({k for i in range(m) if copies[i][t] for k in copies[i][t]})
        for k in keys:
            rows.append([coerce(copies[i][t].get(k, 0)) if copies[i][t] else F(0)
                         for i in range(m)])
    return rows, m

MULTI = sorted(((lam, len(c)) for lam, c in RAW.items() if len(c) > 1), key=lambda t: -t[1])
print(f"blocks of multiplicity > 1 at n=5: {len(MULTI)}; widest {MULTI[0]}")

# --- A1.  the rank at EVERY single position, not just the first three -------
print("\nA1  rank of the m columns at each single word position t")
bad = 0
for lam, m in MULTI:
    per = []
    for t in range(len(RAW[lam][0])):
        rows, _ = rows_at(RAW[lam], [t])
        if not rows: per.append("-"); continue
        r = rank_cols(rows, m)
        per.append(str(r)); bad += (r != m)
    print(f"  lambda={str(lam):<8} m={m}  ranks over all {len(per)} positions: "
          f"{'all '+str(m) if set(per) <= {str(m)} else ' '.join(per)}")
print(f"  positions where the read is deficient: {bad}")

# --- A2.  the imaginary parts the coercion discards -------------------------
print("\nA2  does the tuple branch drop anything?")
nz = tot = 0
for lam in RAW:
    for cp in RAW[lam]:
        for vec in cp:
            for v in vec.values():
                tot += 1
                if isinstance(v, tuple) and v[1] != 0: nz += 1
print(f"  stored coefficients: {tot};  with nonzero imaginary part: {nz}")

# --- A3.  the test is invariant under every legitimate re-choice of basis ---
print("\nA3  re-mix the copies of each block by a random invertible matrix")
random.seed(7)
def mix(copies, m):
    A = None
    while True:                        # random invertible m x m over Q
        A = [[F(random.randint(-3, 3)) for _ in range(m)] for _ in range(m)]
        if rank_cols([r[:] for r in A], m) == m: break
    L = len(copies[0])
    out = []
    for i in range(m):
        cp = []
        for t in range(L):
            d = {}
            for j in range(m):
                if not A[i][j]: continue
                for k, v in copies[j][t].items():
                    d[k] = d.get(k, F(0)) + A[i][j]*coerce(v)
            cp.append({k: v for k, v in d.items() if v})
        out.append(cp)
    return out
for lam, m in MULTI[:4]:
    mixed = mix(RAW[lam], m)
    sup = sorted({t for t, v in enumerate(mixed[0]) if v})[:3]
    rows, _ = rows_at(mixed, sup)
    print(f"  lambda={str(lam):<8} m={m}  rank after re-mixing: {rank_cols(rows, m)}")

# --- A4.  what the test does to objects with no equivariance at all ---------
print("\nA4  substitute NON-equivariant junk with the same shape")
random.seed(11)
for lam, m in MULTI[:4]:
    L = len(RAW[lam][0])
    junk = [[{k: F(random.randint(1, 9)) for k in random.sample(range(7770), 5)}
             for _ in range(L)] for _ in range(m)]
    sup = sorted({t for t, v in enumerate(junk[0]) if v})[:3]
    rows, _ = rows_at(junk, sup)
    print(f"  lambda={str(lam):<8} m={m}  rank of random vectors: {rank_cols(rows, m)}")

# --- A5.  the only way to fail -------------------------------------------
print("\nA5  the one input that fails: a duplicated copy")
lam, m = MULTI[0]
dup = [RAW[lam][0]] + [RAW[lam][i] for i in range(1, m)]
dup[1] = RAW[lam][0]
sup = sorted({t for t, v in enumerate(dup[0]) if v})[:3]
rows, _ = rows_at(dup, sup)
print(f"  lambda={lam} with copy 1 replaced by copy 0: rank {rank_cols(rows, m)} of {m}")
