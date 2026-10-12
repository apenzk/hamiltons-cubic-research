"""r209, claims 1-2: an independent audit of the restriction T at W_0.

Written from the definitions, not from run_n5_assemble.py.  Three facts make the
whole thing cheap and mostly EXACT:

  * W_0^3 has support 4 and lies in the single Sym^3 weight class (0,0), so the
    expansion is ONE 234 x 234 solve, and every inner product against W_0^3
    costs four sym3_ip calls.
  * the K-condition on the multiplicity space is d^T w^(t) = 0 for every
    position t, with w^(t)_i = <R_i[t], W_0^3>, which is EXACT and needs no
    expansion, no multiplicity Gram and no convention.
  * the shipped restriction lives in the OTHER coordinates -- the Gram entry
    index -- so the two are compared through e = h conj(d).

Prime 1000003 = 3 mod 4, so F_p[i] is a FIELD (the shipped 1000033 is 1 mod 4);
independent of the shipped prime and of the shipped pair arithmetic.
"""
import importlib.util, sys, os, time, json
from fractions import Fraction as F

D = "scripts/runs"
def load(n):
    sp = importlib.util.spec_from_file_location(n[:-3], os.path.join(D, n))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m); sys.stdout = o
    return m

t0 = time.time()
ad = load("run_n5_adapted.py")
ev = load("run_n5_evaluate.py"); wm = load("run_n5_weyl_module.py")
ex = load("run_n5_extremiser.py")
print(f"[{time.time()-t0:.0f}s] modules loaded", flush=True)
ADAPTED, MONO, WWT = ad.ADAPTED, ad.MONO, ad.WWT
IDXOF = {t: k for k, t in enumerate(MONO)}

P = 1000003
assert P % 4 == 3, "want F_p[i] to be a field"
def gp(x):
    a, b = (x.r, x.i) if hasattr(x, "r") else x
    assert a.denominator % P and b.denominator % P
    return (a.numerator * pow(a.denominator % P, P-2, P) % P,
            b.numerator * pow(b.denominator % P, P-2, P) % P)
def mul(u, v): return ((u[0]*v[0]-u[1]*v[1]) % P, (u[0]*v[1]+u[1]*v[0]) % P)
def add(u, v): return ((u[0]+v[0]) % P, (u[1]+v[1]) % P)
def sub(u, v): return ((u[0]-v[0]) % P, (u[1]-v[1]) % P)
def cj(u):     return (u[0], (-u[1]) % P)
def inv(u):
    n = (u[0]*u[0] + u[1]*u[1]) % P
    assert n, "zero norm in a field means zero element"
    ni = pow(n, P-2, P)
    return (u[0]*ni % P, (-u[1]*ni) % P)
ZP = (0, 0)
assert mul((0,1),(0,1)) == (P-1, 0)

def mwt(idx):
    a, b, c = MONO[idx]
    return (WWT[a][0]+WWT[b][0]+WWT[c][0], WWT[a][1]+WWT[b][1]+WWT[c][1])

# ---------------- W_0^3 ----------------
S = ex.S
W0T = wm.sym2_to_R({(a, b): S[a][b] for a in range(len(S))
                    for b in range(a, len(S)) if S[a][b]})
cub0 = ev.cube(ev.coords(W0T))                    # keyed by monomial TUPLES
cub0i = {IDXOF[k]: v for k, v in cub0.items()}    # keyed by INDEX
W0WT = {mwt(k) for k in cub0i}
print(f"W_0^3: {len(cub0i)} monomials, weights {sorted(W0WT)}", flush=True)
assert W0WT == {(0, 0)}
WZ = (0, 0)

# ---------------- the EXACT value covectors w^(t)_i = <R_i[t], W_0^3> --------
# f(W_0) = 0 is <f, W_0^3> = 0, linear in f.  So the multiplicity vector d gives
# a cubic of K iff sum_i d_i <R_i[t], W_0^3> = 0 for EVERY position t; positions
# of nonzero weight are automatic, so only the weight-(0,0) ones carry content.
def ip_exact(u, v):
    tot = (F(0), F(0))
    for a, ca in u.items():
        ta = MONO[a]
        for b, cb in v.items():
            k = ev.sym3_ip(ta, MONO[b])
            if k != (F(0), F(0)):
                car = (ca.r, ca.i) if hasattr(ca, "r") else ca
                cbr = (cb.r, cb.i) if hasattr(cb, "r") else cb
                tot = ev.cadd(tot, ev.cmul(ev.cmul(car, ev.cconj(cbr)), k))
    return tot

WCOV = {}          # lam -> {t: [w_i exact]}
t1 = time.time()
for lam, copies in ADAPTED.items():
    m = len(copies)
    zt = [t for t in range(len(copies[0])) if copies[0][t] and mwt(max(copies[0][t])) == WZ]
    WCOV[lam] = {t: [ip_exact(copies[i][t], cub0i) for i in range(m)] for t in zt}
print(f"[{time.time()-t1:.0f}s] exact value covectors at {sum(len(v) for v in WCOV.values())} "
      f"zero-weight positions", flush=True)

Z = (F(0), F(0))
def exact_rank(rows):
    """rank over Q(i) of a list of vectors of exact (re, im) pairs."""
    R = [list(r) for r in rows]; r = 0
    n = len(R[0]) if R else 0
    for c in range(n):
        pv = next((t for t in range(r, len(R)) if R[t][c] != Z), None)
        if pv is None: continue
        R[r], R[pv] = R[pv], R[r]
        d = R[r][c]
        dn = d[0]*d[0] + d[1]*d[1]
        di = (d[0]/dn, -d[1]/dn)
        R[r] = [ev.cmul(x, di) for x in R[r]]
        for t in range(len(R)):
            if t != r and R[t][c] != Z:
                f0 = R[t][c]
                R[t] = [(x[0]-f0[0]*y[0]+f0[1]*y[1], x[1]-f0[0]*y[1]-f0[1]*y[0])
                        for x, y in zip(R[t], R[r])]
        r += 1
    return r

print("\n=== A. the orbit condition, block by block, EXACT over Q(i) ===", flush=True)
print("  lam    m  #pos(wt 0)  rank of [<R_i[t],W_0^3>]  expected")
nz_even = nz_odd = 0
KRANK = {}
for lam in sorted(ADAPTED):
    m = len(ADAPTED[lam]); rows = list(WCOV[lam].values())
    rk = exact_rank(rows) if rows else 0
    KRANK[lam] = rk
    exp = 1 if lam[1] % 2 == 0 else 0
    flag = "" if rk == exp else "   <<< MISMATCH"
    print(f"  {lam}  {m}   {len(rows):3d}          {rk}                {exp}{flag}")
    if rk: nz_even += 1
print(f"  blocks with a genuine condition: {nz_even}   (the run asserts 16)")
surv = [m - KRANK[l] for l, m in ((l, len(ADAPTED[l])) for l in ADAPTED)]
surv = [s for s in surv if s > 0]
print(f"  surviving multiplicities {sum(surv)} across {len(surv)} blocks, shape "
      f"{sorted(surv)}")
print(f"  Hermitian unknowns {sum(s*s for s in surv)}, real symmetric "
      f"{sum(s*(s+1)//2 for s in surv)}")

json.dump({"krank": {str(k): v for k, v in KRANK.items()},
           "surv": sorted(surv)}, open("/tmp/r209_A.json", "w"))

# ---------------- B. the expansion vector, and the code's hyperplane --------
# The shipped restriction reads u off the EXPANSION of W_0^3 -- x_{i,t} -- and
# imposes sum_i e_i u_i = 0 on the GRAM-index coordinate e.  The two coordinate
# systems are related by e = h conj(d): for F = (sum_j d_j m_j) (x) v,
#   <W_0^3, F> = sum_i (h conj(d))_i <X_i, v>_Q,
# and the code's rank-one Gram e e^* gives the sextic ||sum_i e_i X_i||^2.  So
# the K-condition d^T w = 0 becomes conj(e)^T h^{-1} w = 0, i.e.
#   e^T conj(h^{-1} w) = 0.
# The claim to test is conj(h^{-1} w) proportional to the expansion vector a.
print("\n=== B. the expansion of W_0^3, mod p, and h ===", flush=True)
_IPC = {}
def ip_ex(u, v):
    tot = (F(0), F(0))
    for a, ca in u.items():
        ta = MONO[a]
        for b, cb in v.items():
            k = _IPC.get((a, b))
            if k is None:
                k = ev.sym3_ip(ta, MONO[b]); _IPC[(a, b)] = k
            if k != Z:
                car = (ca.r, ca.i) if hasattr(ca, "r") else ca
                cbr = (cb.r, cb.i) if hasattr(cb, "r") else cb
                tot = ev.cadd(tot, ev.cmul(ev.cmul(car, ev.cconj(cbr)), k))
    return tot

t1 = time.time()
HEX = {}
for lam, copies in ADAPTED.items():
    m = len(copies)
    HEX[lam] = [[ip_ex(copies[i][0], copies[j][0]) for j in range(m)] for i in range(m)]
print(f"[{time.time()-t1:.0f}s] h measured exactly at position 0", flush=True)
for lam in sorted(HEX):
    m = len(HEX[lam])
    if m == 1: continue
    herm = all(HEX[lam][i][j] == ev.cconj(HEX[lam][j][i]) for i in range(m) for j in range(m))
    cx = sum(1 for i in range(m) for j in range(m) if i != j and HEX[lam][i][j][1])
    print(f"  h[{lam}] Hermitian {herm}, complex off-diagonals {cx}")
    assert herm

# the single 234 x 234 weight-(0,0) solve
ENT = []
for lam, copies in ADAPTED.items():
    for i, c in enumerate(copies):
        for t, v in enumerate(c):
            if v and mwt(max(v)) == WZ: ENT.append((lam, i, t, v))
MONZ = [k for k in range(len(MONO)) if mwt(k) == WZ]
print(f"  weight (0,0): {len(ENT)} adapted vectors, {len(MONZ)} monomials", flush=True)
assert len(ENT) == len(MONZ)
mi = {k: r for r, k in enumerate(MONZ)}
n = len(ENT)
A = [[ZP]*(n+1) for _ in range(n)]
for j, (_, _, _, v) in enumerate(ENT):
    for k, cv in v.items(): A[mi[k]][j] = gp(cv)
for k, cv in cub0i.items(): A[mi[k]][n] = gp(cv)
r = 0; piv = []
for c in range(n):
    pv = next((t for t in range(r, n) if A[t][c] != ZP), None)
    assert pv is not None, f"weight-(0,0) block singular at column {c}"
    A[r], A[pv] = A[pv], A[r]
    iv = inv(A[r][c]); A[r] = [mul(x, iv) for x in A[r]]
    for t in range(n):
        if t != r and A[t][c] != ZP:
            f0 = A[t][c]; A[t] = [sub(x, mul(f0, y)) for x, y in zip(A[t], A[r])]
    piv.append(c); r += 1
xs = [ZP]*n
for t, c in enumerate(piv): xs[c] = A[t][n]
print(f"  solved; {sum(1 for x in xs if x != ZP)} nonzero expansion coefficients", flush=True)
# residual check: A x == b
res = 0
for row in range(n):
    acc = ZP
    for j, (_, _, _, v) in enumerate(ENT):
        cv = v.get(MONZ[row])
        if cv is not None and xs[j] != ZP: acc = add(acc, mul(gp(cv), xs[j]))
    tgt = gp(cub0i[MONZ[row]]) if MONZ[row] in cub0i else ZP
    if acc != tgt: res += 1
print(f"  residual rows wrong: {res}   (must be 0)")
assert res == 0

X = {lam: {} for lam in ADAPTED}          # lam -> {t: [x_i]}
for (lam, i, t, _), val in zip(ENT, xs):
    X[lam].setdefault(t, [ZP]*len(ADAPTED[lam]))[i] = val

print("\n=== C. rank one in (copy, position), and the choice of t ===", flush=True)
AVEC = {}
for lam in sorted(ADAPTED):
    cols = {t: v for t, v in X[lam].items() if any(c != ZP for c in v)}
    m = len(ADAPTED[lam])
    if not cols:
        print(f"  {lam}: W_0^3 has NO component  (lambda_2 odd: {bool(lam[1] % 2)})")
        continue
    ts = sorted(cols)
    a0 = cols[ts[0]]
    k = next(i for i in range(m) if a0[i] != ZP)
    bad = []
    for t in ts:
        v = cols[t]
        s = mul(v[k], inv(a0[k]))
        if any(v[i] != mul(s, a0[i]) for i in range(m)): bad.append(t)
    print(f"  {lam}: m={m}, {len(cols)} nonzero positions of {len(X[lam])}; "
          f"columns not proportional to the FIRST: {len(bad)}")
    assert not bad, f"choice of t CHANGES the vector at {lam}: {bad}"
    AVEC[lam] = a0
print(f"  blocks carrying W_0^3: {len(AVEC)}  (lambda_2 even: "
      f"{sum(1 for l in AVEC if l[1] % 2 == 0)})")

print("\n=== D. does the code's hyperplane equal the K hyperplane? ===", flush=True)
def gpx(x): return gp(x)
def matinv(M):
    m = len(M); Aa = [list(M[i]) + [(1,0) if j == i else ZP for j in range(m)] for i in range(m)]
    for c in range(m):
        pv = next(t for t in range(c, m) if Aa[t][c] != ZP)
        Aa[c], Aa[pv] = Aa[pv], Aa[c]
        iv = inv(Aa[c][c]); Aa[c] = [mul(x, iv) for x in Aa[c]]
        for t in range(m):
            if t != c and Aa[t][c] != ZP:
                f0 = Aa[t][c]; Aa[t] = [sub(x, mul(f0, y)) for x, y in zip(Aa[t], Aa[c])]
    return [row[m:] for row in Aa]
def prop(u, v):
    """is u a nonzero multiple of v?"""
    k = next((i for i in range(len(v)) if v[i] != ZP), None)
    if k is None or u[k] == ZP: return False
    s = mul(u[k], inv(v[k]))
    return all(u[i] == mul(s, v[i]) for i in range(len(v)))
same = diff = 0
for lam in sorted(AVEC):
    m = len(ADAPTED[lam]); a = AVEC[lam]
    wrows = [[gp(c) for c in WCOV[lam][t]] for t in sorted(WCOV[lam])]
    wnz = next((r for r in wrows if any(c != ZP for c in r)), None)
    if wnz is None:
        print(f"  {lam}: value covector is 0 mod p -- skipped"); continue
    hi = matinv([[gp(HEX[lam][i][j]) for j in range(m)] for i in range(m)])
    hw = [ZP]*m
    for i in range(m):
        acc = ZP
        for j in range(m): acc = add(acc, mul(hi[i][j], wnz[j]))
        hw[i] = acc
    v = [cj(z) for z in hw]                      # conj(h^{-1} w)
    ok = prop(v, a)
    naive = prop(wnz, a)
    print(f"  {lam}: conj(h^-1 w) ~ a : {ok} | raw value-vector w ~ a : {naive}")
    assert ok, f"the code's u is NOT the K normal at {lam}"
    same += 1; diff += 0 if naive else 1
print(f"  the code's hyperplane is the K hyperplane on all {same} blocks;")
print(f"  it DIFFERS from the raw <R, W_0^3> hyperplane on {diff} of them.")

print("\n=== E. G(W_0) and Hermiticity ===", flush=True)
QZ = {}
for lam, copies in ADAPTED.items():
    ts = sorted(t for t in range(len(copies[0]))
                if copies[0][t] and mwt(max(copies[0][t])) == WZ)
    QZ[lam] = (ts, [[gp(ip_ex(copies[0][t], copies[0][s])) for s in ts] for t in ts])
nherm = 0
for lam in sorted(ADAPTED):
    ts, Qm = QZ[lam]; m = len(ADAPTED[lam])
    if not all(Qm[i][j] == cj(Qm[j][i]) for i in range(len(ts)) for j in range(len(ts))):
        nherm += 1; print(f"  Q NOT Hermitian at {lam}")
    Gm = [[ZP]*m for _ in range(m)]
    for i in range(m):
        for j in range(m):
            acc = ZP
            for ti, t in enumerate(ts):
                xi = X[lam].get(t, [ZP]*m)[i]
                if xi == ZP: continue
                for si, s in enumerate(ts):
                    xj = X[lam].get(s, [ZP]*m)[j]
                    if xj == ZP: continue
                    acc = add(acc, mul(mul(xi, cj(xj)), Qm[ti][si]))
            Gm[i][j] = acc
    gherm = all(Gm[i][j] == cj(Gm[j][i]) for i in range(m) for j in range(m))
    if lam in AVEC:
        a = AVEC[lam]
        k = next(i for i in range(m) if a[i] != ZP)
        c = mul(Gm[k][k], inv(mul(a[k], cj(a[k]))))
        r1 = all(Gm[i][j] == mul(c, mul(a[i], cj(a[j]))) for i in range(m) for j in range(m))
        print(f"  {lam}: G(W_0) Hermitian {gherm}, = c a a* {r1}, c != 0 {c != ZP}")
        assert r1 and c != ZP and gherm
    else:
        print(f"  {lam}: G(W_0) = 0 : {all(Gm[i][j] == ZP for i in range(m) for j in range(m))}")
        assert all(Gm[i][j] == ZP for i in range(m) for j in range(m))
print(f"  Q non-Hermitian blocks: {nherm}  (must be 0)")
print(f"\n[{time.time()-t0:.0f}s] done", flush=True)
