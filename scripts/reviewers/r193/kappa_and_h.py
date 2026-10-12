"""Reviewer 193.  What the kappa identity can and cannot see, and the checks on
H that run_n5_evaluate.py never makes.

Everything below reuses run_n5_evaluate.py's OWN definitions of H, sym3_ip and
cube, copied verbatim except for a sparse representation of the cached tensors
and a weight-grouped summation (sym3_ip vanishes off the weight diagonal, which
is what makes the full-support sum affordable at all).

Claim under test: "breaking any ONE of the three destroys its constancy"
(run_n5_evaluate.py, lines 213-214).
"""
import json, os, itertools, random, sys, time
from fractions import Fraction as F
from math import factorial

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
sys.path.insert(0, d)
C = json.load(open(os.path.join(d, "n5_hw_cache.json")))
WT = [tuple(w) for w in C["weights"]]
MONO = list(itertools.combinations_with_replacement(range(35), 3))
T = C["wbasis_tensors"]

def cmul(x, y): return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] + x[1]*y[0])
def cadd(x, y): return (x[0] + y[0], x[1] + y[1])
def cconj(x):   return (x[0], -x[1])
ZC = (F(0), F(0))

# ---- sparse view of the 35 cached weight-basis tensors ------------------
t0 = time.time()
SP = []
for a in range(35):
    ent = {}
    Ta = T[a]
    for i in range(5):
        for j in range(5):
            for k in range(5):
                for l in range(5):
                    (rn, rd), (inn, idd) = Ta[i][j][k][l]
                    if rn or inn:
                        ent[(i, j, k, l)] = (F(rn, rd), F(inn, idd))
    SP.append(ent)
print(f"sparse tensors: {[len(e) for e in SP][:6]} ... of 625 each  [{time.time()-t0:.0f}s]", flush=True)

# ---- H, all 1225 pairs, and the cross-weight check (claim 3) ------------
H = {}; cross = 0; crosswit = []
for a in range(35):
    Ea = SP[a]
    for b in range(35):
        Eb = SP[b]
        A, B = (Ea, Eb) if len(Ea) <= len(Eb) else (Eb, Ea)
        re = im = F(0)
        for key, x in Ea.items():
            y = Eb.get(key)
            if y is None: continue
            re += x[0]*y[0] + x[1]*y[1]
            im += x[1]*y[0] - x[0]*y[1]
        if (re, im) == ZC: continue
        if WT[a] == WT[b]: H[(a, b)] = (re, im)
        else: cross += 1; crosswit.append((a, b))
npairs = sum(1 for a in range(35) for b in range(35) if WT[a] != WT[b])
print(f"H: {len(H)} within-weight nonzeros, {cross} of {npairs} cross-weight pairs nonzero (must be 0)"
      f"  [{time.time()-t0:.0f}s]", flush=True)

# checks the pipeline never makes
herm = all(H.get((b, a), ZC) == cconj(v) for (a, b), v in H.items())
print(f"H Hermitian: {herm}")
byw = {}
for a in range(35): byw.setdefault(WT[a], []).append(a)
posdef = True
for mu, idxs in byw.items():                       # leading minors, per block
    n = len(idxs)
    M = [[H.get((idxs[r], idxs[c]), ZC) for c in range(n)] for r in range(n)]
    # Hermitian Cholesky-free: check every leading principal minor > 0
    for k in range(1, n+1):
        sub = [row[:k] for row in M[:k]]
        # exact complex determinant by expansion (k <= 3)
        def det(m):
            if len(m) == 1: return m[0][0]
            tot = ZC
            for c in range(len(m)):
                mn = [r[:c]+r[c+1:] for r in m[1:]]
                term = cmul(m[0][c], det(mn))
                tot = cadd(tot, term if c % 2 == 0 else (-term[0], -term[1]))
            return tot
        dv = det(sub)
        if dv[1] != 0 or dv[0] <= 0: posdef = False
print(f"H positive definite on every weight block: {posdef}")

# ---- the file's own sym3_ip and cube ------------------------------------
def multinom(t):
    m = {}
    for x in t: m[x] = m.get(x, 0) + 1
    r = factorial(3)
    for v in m.values(): r //= factorial(v)
    return r

def make_ip(Hd, mode="FISCHER"):
    def ip(t, s):
        tot = ZC
        perms = itertools.permutations(range(3)) if mode != "NOPERM" else [(0, 1, 2)]
        for perm in perms:
            term = (F(1), F(0)); ok = True
            for i in range(3):
                e = Hd.get((t[i], s[perm[i]]))
                if e is None: ok = False; break
                term = cmul(term, e)
            if ok: tot = cadd(tot, term)
        if mode == "M2UP":                      # 36 * MULT_UP  ==  m_t m_s * sum
            f = F(multinom(t)*multinom(s))
            return (tot[0]*f, tot[1]*f)
        return tot
    return ip

def make_cube(mult=True):
    def cube(w):
        out = {}
        for t in MONO:
            z = (F(multinom(t)) if mult else F(1), F(0))
            for a in t: z = cmul(z, w[a])
            if z != ZC: out[t] = z
        return out
    return cube

MWT = {t: (WT[t[0]][0]+WT[t[1]][0]+WT[t[2]][0], WT[t[0]][1]+WT[t[1]][1]+WT[t[2]][1])
       for t in MONO}
GRP = {}
for t in MONO: GRP.setdefault(MWT[t], []).append(t)
print(f"Sym^3 weight classes: {len(GRP)}, largest {max(len(v) for v in GRP.values())}, "
      f"sum of squares {sum(len(v)**2 for v in GRP.values()):,}", flush=True)

def kappa(w, Hd, ip, cube):
    c3 = cube(w)
    tot = ZC
    for mu, ts in GRP.items():
        present = [t for t in ts if t in c3]
        for t in present:
            ct = c3[t]
            for s in present:
                v = ip(t, s)
                if v != ZC: tot = cadd(tot, cmul(cmul(ct, cconj(c3[s])), v))
    n2 = ZC
    for (a, b), v in Hd.items():
        n2 = cadd(n2, cmul(cmul(w[a], cconj(w[b])), v))
    return tot, n2, (tot[0]/n2[0]**3 if n2[0] else None), (tot[1], n2[1])

IP = make_ip(H); CUBE = make_cube(True)

# ---- a genuine Weyl tensor, its coordinates, and the ROUND TRIP ---------
import importlib.util
sp = importlib.util.spec_from_file_location("wm", os.path.join(d, "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(sp)
_o = sys.stdout; sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(wm); sys.stdout = _o
random.seed(4)
def rand_weyl():
    v = [F(random.randint(-3, 3)) for _ in range(35)]
    full = [sum(v[j]*wm.BASIS[j][c] for j in range(35) if v[j]) for c in range(len(wm.SPAIRS))]
    return wm.sym2_to_R({wm.SPAIRS[c]: full[c] for c in range(len(full)) if full[c]})

def coords(Wt):
    rhs = {}
    for b in range(35):
        re = im = F(0)
        for (i, j, k, l), y in SP[b].items():
            x = Wt[i][j][k][l]
            if x: re += x*y[0]; im += -x*y[1]
        rhs[b] = (re, im)
    w = {}
    for mu, idxs in byw.items():
        n = len(idxs)
        A = [[H.get((a, b), ZC) for a in idxs] for b in idxs]
        M = [A[r][:] + [rhs[idxs[r]]] for r in range(n)]
        for c in range(n):
            p = next(r for r in range(c, n) if M[r][c] != ZC)
            M[c], M[p] = M[p], M[c]
            dr, di = M[c][c]; den = dr*dr + di*di
            invd = (dr/den, -di/den)
            M[c] = [cmul(invd, z) for z in M[c]]
            for r in range(n):
                if r != c and M[r][c] != ZC:
                    f = M[r][c]
                    M[r] = [(z[0]-f[0]*y[0]+f[1]*y[1], z[1]-f[0]*y[1]-f[1]*y[0])
                            for z, y in zip(M[r], M[c])]
        for r, a in enumerate(idxs): w[a] = M[r][n]
    return w

Wt = rand_weyl(); w = coords(Wt)
bad = 0
for i in range(5):
    for j in range(5):
        for k in range(5):
            for l in range(5):
                re = im = F(0)
                for a in range(35):
                    e = SP[a].get((i, j, k, l))
                    if e is None: continue
                    re += w[a][0]*e[0] - w[a][1]*e[1]
                    im += w[a][0]*e[1] + w[a][1]*e[0]
                if re != Wt[i][j][k][l] or im != 0: bad += 1
print(f"\nROUND TRIP  W == sum_a w_a f_a : {bad} bad entries of 625 (must be 0)"
      f"  -- the check kappa is claimed to provide and does not"
      f"  [{time.time()-t0:.0f}s]", flush=True)

print("\n=== kappa, as committed ===", flush=True)
tot, n2, k1, imgs = kappa(w, H, IP, CUBE)
print(f"  |W|^2 = {n2[0]}   kappa = {k1}   imag parts {imgs}  [{time.time()-t0:.0f}s]", flush=True)

print("\n=== is kappa blind?  each line breaks ONE input and keeps the rest ===", flush=True)
# (a) w that is not the coordinate vector of anything
random.seed(11)
w2 = {a: (F(random.randint(-4, 4)), F(random.randint(-4, 4))) for a in range(35)}
print(f"  w replaced by a random complex vector : kappa = {kappa(w2, H, IP, CUBE)[2]}", flush=True)
# (b) H with a within-weight off-diagonal perturbed (still Hermitian)
offd = [(a, b) for (a, b) in H if a != b]
Hp = dict(H)
a, b = offd[0]
Hp[(a, b)] = cadd(H[(a, b)], (F(7, 3), F(5, 2)))
Hp[(b, a)] = cconj(Hp[(a, b)])
print(f"  H off-diagonal {offd[0]} perturbed     : kappa = "
      f"{kappa(w, Hp, make_ip(Hp), CUBE)[2]}   ({len(offd)} such entries exist)", flush=True)
# (c) H replaced outright by a random Hermitian block matrix
random.seed(5)
Hr = {}
for mu, idxs in byw.items():
    for i, x in enumerate(idxs):
        for j, y in enumerate(idxs):
            if i <= j:
                v = (F(random.randint(-5, 5)), F(0) if i == j else F(random.randint(-5, 5)))
                Hr[(x, y)] = v; Hr[(y, x)] = cconj(v)
print(f"  H replaced by a random Hermitian one : kappa = {kappa(w, Hr, make_ip(Hr), CUBE)[2]}", flush=True)

print("\n=== the compensating pair ===", flush=True)
print(f"  cube WITHOUT the multinomial, ip unchanged : "
      f"kappa = {kappa(w, H, IP, make_cube(False))[2]}", flush=True)
print(f"  cube unchanged, ip = m_t m_s * (36*MULT_UP): "
      f"kappa = {kappa(w, H, make_ip(H, 'M2UP'), CUBE)[2]}", flush=True)
print(f"  BOTH broken together                       : "
      f"kappa = {kappa(w, H, make_ip(H, 'M2UP'), make_cube(False))[2]}", flush=True)

print("\n=== what does break it ===", flush=True)
print(f"  permutation sum dropped : kappa = {kappa(w, H, make_ip(H, 'NOPERM'), CUBE)[2]}", flush=True)
w3 = {a: cmul(w[a], (F(2), F(0))) for a in range(35)}
print(f"  w scaled by 2 (control) : kappa = {kappa(w3, H, IP, CUBE)[2]}", flush=True)
print(f"\n[{time.time()-t0:.0f}s]")
