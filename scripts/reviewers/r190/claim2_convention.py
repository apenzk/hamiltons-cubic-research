"""Claim 2: is P_i(W) = sum_t u_i[t] om_{t1} om_{t2} om_{t3} the right cubic,
with NO multiplicity factor for repeated indices?

The test that can fail: the trivial block (0,0) carries exactly one highest-weight
vector, so P_1 must be an SO(5)-INVARIANT cubic on Weyl_5.  Feed it W and gW for
exact orthogonal g over F_p and compare.  Then repeat with the multiplicity-
weighted variant sum_t c_t u[t] om^t, c_t in {1,3,6}, which is the reading the
brief asks about.  Exactly one of the two can be invariant.
"""
import os, sys, json, itertools
import numpy as np

d = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(d, "..", "..", "..")
P = 65537
I_ = 256
assert pow(I_, 2, P) == P - 1

C = json.load(open(os.path.join(ROOT, "scripts", "runs", "n5_hw_cache.json")))
MONO = list(itertools.combinations_with_replacement(range(35), 3))

def gq2(pair):
    (rn, rd), (inn, idd) = pair
    return (rn * pow(rd % P, P-2, P) % P, inn * pow(idd % P, P-2, P) % P)

HW2 = {}
for key, v in C["hw"].items():
    lam = tuple(int(x) for x in key.split(","))
    cols = v["cols"]
    HW2[lam] = [{cols[j]: gq2(x) for j, x in enumerate(vec) if gq2(x) != (0, 0)}
                for vec in v["vecs"]]
WB2 = np.array([[[[[gq2(C["wbasis_tensors"][a][i][j][k][l]) for l in range(5)]
                   for k in range(5)] for j in range(5)] for i in range(5)]
                for a in range(35)], dtype=np.int64)          # (35,5,5,5,5,2)

sys.path.insert(0, os.path.join(ROOT, "scripts", "reviewers", "r179"))
import weyl_invariants as WI

def gmul(x, y): return ((x[0]*y[0] - x[1]*y[1]) % P, (x[0]*y[1] + x[1]*y[0]) % P)
def gadd(x, y): return ((x[0]+y[0]) % P, (x[1]+y[1]) % P)

def omegas(W):
    Wm = W.astype(np.int64) % P
    re = np.einsum('aijkl,ijkl->a', WB2[..., 0], Wm) % P
    im = np.einsum('aijkl,ijkl->a', WB2[..., 1], Wm) % P
    return [(int(re[a]), int(im[a])) for a in range(35)]

MULT = [len(set(m)) for m in MONO]                      # 1 -> a=b=c, 2, 3 -> distinct
CT = {1: 1, 2: 3, 3: 6}

def Pval(u, om, weighted=False):
    tot = (0, 0)
    for idx, c in u.items():
        a, b, cc = MONO[idx]
        term = gmul(c, gmul(om[a], gmul(om[b], om[cc])))
        if weighted:
            term = ((term[0]*CT[MULT[idx]]) % P, (term[1]*CT[MULT[idx]]) % P)
        tot = gadd(tot, term)
    return tot

# ---- exact orthogonal matrices over F_p, from rational rotations ----
def rot(n, i, j, c_num, s_num, den):
    inv = pow(den % P, P-2, P)
    c = c_num * inv % P; s = s_num * inv % P
    g = np.eye(n, dtype=np.int64)
    g[i, i] = c; g[j, j] = c; g[i, j] = (-s) % P; g[j, i] = s
    return g % P

def act(g, W):
    T = np.einsum('ai,ijkl->ajkl', g, W) % P
    T = np.einsum('bj,ajkl->abkl', g, T) % P
    T = np.einsum('ck,abkl->abcl', g, T) % P
    T = np.einsum('dl,abcl->abcd', g, T) % P
    return T

def rand_so5(rng):
    trips = [(3, 4, 5), (5, 12, 13), (8, 15, 17), (7, 24, 25), (20, 21, 29)]
    g = np.eye(5, dtype=np.int64)
    for _ in range(6):
        i, j = rng.choice(5, size=2, replace=False)
        a, b, cc = trips[rng.integers(len(trips))]
        g = g @ rot(5, int(i), int(j), a, b, cc) % P
    return g % P

def t3(W):
    M = W.reshape(25, 25).astype(object) % P
    return int(np.trace(M @ M @ M)) % P

def qq(W):
    return int(np.einsum('abcd,abcd->', W.astype(object) % P, W.astype(object) % P)) % P

rng = np.random.default_rng(7)
u0 = HW2[(0, 0)][0]
print(f"trivial block hw vector: {len(u0)} nonzero monomial coefficients")

# sanity that the group action preserves the Weyl conditions
g = rand_so5(rng)
print(f"g orthogonal over F_p: {np.array_equal(g @ g.T % P, np.eye(5, dtype=np.int64))}")

ok_plain = ok_wt = True
ratios_t3 = set()
for s in range(6):
    W = WI.random_weyl(5, P, np.random.default_rng(400+s))
    g = rand_so5(rng)
    Wg = act(g, W)
    assert not np.any(np.einsum('abad->bd', Wg) % P), "gW left the Weyl space"
    for nm, wt in (("plain", False), ("weighted", True)):
        a = Pval(u0, omegas(W), wt)
        b = Pval(u0, omegas(Wg), wt)
        same = (a == b)
        if wt: ok_wt &= same
        else:  ok_plain &= same
        print(f"  sample {s} {nm:9s}: P_1(W)={a}  P_1(gW)={b}  invariant={same}")
    # ratio against the known invariant cubic tr(M^3)
    a = Pval(u0, omegas(W), False)
    T = t3(W)
    if T:
        ratios_t3.add((a[0]*pow(T, P-2, P) % P, a[1]*pow(T, P-2, P) % P))

print(f"\nPLAIN   contraction gives an SO(5)-invariant cubic: {ok_plain}")
print(f"WEIGHTED contraction gives an SO(5)-invariant cubic: {ok_wt}")
print(f"P_1 / tr(M^3) over the samples: {ratios_t3}  (single value <=> P_1 prop to tr(M^3))")
