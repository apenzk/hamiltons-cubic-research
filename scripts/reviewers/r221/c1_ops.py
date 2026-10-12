"""r221.  Is D["E"] actually a raising-operator action of D6 on the 1638-dim module?

Claim 1's chain rests on "nullity_Q >= m_lambda by complete reducibility", which
presumes A is the matrix of the raising operators of a genuine module.  Nothing in
the run under review checks that.  Three tests here, all independent of the
character:
  T1  shape: E_i takes V_w to V_{w+alpha_i}, column and row counts must match.
  T2  Serre relations for the positive part of D6:  [E_i,E_j]=0 when a_ij=0 and
      [E_i,[E_i,E_j]]=0 when a_ij=-1.  These pin n^+ of D6 exactly.
  T3  the joint kernel of the six E_i on V itself is 1-dimensional and sits at
      weight (2,2,0,0,0,0).  V irreducible with that highest weight is exactly
      the Weyl module the whole construction is about.
"""
import pickle, os, sys
from fractions import Fraction as F
from collections import defaultdict

d = os.path.dirname(os.path.abspath(__file__))
D = pickle.load(open(os.path.join(d, "..", "r216", "weyl12.pkl"), "rb"))
ALPHA = D["ALPHA"]; WDIM = D["WEYL"]
WTS = sorted(WDIM)
OFF = {}; n = 0
for w in WTS: OFF[w] = n; n += WDIM[w]
GW = [None]*n
for w in WTS:
    for k in range(WDIM[w]): GW[OFF[w]+k] = w
print("dim", n, "weights", len(WTS))

# ---- T1 shape -------------------------------------------------------------
bad = []
for i in range(6):
    for w, cols in D["E"][i].items():
        tw = tuple(a+b for a, b in zip(w, ALPHA[i]))
        if w not in WDIM: bad.append(("src not a weight", i, w))
        if len(cols) != WDIM.get(w, -1): bad.append(("ncols", i, w, len(cols), WDIM.get(w)))
        for col in cols:
            if len(col) != WDIM.get(tw, 0): bad.append(("nrows", i, w, tw, len(col), WDIM.get(tw)))
print("T1 shape violations:", len(bad), bad[:5])

# ---- dense-ish global matrices over Q, as dict-of-dict {col:{row:val}} ----
E = [defaultdict(dict) for _ in range(6)]
for i in range(6):
    for w, cols in D["E"][i].items():
        tw = tuple(a+b for a, b in zip(w, ALPHA[i]))
        for j, col in enumerate(cols):
            for r, s in enumerate(col):
                x = F(s)
                if x: E[i][OFF[w]+j][OFF[tw]+r] = x

def compose(X, Y):
    """X after Y, both {col:{row:val}}."""
    out = defaultdict(dict)
    for c, colY in Y.items():
        acc = defaultdict(F)
        for r, v in colY.items():
            for r2, v2 in X.get(r, {}).items(): acc[r2] += v2*v
        z = {k: v for k, v in acc.items() if v}
        if z: out[c] = z
    return out
def sub(X, Y):
    out = defaultdict(dict)
    for c in set(X) | set(Y):
        acc = defaultdict(F, X.get(c, {}))
        for r, v in Y.get(c, {}).items(): acc[r] -= v
        z = {k: v for k, v in acc.items() if v}
        if z: out[c] = z
    return out
def brk(X, Y): return sub(compose(X, Y), compose(Y, X))
def nnz(X): return sum(len(v) for v in X.values())

# Cartan matrix of D6 from the simple roots, a_ij = 2(ai,aj)/(aj,aj), all |a|^2=2
def ip(u, v): return sum(x*y for x, y in zip(u, v))
CART = [[ip(ALPHA[i], ALPHA[j]) for j in range(6)] for i in range(6)]
print("Cartan matrix (=(ai,aj), all roots have square length 2):")
for r in CART: print("   ", r)

viol = []
for i in range(6):
    for j in range(6):
        if i == j: continue
        a = CART[i][j]
        if a == 0:
            if nnz(brk(E[i], E[j])): viol.append(("[Ei,Ej]!=0", i, j))
        elif a == -1:
            X = brk(E[i], brk(E[i], E[j]))
            if nnz(X): viol.append(("ad^2!=0", i, j, nnz(X)))
        else:
            viol.append(("unexpected Cartan entry", i, j, a))
print("T2 Serre violations:", len(viol), viol[:8])

# ---- T3 joint kernel of the six E_i on V ---------------------------------
P = 2147483647
def rank_modp(rows, ncols):
    piv = {}; rk = 0
    rows = [dict(r) for r in rows if r]
    for r in rows:
        while r:
            c = next(iter(sorted(r)))
            if c not in piv:
                piv[c] = r; rk += 1; break
            pr = piv[c]; f0 = r[c]*pow(pr[c], P-2, P) % P
            for cc, v in pr.items():
                nv = (r.get(cc, 0) - f0*v) % P
                if nv: r[cc] = nv
                else: r.pop(cc, None)
    return rk

tot_nul = 0; ker_w = []
for w in WTS:
    cols = list(range(OFF[w], OFF[w]+WDIM[w]))
    rows = defaultdict(dict)
    for j, c in enumerate(cols):
        for i in range(6):
            for r, x in E[i].get(c, {}).items():
                v = x.numerator*pow(x.denominator % P, P-2, P) % P
                if v: rows[(i, r)][j] = v
    rk = rank_modp(list(rows.values()), len(cols))
    nul = len(cols) - rk
    tot_nul += nul
    if nul: ker_w.append((w, nul))
print("T3 joint kernel of the six E_i on V: dim", tot_nul, "at weights", ker_w)
