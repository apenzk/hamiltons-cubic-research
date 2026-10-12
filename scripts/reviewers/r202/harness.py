"""Reviewer 202: a standalone replica of run_n5_assemble.py's h-machinery, so
plants can be run without touching the file under review.

Everything between `gp` and the `dis` loop is copied verbatim from
scripts/runs/run_n5_assemble.py at the commit under review.
"""
import importlib.util, sys, os, time
from fractions import Fraction as Fr

D = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                 "..", "..", "runs"))
def load(name, quiet=True):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(D, name))
    m = importlib.util.module_from_spec(sp)
    if quiet:
        o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m)
    if quiet: sys.stdout = o
    return m

ad = load("run_n5_adapted.py")
ev = load("run_n5_evaluate.py")
ADAPTED, MONO, WWT = ad.ADAPTED, ad.MONO, ad.WWT
G = ad.G
sym3_ip = ev.sym3_ip

def mwt(idx):
    a, b, c = MONO[idx]
    return (WWT[a][0]+WWT[b][0]+WWT[c][0], WWT[a][1]+WWT[b][1]+WWT[c][1])

PRIME = 1000033
IMOD = next(x for x in range(2, PRIME) if pow(x, 2, PRIME) == PRIME - 1)

def gp(x):
    if hasattr(x, "r"): a, b = x.r, x.i
    else: (a, b) = x
    return (a.numerator * pow(a.denominator % PRIME, PRIME-2, PRIME) % PRIME,
            b.numerator * pow(b.denominator % PRIME, PRIME-2, PRIME) % PRIME)
def gpmul(u, v):
    return ((u[0]*v[0] - u[1]*v[1]) % PRIME, (u[0]*v[1] + u[1]*v[0]) % PRIME)
def gpadd(u, v): return ((u[0]+v[0]) % PRIME, (u[1]+v[1]) % PRIME)
def gpconj(u):   return (u[0], (-u[1]) % PRIME)

_IPCAP = 2_000_000
_IPC2 = {}
def sym3_ip_g(t, s):
    k = (t, s)
    v = _IPC2.get(k)
    if v is None:
        v = gp(sym3_ip(t, s))
        if len(_IPC2) < _IPCAP: _IPC2[k] = v
    return v

def ip3_g(u, v):
    tot = (0, 0)
    for a, ca in u.items():
        ta = MONO[a]; cap = gp(ca)
        if cap == (0, 0): continue
        for b, cb in v.items():
            k = sym3_ip_g(ta, MONO[b])
            if k != (0, 0):
                tot = gpadd(tot, gpmul(gpmul(cap, gpconj(gp(cb))), k))
    return tot

def to_p(x):
    if hasattr(x, "r"): a, b = x.r, x.i
    else: (a, b) = x
    return (a.numerator * pow(a.denominator % PRIME, PRIME-2, PRIME)
            + b.numerator * pow(b.denominator % PRIME, PRIME-2, PRIME) * IMOD) % PRIME

# ---- the three shipped checks, as functions over an ADAPTED-shaped dict ----
def measure_h(A, lam):
    copies = A[lam]; m = len(copies)
    if m == 1: return [[(1, 0)]]
    q00 = ip3_g(copies[0][0], copies[0][0])
    den = (q00[0]*q00[0] + q00[1]*q00[1]) % PRIME
    dinv = pow(den, PRIME-2, PRIME)
    inv = (q00[0]*dinv % PRIME, (-q00[1]*dinv) % PRIME)
    return [[gpmul(ip3_g(copies[i][0], copies[j][0]), inv) for j in range(m)]
            for i in range(m)]

def hermitian(row):
    m = len(row)
    return all(row[i][j] == gpconj(row[j][i]) for i in range(m) for j in range(m))

def dis_probe(A, lam, HM, tmax=None):
    """the shipped multi-probe check, restricted to one block."""
    copies = A[lam]; m = len(copies)
    dis = skipped = 0
    hi = len(copies[0]) if tmax is None else min(tmax, len(copies[0]))
    for t in range(1, hi):
        q = ip3_g(copies[0][t], copies[0][t])
        if q == (0, 0):
            skipped += 1; continue
        den = (q[0]*q[0] + q[1]*q[1]) % PRIME; dinv = pow(den, PRIME-2, PRIME)
        inv = (q[0]*dinv % PRIME, (-q[1]*dinv) % PRIME)
        for i in range(m):
            for j in range(m):
                if gpmul(ip3_g(copies[i][t], copies[j][t]), inv) != HM[i][j]:
                    dis += 1
    return dis, skipped

def det_gp(row):
    """determinant of an m x m matrix of Gaussian pairs mod PRIME, exact
    Gaussian-elimination-free Leibniz expansion (m <= 4 here)."""
    from itertools import permutations
    m = len(row); tot = (0, 0)
    for perm in permutations(range(m)):
        sgn = 1
        p = list(perm)
        for i in range(m):
            for j in range(i+1, m):
                if p[i] > p[j]: sgn = -sgn
        term = (1, 0)
        for i in range(m): term = gpmul(term, row[i][perm[i]])
        if sgn < 0: term = ((-term[0]) % PRIME, (-term[1]) % PRIME)
        tot = gpadd(tot, term)
    return tot

def square_check(A):
    BYW = {}
    for lam, copies in A.items():
        for i, c in enumerate(copies):
            for t, v in enumerate(c):
                if not v: continue
                BYW.setdefault(mwt(max(v)), []).append((lam, i, t, v))
    MONS = {}
    for idx in range(len(MONO)):
        MONS.setdefault(mwt(idx), []).append(idx)
    tot = sum(len(v) for v in BYW.values())
    sq = all(len(MONS.get(w, [])) == len(BYW[w]) for w in BYW)
    return tot, sq, BYW, MONS

def inhom_check(A):
    return sum(1 for cs in A.values() for c in cs for v in c
               if len({mwt(k) for k in v}) > 1)

def digest(A):
    import hashlib
    h = hashlib.sha256()
    for k in sorted(A):
        h.update(repr(k).encode())
        for cs in A[k]:
            for vec in cs:
                h.update(repr(sorted((i, (v.r, v.i)) for i, v in vec.items())).encode())
    return h.hexdigest()[:16]

def rank_at_weight(A, w, BYW, MONS):
    """rank mod PRIME of the per-weight matrix solve_weight factors."""
    ent = BYW[w]; mons = MONS[w]
    mi = {m: k for k, m in enumerate(mons)}
    n = len(ent)
    M = [[0]*n for _ in range(len(mons))]
    for j, (_, _, _, v) in enumerate(ent):
        for k, cv in v.items(): M[mi[k]][j] = to_p(cv)
    r = 0
    for c in range(n):
        p_ = next((t for t in range(r, len(M)) if M[t][c] % PRIME), None)
        if p_ is None: continue
        M[r], M[p_] = M[p_], M[r]
        inv = pow(M[r][c], PRIME-2, PRIME)
        M[r] = [x*inv % PRIME for x in M[r]]
        for t in range(len(M)):
            if t != r and M[t][c] % PRIME:
                f = M[t][c]; M[t] = [(x - f*y) % PRIME for x, y in zip(M[t], M[r])]
        r += 1
    return r, n
