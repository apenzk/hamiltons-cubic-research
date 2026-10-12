"""Reviewer 189 shared machinery: rebuild run_n5_certificate.py from the cache,
independently, with a group action so equivariance can be tested."""
import os, json, itertools, numpy as np

D = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.join(D, "..", "..", "runs")
P = 65537
I_ = 256
assert pow(I_, 2, P) == P - 1

C = json.load(open(os.path.join(RUNS, "n5_hw_cache.json")))
MONO = list(itertools.combinations_with_replacement(range(35), 3))
MIDX = {m: i for i, m in enumerate(MONO)}
WTS = [tuple(w) for w in C["weights"]]

def gq2(pair):
    (rn, rd), (inn, idd) = pair
    return (rn * pow(rd % P, P-2, P) % P, inn * pow(idd % P, P-2, P) % P)

HW2 = {}
for key, v in C["hw"].items():
    lam = tuple(int(x) for x in key.split(","))
    cols = v["cols"]
    HW2[lam] = [{cols[j]: gq2(x) for j, x in enumerate(vec) if gq2(x) != (0, 0)}
                for vec in v["vecs"]]
BL = sorted(HW2, key=lambda l: (-len(HW2[l]), l))
COV = [(lam, k) for lam in BL for k in range(len(HW2[lam]))]   # 41 covariants
NV = len(COV)

# weight basis as (35,5,5,5,5) real/imag int arrays
_wt = C["wbasis_tensors"]
WBR = np.zeros((35, 5, 5, 5, 5), dtype=np.int64)
WBI = np.zeros((35, 5, 5, 5, 5), dtype=np.int64)
for a in range(35):
    for i in range(5):
        for j in range(5):
            for k in range(5):
                for l in range(5):
                    r, m = gq2(_wt[a][i][j][k][l])
                    WBR[a, i, j, k, l] = r; WBI[a, i, j, k, l] = m

def omegas(W):
    W = np.asarray(W, dtype=np.int64) % P
    re = np.einsum('aijkl,ijkl->a', WBR, W) % P
    im = np.einsum('aijkl,ijkl->a', WBI, W) % P
    return list(zip(re.tolist(), im.tolist()))

def gmul(x, y): return ((x[0]*y[0] - x[1]*y[1]) % P, (x[0]*y[1] + x[1]*y[0]) % P)
def gadd(x, y): return ((x[0]+y[0]) % P, (x[1]+y[1]) % P)
def gconj(x):   return (x[0], (-x[1]) % P)

def Pval(u, om):
    tot = (0, 0)
    for idx, c in u.items():
        a, b, cc = MONO[idx]
        tot = gadd(tot, gmul(c, gmul(om[a], gmul(om[b], om[cc]))))
    return tot

def allP(W):
    om = omegas(W)
    return [Pval(HW2[lam][k], om) for (lam, k) in COV]

def F5(W):
    W = np.asarray(W, dtype=np.int64) % P
    q = int(np.einsum('abcd,abcd->', W, W)) % P
    M = W.reshape(25, 25).astype(object) % P
    t3 = int(np.trace(M @ M @ M)) % P
    return (3*pow(2, P-2, P)*pow(q, 3, P) - 9*pow(t3, 2, P)) % P

def tr3(W):
    W = np.asarray(W, dtype=np.int64) % P
    M = W.reshape(25, 25).astype(object) % P
    return int(np.trace(M @ M @ M)) % P

def qnorm(W):
    W = np.asarray(W, dtype=np.int64) % P
    return int(np.einsum('abcd,abcd->', W, W)) % P

# ---- SO(5) over F_p ----
def inv_modp(M):
    n = M.shape[0]
    A = np.concatenate([M % P, np.eye(n, dtype=np.int64)], axis=1) % P
    r = 0
    for c in range(n):
        piv = next((t for t in range(r, n) if A[t, c] % P), None)
        assert piv is not None, "singular"
        A[[r, piv]] = A[[piv, r]]
        A[r] = A[r] * pow(int(A[r, c]), P-2, P) % P
        for t in range(n):
            if t != r and A[t, c]:
                A[t] = (A[t] - A[t, c]*A[r]) % P
        r += 1
    return A[:, n:] % P

def cayley_so5(rng):
    while True:
        S = rng.integers(0, P, size=(5, 5)).astype(np.int64)
        S = (S - S.T) % P
        try:
            g = (np.eye(5, dtype=np.int64) - S) % P @ inv_modp((np.eye(5, dtype=np.int64) + S) % P) % P
        except AssertionError:
            continue
        g %= P
        if np.all((g.T @ g) % P == np.eye(5, dtype=np.int64)):
            return g

def plane_rot(zeta, a, b):
    """rotation in the (a,b) plane by 'angle' zeta: c=(z+z^-1)/2, s=-i(z-z^-1)/2."""
    zi = pow(zeta, P-2, P)
    half = pow(2, P-2, P)
    c = (zeta + zi) * half % P
    s = (-I_ * (zeta - zi) * half) % P
    assert (c*c + s*s) % P == 1
    g = np.eye(5, dtype=np.int64)
    g[a, a] = c; g[b, b] = c; g[a, b] = -s % P; g[b, a] = s
    return g % P

def act(g, W):
    W = np.asarray(W, dtype=np.int64) % P
    out = np.einsum('ia,abcd->ibcd', g, W) % P
    out = np.einsum('jb,ibcd->ijcd', g, out) % P
    out = np.einsum('kc,ijcd->ijkd', g, out) % P
    out = np.einsum('ld,ijkd->ijkl', g, out) % P
    return out
