"""Reviewer 202, claim 3: the two blind spots reviewer 199 named.

Plant A -- a permutation of the WORD LIST applied to EVERY copy of a block.
Plant B -- COINCIDENT copies: every copy of a block replaced by copy 0.
Plant C -- control: a same-weight transposition inside ONE copy, which 195/197
           report the multi-probe check catches.  If C does not fire the
           harness is wrong and A and B mean nothing.

For each: the three shipped checks (dis/skipped, square, inhom), the digest,
and two checks that are NOT in the file -- det h mod p (199's recommendation 3,
whose det_p the working tree deleted) and the rank of the per-weight solve
matrix (199's recommendation 8).
"""
import sys, os, copy, random, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import harness as H

t0 = time.time()
LAMS = [(2, 0), (2, 2)]        # m=2 dim 14 and m=4 dim 35 -- the two cheapest
BASE = H.ADAPTED

def report(tag, A):
    print(f"\n--- {tag} ---", flush=True)
    tot, sq, BYW, MONS = H.square_check(A)
    inh = H.inhom_check(A)
    print(f"  vectors {tot} (7770: {tot==7770}) | square {sq} | inhom {inh} "
          f"| digest {H.digest(A)}", flush=True)
    for lam in LAMS:
        HM = H.measure_h(A, lam)
        herm = H.hermitian(HM)
        d, sk = H.dis_probe(A, lam, HM)
        det = H.det_gp(HM)
        m = len(A[lam])
        # a weight the block contributes to, for the independence test
        w = H.mwt(max(A[lam][0][1]))
        r, n = H.rank_at_weight(A, w, BYW, MONS)
        print(f"  lambda={lam} m={m}: Hermitian {herm} | dis {d} | skipped {sk} "
              f"| det h {det} ({'ZERO' if det==(0,0) else 'nonzero'}) "
              f"| rank at w={w}: {r}/{n} ({'FULL' if r==n else 'DEFICIENT'})"
              f"  [{time.time()-t0:.0f}s]", flush=True)

report("BASELINE (the shipped cache)", BASE)

# ---- Plant A: one permutation of the word list, applied to EVERY copy ----
rnd = random.Random(202)
A1 = {k: [list(c) for c in cs] for k, cs in BASE.items()}
for lam in LAMS:
    n = len(BASE[lam][0])
    sigma = list(range(n)); rnd.shuffle(sigma)
    assert sigma != list(range(n))
    A1[lam] = [[c[sigma[t]] for t in range(n)] for c in BASE[lam]]
    print(f"plant A on {lam}: sigma[:8] = {sigma[:8]}  (position 0 now carries "
          f"word {sigma[0]}, so R_i[0] is no longer u_i)")
report("PLANT A -- global word-list permutation", A1)

# ---- Plant B: coincident copies ----
A2 = {k: [list(c) for c in cs] for k, cs in BASE.items()}
for lam in LAMS:
    m = len(BASE[lam])
    A2[lam] = [copy.deepcopy(BASE[lam][0]) for _ in range(m)]   # deep, not aliased
    print(f"plant B on {lam}: all {m} copies replaced by an independent deep "
          f"copy of copy 0 (no aliasing -- 198's mistake)")
report("PLANT B -- coincident copies", A2)

# ---- Plant C (control): same-weight transposition inside ONE copy ----
A3 = {k: [list(c) for c in cs] for k, cs in BASE.items()}
fired = {}
for lam in LAMS:
    c1 = list(BASE[lam][1])
    byw = {}
    for t, v in enumerate(c1):
        if v: byw.setdefault(H.mwt(max(v)), []).append(t)
    pair = next(((ts[0], ts[1]) for ts in byw.values() if len(ts) > 1), None)
    print(f"plant C on {lam}: same-weight transposition of positions {pair} "
          f"inside copy 1 only")
    a, b = pair
    c1[a], c1[b] = c1[b], c1[a]
    A3[lam] = [BASE[lam][0]] + [c1] + [list(c) for c in BASE[lam][2:]]
report("PLANT C -- control, per-copy transposition", A3)
