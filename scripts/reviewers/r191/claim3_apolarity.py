"""Claims 1+2+3 together: ONE identity that all three conventions must satisfy.

The three pieces of stage 2 are a metric on Sym^3 V (claim 1), a coordinate
solve (claim 2) and a cube map (claim 3).  Each alone admits several
conventions; what makes them a system is the apolarity identity.  Write
G = H^T (the Gram in the usual sense, so that coords solves G w = rhs) and
rhs[b] = <W, f_b> = (G w)[b].  Under the embedding  x_a x_b x_c |-> (1/3!) sum_sigma
f_a (x) f_b (x) f_c  the cube of a vector goes to  W (x) W (x) W, so

    < W^3 , x_s >_induced  =  prod_{i=1..3} <W, f_{s_i}>  =  prod_i rhs[s_i].

Expressed through the code's own routines this reads

    sum_t cube(w)[t] * sym3_ip(t, s)  =  kappa * prod_i (H^T w)[s_i],

with kappa = 3! = 6 exactly when sym3_ip is the FISCHER normalisation, and
kappa = 1 for the induced (Bombieri) one.  kappa is a CONSTANT only if the
multinomial in `cube`, the permutation sum in `sym3_ip` and the transpose in
`coords` all agree.  Break any one of the three and kappa stops being constant
-- that is the discrimination, and it is a test that can fail.
"""
import sys, os, random, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import *

H = build_H()
Hm = Hfull(H)
Gm = [[Hm[b][a] for b in range(35)] for a in range(35)]      # G = H^T

def sym3_ip(t, s):
    tot = Z
    for perm in itertools.permutations(range(3)):
        term = ONE; ok = True
        for i in range(3):
            e = H.get((t[i], s[perm[i]]))
            if e is None: ok = False; break
            term = cmul(term, e)
        if ok: tot = cadd(tot, term)
    return tot

def cube(w):
    out = {}
    for t in MONO:
        z = (F(multinom(t)), F(0))
        for a in t: z = cmul(z, w[a])
        if z != Z: out[t] = z
    return out

def idbij(t, s):
    term = ONE
    for i in range(3):
        e = H.get((t[i], s[i]))
        if e is None: return Z
        term = cmul(term, e)
    return term

def cube_nomult(w):                     # the competing convention for claim 3
    out = {}
    for t in MONO:
        z = ONE
        for a in t: z = cmul(z, w[a])
        if z != Z: out[t] = z
    return out

BYMW = {}
for i, w in enumerate(MW): BYMW.setdefault(w, []).append(i)

random.seed(1191)
def randw():
    return [(F(random.randint(-4, 4), random.randint(1, 3)),
             F(random.randint(-4, 4), random.randint(1, 3))) for _ in range(35)]

def leftmul(M, w):
    """b -> sum_a w_a M[a][b].  With M = H this is <W, f_b> = (H^T w)[b]."""
    out = []
    for b in range(35):
        acc = Z
        for a in range(35):
            if w[a] != Z and M[a][b] != Z: acc = cadd(acc, cmul(w[a], M[a][b]))
        out.append(acc)
    return out

def ratios(cubefn, ipfn, dualfn, nw=3, ns=14):
    """kappa over random w and random test monomials s."""
    seen = []
    for _ in range(nw):
        w = randw()
        q = cubefn(w)
        dual = dualfn(w)
        cand = [s for s in BYMW if len(BYMW[s]) > 1]
        for _ in range(ns):
            mu = random.choice(cand)
            si = random.choice(BYMW[mu])
            s = MONO[si]
            lhs = Z
            for ti in BYMW[mu]:
                t = MONO[ti]
                qt = q.get(t)
                if qt is None: continue
                lhs = cadd(lhs, cmul(qt, ipfn(t, s)))
            rhs = ONE
            for i in range(3): rhs = cmul(rhs, dual[s[i]])
            if rhs == Z:
                if lhs != Z: seen.append("rhs=0 but lhs!=0")
                continue
            seen.append(cdiv(lhs, rhs))
    return seen

def report(name, seen):
    vals = {v for v in seen if not isinstance(v, str)}
    strs = {v for v in seen if isinstance(v, str)}
    if len(vals) == 1 and not strs:
        k = vals.pop()
        print(f"  {name:46s} kappa CONSTANT = ({k[0]}) + ({k[1]})i   over {len(seen)} samples")
    else:
        show = sorted({(str(v[0]), str(v[1])) if not isinstance(v, str) else v
                       for v in seen})[:4]
        print(f"  {name:46s} kappa NOT constant: {len(vals)} distinct values, e.g. {show}")

dualG = lambda w: leftmul(Hm, w)                 # rhs[b] = sum_a w_a H[a][b]  (= (H^T w)[b])
def dualHT(w):
    """the competing convention: rhs[b] = sum_a H[b][a] w_a  (no transpose)."""
    out = []
    for b in range(35):
        acc = Z
        for a in range(35):
            if w[a] != Z and Hm[b][a] != Z: acc = cadd(acc, cmul(Hm[b][a], w[a]))
        out.append(acc)
    return out
def dualconj(w):
    """the competing convention: rhs[b] = sum_a w_a conj(H[a][b])."""
    out = []
    for b in range(35):
        acc = Z
        for a in range(35):
            if w[a] != Z and Hm[a][b] != Z: acc = cadd(acc, cmul(w[a], cconj(Hm[a][b])))
        out.append(acc)
    return out

print("=== kappa in   sum_t cube(w)[t] sym3_ip(t,s) = kappa * prod_i rhs[s_i] ===")
print("  (a constant kappa is the statement that the three conventions agree)")
report("cube x sym3_ip x (H^T w)  [the code]", ratios(cube, sym3_ip, dualG))
report("cube x sym3_ip/3! x (H^T w) [Bombieri]",
       ratios(cube, lambda t, s: cdiv(sym3_ip(t, s), (F(6), F(0))), dualG))
print("\n=== the same identity with ONE convention broken (must lose constancy) ===")
report("cube WITHOUT the multinomial", ratios(cube_nomult, sym3_ip, dualG))
report("sym3_ip WITHOUT the permutation sum", ratios(cube, idbij, dualG))
report("coords WITHOUT the transpose (H w)", ratios(cube, sym3_ip, dualHT))
report("coords with the conjugate on the wrong side", ratios(cube, sym3_ip, dualconj))
