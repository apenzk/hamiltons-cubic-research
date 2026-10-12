"""r203: step (b) of the order-2 argument, checked where it actually lives.

run_n5_order2.py claims (Weyl_5)^H is one-dimensional and "checks" it with
    c = <S^2,S>/<S,S>;  R = S^2 - c S;  assert <R,S> == 0
which is an algebraic identity in c and cannot fail.  Here the statement is
tested directly:

  1. h  = {X in so(5) : rho(X) W_0 = 0}, the stabiliser Lie algebra.
  2. dim of the joint kernel  {v in Weyl_5 : rho(X) v = 0 for all X in h}.
     Step (b) needs this to be 1.  Using the IDENTITY COMPONENT only is the
     stronger statement: (Weyl_5)^H is contained in (Weyl_5)^{h}.
  3. the falsifiable consequence the file should have tested:
        pi(S^m) = (tr(S^{m+1})/6) * S      for every m,
     pi the orthogonal projection Sym^2(Lambda^2) -> Weyl_5.  Each S^m is
     H-fixed, so a non-proportional pi(S^m) would refute step (b) outright.
All exact over Q.
"""
import importlib.util, os, sys
from fractions import Fraction as F

RUNS = "scripts/runs"
def load(n):
    sp = importlib.util.spec_from_file_location(n[:-3], os.path.join(RUNS, n))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m); sys.stdout = o
    return m

wm = load("run_n5_weyl_module.py")
ex = load("run_n5_extremiser.py")
NP, NS, SPAIRS, SIDX = wm.NP, wm.NS, wm.SPAIRS, wm.SIDX
BASIS, GENS = wm.BASIS, wm.GENS
S = ex.S
print(f"loaded: dim Weyl_5 = {len(BASIS)}, {len(GENS)} so(5) generators, S is {NP}x{NP}")

# ---- coordinates -----------------------------------------------------------
FREE = []
for k, b in enumerate(BASIS):
    FREE.append(next(c for c in range(NS)
                     if b[c] == 1 and all(BASIS[m][c] == 0 for m in range(len(BASIS)) if m != k)))
coords = lambda v: [v[f] for f in FREE]
def expand(c):                      # 35 coords -> 55-vector in Sym^2(Lambda^2)
    v = [F(0)]*NS
    for k, ck in enumerate(c):
        if ck:
            for j in range(NS):
                if BASIS[k][j]: v[j] += ck*BASIS[k][j]
    return v

def sym2vec(M):                     # symmetric 10x10 -> 55-vector (v_{ab} = M[a][b])
    return [M[a][b] for (a, b) in SPAIRS]
def vec2sym(v):
    M = [[F(0)]*NP for _ in range(NP)]
    for k, (a, b) in enumerate(SPAIRS): M[a][b] = M[b][a] = v[k]
    return M

w0 = coords(sym2vec(S))
assert expand(w0) == sym2vec(S), "S is not in Weyl_5 in these coordinates"
print(f"  W_0 (as sqrt6*W_0 = S) sits in Weyl_5, coords recovered exactly")

# ---- exact rational linear algebra ----------------------------------------
def rref(M):
    M = [r[:] for r in M]; piv = []; r = 0; n = len(M[0]) if M else 0
    for c in range(n):
        p = next((k for k in range(r, len(M)) if M[k][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        inv = F(1)/M[r][c]; M[r] = [x*inv for x in M[r]]
        for k in range(len(M)):
            if k != r and M[k][c]:
                f = M[k][c]; M[k] = [x - f*y for x, y in zip(M[k], M[r])]
        piv.append(c); r += 1
        if r == len(M): break
    return M, piv
def nullspace(M, n):
    R, piv = rref(M) if M else ([], [])
    free = [c for c in range(n) if c not in piv]
    out = []
    for f in free:
        v = [F(0)]*n; v[f] = F(1)
        for i, c in enumerate(piv): v[c] = -R[i][f]
        out.append(v)
    return out

# ---- 1. the stabiliser Lie algebra ----------------------------------------
# rows indexed by the 35 output coords, columns by the 10 generators
Aw = [[F(0)]*len(GENS) for _ in range(35)]
for g, G in enumerate(GENS):
    img = [sum(G[i][j]*w0[j] for j in range(35) if w0[j]) for i in range(35)]
    for i in range(35): Aw[i][g] = img[i]
h = nullspace(Aw, len(GENS))
print(f"\n1. dim Stab_{{so(5)}}(W_0) = {len(h)}   (u(2) has dim 4: {len(h)==4})")
print(f"   orbit dimension = 10 - {len(h)} = {10-len(h)}")

# a sanity check that h really annihilates W_0
for x in h:
    M = [[sum(x[g]*GENS[g][i][j] for g in range(len(GENS))) for j in range(35)] for i in range(35)]
    assert all(sum(M[i][j]*w0[j] for j in range(35)) == 0 for i in range(35))
print("   every basis element of h annihilates W_0 exactly")

# ---- 2. the joint kernel = (Weyl_5)^{h} -----------------------------------
rows = []
for x in h:
    M = [[sum(x[g]*GENS[g][i][j] for g in range(len(GENS)) if x[g]) for j in range(35)]
         for i in range(35)]
    rows.extend(M)
fix = nullspace(rows, 35)
print(f"\n2. dim (Weyl_5)^h = {len(fix)}   <- step (b) needs 1")
if len(fix) == 1:
    v = fix[0]
    j = next(i for i in range(35) if v[i])
    lam = F(w0[j], 1)/v[j] if v[j] else None
    prop = all(w0[i]*v[j] == v[i]*w0[j] for i in range(35))
    print(f"   the fixed line is spanned by W_0: {prop}")
print("   (h is the Lie algebra of the IDENTITY component, so (Weyl_5)^H is")
print("    contained in this; 1-dimensional here settles the full H as well)")

# ---- 3. pi(S^m) = (tr(S^{m+1})/6) S ---------------------------------------
# metric on Sym^2(Lambda^2) induced by <A,B> = tr(AB) = sum_{ab} A_ab B_ab
wgt = [F(1) if a == b else F(2) for (a, b) in SPAIRS]
def ip55(u, v): return sum(wgt[k]*u[k]*v[k] for k in range(NS))
Gram = [[ip55(BASIS[i], BASIS[j]) for j in range(35)] for i in range(35)]
def proj_coords(v55):
    """orthogonal projection of a 55-vector onto Weyl_5, returned in coords."""
    rhs = [ip55(BASIS[i], v55) for i in range(35)]
    aug = [Gram[i][:] + [rhs[i]] for i in range(35)]
    R, piv = rref(aug)
    assert piv == list(range(35)), "Gram singular"
    return [R[i][35] for i in range(35)]

def opmul(A, B): return [[sum(A[i][k]*B[k][j] for k in range(NP) if A[i][k])
                          for j in range(NP)] for i in range(NP)]
print("\n3. pi(S^m) against the prediction (tr(S^{m+1})/6) S:")
P = [[F(1) if i == j else F(0) for j in range(NP)] for i in range(NP)]   # S^0
ok_all = True
for m in range(0, 7):
    if m: P = opmul(P, S)
    tr_next = sum(opmul(P, S)[i][i] for i in range(NP))
    pc = proj_coords(sym2vec(P))
    pred = [F(tr_next, 6)*x for x in w0]
    ok = pc == pred
    ok_all &= ok
    nonzero = any(pc)
    print(f"   m={m}: tr(S^{m+1}) = {str(tr_next):>10}   pi(S^m) == (tr/6) S : {ok}"
          f"{'' if nonzero else '   [both zero]'}")
print(f"   all m: {ok_all}")

# and the exact statement the docstring wanted, for m = 2:
S2 = opmul(S, S)
c = F(ip55(sym2vec(S2), sym2vec(S)), ip55(sym2vec(S), sym2vec(S)))
resid = [x - y for x, y in zip(proj_coords(sym2vec(S2)), [c*t for t in w0])]
print(f"\n   pi(S^2) - c S with c = <S^2,S>/<S,S> = {c}: residual zero = {not any(resid)}")
print("   THIS is the check run_n5_order2.py describes; the one it runs is")
print("   <S^2 - cS, S> = 0, which is c's defining equation.")
