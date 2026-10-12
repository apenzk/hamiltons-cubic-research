"""Claim 1, scope test: the record's negative result restricts G to be BLOCK-DIAGONAL
(89 real unknowns).  Nothing in the pointwise demand forces that -- Schur's lemma
applies to an INVARIANT form, and the pointwise route deliberately drops invariance.
So the honest question is whether the FULL Hermitian G on all 41 P_i (41^2 = 1681
real unknowns) can hit F_5 pointwise.  Also re-runs the block-diagonal system at a
different prime with more points, as an independent replication.
"""
import os, sys, json, itertools, time
import numpy as np

d = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(d, "..", "..", "..")
P = 1000003                       # 3 mod 4 -> no i in F_p; use F_p[i] as a field
assert P % 4 == 3
# arithmetic in F_p[i] = F_{p^2}: (re,im) pairs, i^2 = -1.  A different prime AND a
# different flavour of Gaussian arithmetic from the record's p = 1 mod 4 run.

C = json.load(open(os.path.join(ROOT, "scripts", "runs", "n5_hw_cache.json")))
MONO = list(itertools.combinations_with_replacement(range(35), 3))

def gq2(pair):
    (rn, rd), (inn, idd) = pair
    return (rn * pow(rd % P, P-2, P) % P, inn * pow(idd % P, P-2, P) % P)

HW2, ORDER = {}, []
for key, v in C["hw"].items():
    lam = tuple(int(x) for x in key.split(","))
    cols = v["cols"]
    HW2[lam] = [{cols[j]: gq2(x) for j, x in enumerate(vec) if gq2(x) != (0, 0)}
                for vec in v["vecs"]]
BL = sorted(HW2, key=lambda l: (-len(HW2[l]), l))
FLAT = [(lam, k) for lam in BL for k in range(len(HW2[lam]))]
NB = len(FLAT)
print(f"blocks {len(BL)}, hw vectors {NB}, sum m^2 = {sum(len(HW2[l])**2 for l in BL)}")

WB2 = np.array([[[[[gq2(C["wbasis_tensors"][a][i][j][k][l]) for l in range(5)]
                   for k in range(5)] for j in range(5)] for i in range(5)]
                for a in range(35)], dtype=np.int64)

sys.path.insert(0, os.path.join(ROOT, "scripts", "reviewers", "r179"))
import weyl_invariants as WI

def gmul(x, y): return ((x[0]*y[0] - x[1]*y[1]) % P, (x[0]*y[1] + x[1]*y[0]) % P)
def gadd(x, y): return ((x[0]+y[0]) % P, (x[1]+y[1]) % P)

def omegas(W):
    Wm = W.astype(np.int64) % P
    re = np.einsum('aijkl,ijkl->a', WB2[..., 0] % P, Wm) % P
    im = np.einsum('aijkl,ijkl->a', WB2[..., 1] % P, Wm) % P
    return list(zip(re.tolist(), im.tolist()))

PRE = [[(idx, MONO[idx], c) for idx, c in u.items()]
       for lam in BL for u in HW2[lam]]

def allP(om):
    out = []
    for terms in PRE:
        tr = ti = 0
        for idx, (a, b, cc), c in terms:
            x = gmul(om[a], gmul(om[b], om[cc]))
            y = gmul(c, x)
            tr += y[0]; ti += y[1]
        out.append((tr % P, ti % P))
    return out

def F5(W):
    Wo = W.astype(object) % P
    q = int(np.einsum('abcd,abcd->', Wo, Wo)) % P
    M = W.reshape(25, 25).astype(object) % P
    t3 = int(np.trace(M @ M @ M)) % P
    return (3*pow(2, P-2, P)*pow(q, 3, P) - 9*pow(t3, 2, P)) % P

def build(npts, seed0, pairs):
    """pairs: list of (i,j) with i<=j indexing FLAT.  Returns rows, rhs."""
    rows, rhs = [], []
    t0 = time.time()
    for s in range(npts):
        W = WI.random_weyl(5, P, np.random.default_rng(seed0+s))
        pv = allP(omegas(W))
        row = []
        for (i, j) in pairs:
            z = gmul(pv[i], (pv[j][0], (-pv[j][1]) % P))
            if i == j: row.append(z[0] % P)
            else:      row.append((2*z[0]) % P); row.append((-2*z[1]) % P)
        rows.append(row); rhs.append(F5(W))
        if (s+1) % 250 == 0:
            print(f"    {s+1}/{npts} pts  {time.time()-t0:.0f}s", flush=True)
    return rows, rhs

def rank_np(rows, rhs=None):
    M = np.array(rows, dtype=np.int64) % P
    if rhs is not None:
        M = np.hstack([M, (np.array(rhs, dtype=np.int64) % P)[:, None]])
    m, n = M.shape; r = 0
    for c in range(n):
        nz = np.nonzero(M[r:, c])[0]
        if not len(nz): continue
        p0 = r + int(nz[0])
        if p0 != r: M[[r, p0]] = M[[p0, r]]
        M[r] = M[r] * pow(int(M[r, c]), P-2, P) % P
        col = M[r+1:, c].copy()
        nz2 = np.nonzero(col)[0]
        if len(nz2):
            M[r+1:][nz2] = (M[r+1:][nz2] - np.outer(col[nz2], M[r])) % P
        r += 1
        if r == m: break
    return r

MODE = sys.argv[1] if len(sys.argv) > 1 else "block"
if MODE == "block":
    pairs = []
    off = 0
    for lam in BL:
        m = len(HW2[lam])
        for i in range(m):
            for j in range(i, m): pairs.append((off+i, off+j))
        off += m
    NUNK = sum(len(HW2[l])**2 for l in BL)
    npts = NUNK + 30
else:
    pairs = [(i, j) for i in range(NB) for j in range(i, NB)]
    NUNK = NB*NB
    npts = NUNK + 40
print(f"mode {MODE}: {NUNK} real unknowns, {npts} sample points")
rows, rhs = build(npts, 9000, pairs)
print(f"  matrix {len(rows)} x {len(rows[0])}")
rA = rank_np(rows)
rB = rank_np(rows, rhs)
print(f"  coefficient rank {rA} / {NUNK}")
print(f"  augmented   rank {rB}")
print(f"  CONSISTENT: {rA == rB}")
