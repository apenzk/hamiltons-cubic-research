"""The shipped h computation on the REAL adapted basis, plus the two things the
shipped code declines to do with it: (a) is h nonsingular / positive definite,
(b) does a second probe (t,s) give the same h, as Schur requires."""
import pickle, os, itertools, json, sys
from fractions import Fraction as Fr
d = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs"))
C = json.load(open(os.path.join(d, "n5_hw_cache.json")))
WT = [tuple(w) for w in C["weights"]]; T = C["wbasis_tensors"]
MONO = list(itertools.combinations_with_replacement(range(35), 3))
def gq(pr):
    (rn, rd), (inn, idd) = pr; return (Fr(rn, rd), Fr(inn, idd))
def cmul(x, y): return (x[0]*y[0]-x[1]*y[1], x[0]*y[1]+x[1]*y[0])
def cadd(x, y): return (x[0]+y[0], x[1]+y[1])
def cconj(x):   return (x[0], -x[1])
H = {}
for a in range(35):
    for b in range(35):
        if WT[a] != WT[b]: continue
        re = im = Fr(0)
        for i in range(5):
            for j in range(5):
                for k in range(5):
                    for l in range(5):
                        x = gq(T[a][i][j][k][l]); y = gq(T[b][i][j][k][l])
                        re += x[0]*y[0]+x[1]*y[1]; im += x[1]*y[0]-x[0]*y[1]
        if (re, im) != (Fr(0), Fr(0)): H[(a, b)] = (re, im)
def sym3_ip(t, s):
    tot = (Fr(0), Fr(0))
    for perm in itertools.permutations(range(3)):
        term = (Fr(1), Fr(0)); ok = True
        for i in range(3):
            e = H.get((t[i], s[perm[i]]))
            if e is None: ok = False; break
            term = cmul(term, e)
        if ok: tot = cadd(tot, term)
    return tot
def ip3(u, v):
    tot = (Fr(0), Fr(0))
    for a, ca in u.items():
        ta = MONO[a]
        for b, cb in v.items():
            k = sym3_ip(ta, MONO[b])
            if k != (Fr(0), Fr(0)): tot = cadd(tot, cmul(cmul(ca, cconj(cb)), k))
    return tot
RAW = pickle.load(open(os.path.join(d, "n5_adapted.pkl"), "rb"))
AD = {lam: [[{k: (Fr(x[0]), Fr(x[1])) for k, x in vec.items()} for vec in cp]
            for cp in cs] for lam, cs in RAW.items()}

def hmat(copies, t, s):
    m = len(copies)
    q = ip3(copies[0][t], copies[0][s])
    if q == (Fr(0), Fr(0)): return None
    den = q[0]*q[0]+q[1]*q[1]
    return [[(lambda g: ((g[0]*q[0]+g[1]*q[1])/den, (g[1]*q[0]-g[0]*q[1])/den))(
              ip3(copies[i][t], copies[j][s])) for j in range(m)] for i in range(m)]

def cdet(M):
    A = [r[:] for r in M]; n = len(A); det = (Fr(1), Fr(0))
    for k in range(n):
        p = next((r for r in range(k, n) if A[r][k] != (Fr(0), Fr(0))), None)
        if p is None: return (Fr(0), Fr(0))
        if p != k: A[k], A[p] = A[p], A[k]; det = cmul(det, (Fr(-1), Fr(0)))
        det = cmul(det, A[k][k]); piv = A[k][k]
        dn = piv[0]*piv[0]+piv[1]*piv[1]; inv = (piv[0]/dn, -piv[1]/dn)
        for r in range(k+1, n):
            f = cmul(A[r][k], inv)
            for c in range(k, n): A[r][c] = cadd(A[r][c], cmul((-f[0], -f[1]), A[k][c]))
    return det

print(f"{'lambda':10s} {'m':>2s} {'|supp R0[0]|':>12s} {'herm':>5s} {'==I':>5s} "
      f"{'minors>0 (PD)':>13s} {'h(1,1)==h(0,0)':>15s}")
for lam in sorted(AD, key=lambda l: -len(AD[l])):
    cps = AD[lam]; m = len(cps)
    if m == 1: continue
    h0 = hmat(cps, 0, 0)
    herm = all(h0[i][j] == cconj(h0[j][i]) for i in range(m) for j in range(m))
    ident = all(h0[i][j] == (Fr(1 if i == j else 0), Fr(0)) for i in range(m) for j in range(m))
    pd = all(cdet([r[:k+1] for r in h0[:k+1]])[0] > 0 for k in range(m))
    h1 = hmat(cps, 1, 1) if len(cps[0]) > 1 else None
    same = "n/a" if h1 is None else str(h1 == h0)
    print(f"{str(lam):10s} {m:2d} {len(cps[0][0]):12d} {str(herm):>5s} {str(ident):>5s} "
          f"{str(pd):>13s} {same:>15s}   det={float(cdet(h0)[0]):.6g}")

# ---------- the copy-clone corruption through the SHIPPED h checks ----------
print("\ncopy-clone control (u_1 := u_0), the failure mode plan.md entry 7 names:")
for lam in sorted(AD, key=lambda l: -len(AD[l])):
    cps = [list(c) for c in AD[lam]]
    if len(cps) < 2: continue
    cps[1] = [dict(v) for v in cps[0]]
    m = len(cps); h0 = hmat(cps, 0, 0)
    herm = all(h0[i][j] == cconj(h0[j][i]) for i in range(m) for j in range(m))
    ident = all(h0[i][j] == (Fr(1 if i == j else 0), Fr(0)) for i in range(m) for j in range(m))
    dt = cdet(h0)
    print(f"  lambda={lam} m={m}: shipped 'Hermitian' {herm}, shipped 'not I' "
          f"{not ident} -> both PASS; det h = {float(dt[0])}  singular: "
          f"{dt == (Fr(0), Fr(0))}")
    break
