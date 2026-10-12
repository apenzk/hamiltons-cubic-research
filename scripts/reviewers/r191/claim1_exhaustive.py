"""Two loose ends on claim 1.

(a) The adjointness test, EXHAUSTIVELY over a pair of adjacent weight spaces,
    so the verdict does not rest on sampling.
(b) An audit of the three `IP_CONVENTION` branches now sitting in
    run_n5_evaluate.py, against the same test.  The labels there do not name
    what the branches compute, so the audit is by VALUE, not by name.
"""
import sys, os, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import *
from lowering import H, FS
from math import factorial

def perm_sum(t, s):
    tot = Z
    for perm in itertools.permutations(range(3)):
        term = ONE; ok = True
        for i in range(3):
            e = H.get((t[i], s[perm[i]]))
            if e is None: ok = False; break
            term = cmul(term, e)
        if ok: tot = cadd(tot, term)
    return tot

def aut(u):
    m = {}
    for x in u: m[x] = m.get(x, 0) + 1
    r = 1
    for v in m.values(): r *= factorial(v)
    return r

BRANCH = {   # exactly the three branches of the edited run_n5_evaluate.py
  'file branch "IDBIJ"    (the default)': lambda t, s: perm_sum(t, s),
  'file branch "FISCHER"  (/aut aut)':    lambda t, s: cdiv(perm_sum(t, s),
                                                            (F(aut(t)*aut(s)), F(0))),
  'file branch "BOMBIERI" (/3!)':         lambda t, s: cdiv(perm_sum(t, s), (F(6), F(0))),
  'identity bijection only (no sum)':     lambda t, s: (lambda r: r)(
        (lambda: None)()) if False else None,
}
def only_id(t, s):
    term = ONE
    for i in range(3):
        e = H.get((t[i], s[i]))
        if e is None: return Z
        term = cmul(term, e)
    return term
BRANCH['identity bijection only (no sum)'] = only_id

BYMW = {}
for i, w in enumerate(MW): BYMW.setdefault(w, []).append(i)

def exhaustive(M, k, mu):
    a = ALPHA[k]; nu = (mu[0]+a[0], mu[1]+a[1])
    ts, ss = BYMW[mu], BYMW[nu]
    E, Fo = EC[k], FS[k]
    Rt = {ti: raise_mono(ti, E) for ti in ts}
    Rs = {si: raise_mono(si, Fo) for si in ss}
    bad = 0
    for ti in ts:
        t = MONO[ti]
        for si in ss:
            s = MONO[si]
            lhs = Z
            for kk, v in Rt[ti].items(): lhs = cadd(lhs, cmul(v, M(MONO[kk], s)))
            rhs = Z
            for jj, v in Rs[si].items(): rhs = cadd(rhs, cmul(cconj(v), M(t, MONO[jj])))
            if lhs != rhs: bad += 1
    return len(ts)*len(ss), bad

# a pair of adjacent weight spaces of workable size, containing several
# repetition patterns so a pattern-diagonal rescaling has room to show
cands = sorted(((mu, len(v)) for mu, v in BYMW.items()
                if (mu[0]+1, mu[1]-1) in BYMW and 8 <= len(v) <= 22),
               key=lambda x: -x[1])
mu = cands[0][0]
nu = (mu[0]+1, mu[1]-1)
def pats(idxs):
    d = {}
    for i in idxs:
        p = tuple(sorted((MONO[i].count(x) for x in set(MONO[i])), reverse=True))
        d[p] = d.get(p, 0) + 1
    return d
print(f"exhaustive over weight {mu} ({len(BYMW[mu])} monomials, patterns {pats(BYMW[mu])})")
print(f"                  -> {nu} ({len(BYMW[nu])} monomials, patterns {pats(BYMW[nu])})")
print(f"  alpha_1, every pair:")
for name, M in BRANCH.items():
    n, bad = exhaustive(M, 1, mu)
    print(f"    {name:38s} {n-bad}/{n} pairs satisfy <Eu,v>=<u,Fv>   "
          f"{'PASS' if bad == 0 else 'FAIL'}")

print("\n=== do the branches even differ?  values at H = the real H ===")
probe = [MONO[BYMW[mu][0]], MONO[BYMW[mu][1]]]
t = probe[0]
for name, M in BRANCH.items():
    print(f"    {name:38s} M(t,t) = {M(t, t)[0]}   for t = {t} (aut={aut(t)})")
print("  (the file's comment says the bijection sum and 'FISCHER' agree when H is")
print("   diagonal; they differ by aut(t)^2 on the diagonal, so they never agree)")
