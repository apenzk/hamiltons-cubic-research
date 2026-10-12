"""r207, claims 1 and 3: the apolarity reduction re-derived in a miniature where
every step can be checked exactly, plus sabotage plants.

The model: V = R^3, G = the signed permutations (order 48), w_0 = (1,1,0), cubics
U = Sym^3(V*), sextics Sym^6(V*), apolar pairing <x^a, x^b> = delta * a!/d!.
Every structure the file uses appears here -- K, mu, Cat, the invariant
projection A, ANN, the image, A(w_0^6) -- so each step of the reduction is tested
against a computed answer, in exact rational arithmetic.

The plants corrupt one object at a time and confirm the corresponding check fires.
"""
from fractions import Fraction as F
from itertools import permutations, product
from math import factorial

N = 3
def monos(d):
    out = []
    for a in range(d+1):
        for b in range(d-a+1): out.append((a, b, d-a-b))
    return sorted(out)
M3, M6 = monos(3), monos(6)
I3 = {m:i for i,m in enumerate(M3)}; I6 = {m:i for i,m in enumerate(M6)}
def wt(m, d): return F(factorial(m[0])*factorial(m[1])*factorial(m[2]), factorial(d))
W3 = [wt(m,3) for m in M3]; W6 = [wt(m,6) for m in M6]
def apolar(f, g, W): return sum(a*b*w for a,b,w in zip(f,g,W))
def coeffpair(f, g): return sum(a*b for a,b in zip(f,g))          # the WRONG pairing

def evalpoly(f, v, M): return sum(c*v[0]**m[0]*v[1]**m[1]*v[2]**m[2] for c,m in zip(f,M))
def power(v, d):
    """v^d in Sym^d, as a coefficient vector: (sum v_i x_i)^d."""
    M = monos(d); out = [F(0)]*len(M)
    for i,m in enumerate(M):
        out[i] = F(factorial(d), factorial(m[0])*factorial(m[1])*factorial(m[2])) \
                 * F(v[0])**m[0]*F(v[1])**m[1]*F(v[2])**m[2]
    return out

# --- linear algebra over Q ------------------------------------------------
def rref(rows):
    rows = [list(map(F, r)) for r in rows]; piv = []; r = 0
    for c in range(len(rows[0]) if rows else 0):
        p = next((k for k in range(r, len(rows)) if rows[k][c]), None)
        if p is None: continue
        rows[r], rows[p] = rows[p], rows[r]
        rows[r] = [x/rows[r][c] for x in rows[r]]
        for k in range(len(rows)):
            if k != r and rows[k][c]:
                f = rows[k][c]; rows[k] = [a-f*b for a,b in zip(rows[k], rows[r])]
        piv.append(c); r += 1
        if r == len(rows): break
    return rows[:r], piv
def rank(rows): return 0 if not rows else len(rref(rows)[0])
def nullspace(rows, n):
    if not rows: return [[F(int(i==j)) for j in range(n)] for i in range(n)]
    R, piv = rref(rows); free = [c for c in range(n) if c not in piv]; out = []
    for fc in free:
        v = [F(0)]*n; v[fc] = F(1)
        for i, c in enumerate(piv): v[c] = -R[i][fc]
        out.append(v)
    return out
def in_span(rows, v):
    return rank(rows + [v]) == rank(rows)

# --- the group and its action --------------------------------------------
G = []
for sgm in permutations(range(N)):
    for sg in product((1,-1), repeat=N):
        G.append((sgm, sg))
def act(g, f, M, I):
    """(g.f)(x) = f(g^{-1} x); on monomials this permutes and signs exponents."""
    sgm, sg = g; out = [F(0)]*len(M)
    for i, m in enumerate(M):
        nm = [0]*N; s = 1
        for k in range(N):
            nm[sgm[k]] = m[k]
            if sg[k] < 0 and m[k] % 2: s = -s
        out[I[tuple(nm)]] += s*F(f[i])
    return out
def gv(g, v):
    sgm, sg = g; out = [0]*N
    for k in range(N): out[sgm[k]] = sg[k]*v[k]
    return out
def reynolds(f, M, I):
    acc = [F(0)]*len(M)
    for g in G:
        h = act(g, f, M, I); acc = [a+b for a,b in zip(acc, h)]
    return [a/len(G) for a in acc]

print("=== the model ===")
w0 = [1,1,0]
orbit = sorted({tuple(gv(g, w0)) for g in G})
print(f"|G| = {len(G)}, orbit of w_0 = {len(orbit)} points, dim Sym^3 = {len(M3)},"
      f" dim Sym^6 = {len(M6)}")

# --- STEP A: <v^d, h> = h(v), exactly ------------------------------------
bad = max(abs(apolar(power(v,6), h, W6) - evalpoly(h, v, M6))
          for v in ([1,2,3],[2,-1,5],[1,1,0])
          for h in ([F(1)]*len(M6), [F(i+1) for i in range(len(M6))]))
print(f"\nA. <v^6, h> - h(v) = {bad}   (must be 0: this is what fixes the "
      f"normalisation a!/d!)")
assert bad == 0
print(f"   plant: drop the weights a!/d! from the pairing -> "
      f"<v^6,h> - h(v) = {coeffpair(power([1,2,3],6), [F(1)]*len(M6)) - evalpoly([F(1)]*len(M6), [1,2,3], M6)}"
      f"  (nonzero, so the plant fires)")

# --- STEP B: adjointness <F, mu(B)> = <Cat_F, B> -------------------------
def mu(B):
    out = [F(0)]*len(M6)
    for i, mi in enumerate(M3):
        for j, mj in enumerate(M3):
            out[I6[tuple(a+b for a,b in zip(mi,mj))]] += B[i][j]
    return out
def cat(Fv):
    return [[Fv[I6[tuple(a+b for a,b in zip(mi,mj))]]*W6[I6[tuple(a+b for a,b in zip(mi,mj))]]
             for mj in M3] for mi in M3]
import random
random.seed(207)
Fv = [F(random.randint(-9,9)) for _ in M6]
B = [[F(0)]*len(M3) for _ in M3]
for i in range(len(M3)):
    for j in range(i, len(M3)):
        B[i][j] = B[j][i] = F(random.randint(-5,5))
lhs = apolar(Fv, mu(B), W6)
C = cat(Fv)
rhs = sum(B[i][j]*C[i][j] for i in range(len(M3)) for j in range(len(M3)))
print(f"\nB. <F, mu(B)> = {lhs}, <Cat_F, B> = {rhs}, equal: {lhs == rhs}")
assert lhs == rhs
print("   NOTE the identity is a tautology once Cat_F(f,g) := <F, fg>: it holds for")
print("   ANY bilinear form in place of the apolar one, so it carries no")
print("   normalisation content.  Check with the (wrong) coefficient pairing:")
C2 = [[coeffpair(Fv, mu_ij) for mu_ij in
       [ [F(int(tuple(a+b for a,b in zip(mi,mj)) == m6)) for m6 in M6] for mj in M3]]
      for mi in M3]
lhs2 = coeffpair(Fv, mu(B))
rhs2 = sum(B[i][j]*C2[i][j] for i in range(len(M3)) for j in range(len(M3)))
print(f"   coefficient pairing: {lhs2} = {rhs2}: {lhs2 == rhs2}  (still an identity)")
print("   PLANT: define Cat with the apolar pairing but evaluate <F, mu(B)> with")
print(f"   the coefficient pairing -> {lhs2} vs {rhs}: mismatch fires: {lhs2 != rhs}")
assert lhs2 != rhs

# --- STEP C: F -> Cat_F injective ----------------------------------------
rowsC = []
for k in range(len(M6)):
    e = [F(int(i==k)) for i in range(len(M6))]; Ck = cat(e)
    rowsC.append([Ck[i][j] for i in range(len(M3)) for j in range(i, len(M3))])
print(f"\nC. rank of F -> Cat_F : {rank(rowsC)} of dim Sym^6 = {len(M6)}  "
      f"(injective; mu is onto, so its adjoint is one-to-one)")
assert rank(rowsC) == len(M6)

# --- STEP D: G-invariance of the apolar pairing --------------------------
worst = max(abs(apolar(act(g,Fv,M6,I6), act(g,[F(random.randint(-9,9)) for _ in M6],M6,I6), W6)
                - 0) for g in G[:1])   # placeholder to keep flake quiet
Gv = [F(random.randint(-9,9)) for _ in M6]
inv_ok = all(apolar(act(g,Fv,M6,I6), act(g,Gv,M6,I6), W6) == apolar(Fv,Gv,W6) for g in G)
print(f"\nD. <gF, gG> = <F, G> for all {len(G)} group elements: {inv_ok}")
assert inv_ok
scaled = ((0,1,2),(2,1,1))          # not orthogonal: a sign pattern is fine, so
def act_scaled(f, M, I, s):
    out = [F(0)]*len(M)
    for i,m in enumerate(M):
        out[i] = F(f[i])*F(s)**m[0]
    return out
p1, p2 = act_scaled(Fv,M6,I6,2), act_scaled(Gv,M6,I6,2)
print(f"   plant: replace g by the non-orthogonal diag(2,1,1) -> "
      f"<gF,gG> = {apolar(p1,p2,W6)} vs <F,G> = {apolar(Fv,Gv,W6)}: "
      f"invariance fires: {apolar(p1,p2,W6) != apolar(Fv,Gv,W6)}")

# --- STEP E: K, ANN, the image, and F in image <=> F _|_ ANN -------------
ev = [[F(evalpoly([F(int(i==k)) for i in range(len(M3))], p, M3)) for k in range(len(M3))]
      for p in orbit]
K = nullspace(ev, len(M3))
print(f"\nE. dim K = {len(K)} (cubics vanishing on the orbit), codim {len(M3)-len(K)}")
inv6 = [v for v in rref([reynolds([F(int(i==k)) for i in range(len(M6))], M6, I6)
                         for k in range(len(M6))])[0]]
print(f"   dim (Sym^6)^G = {len(inv6)}")
# image of the invariant Grams supported on K
sym2K = []
for a in range(len(K)):
    for b in range(a, len(K)):
        Bm = [[ (K[a][i]*K[b][j] + K[b][i]*K[a][j])/2 for j in range(len(M3))]
              for i in range(len(M3))]
        sym2K.append(mu(Bm))
img = rref([reynolds(s, M6, I6) for s in sym2K])[0]
print(f"   dim mu((Sym^2 K)^G) = {len(img)}")
# ANN = invariant sextics whose catalecticant kills K x K
cond = []
for a in range(len(K)):
    for b in range(a, len(K)):
        row = []
        for k in range(len(M6)):
            Ck = cat([F(int(i==k)) for i in range(len(M6))])
            row.append(sum(K[a][i]*Ck[i][j]*K[b][j] for i in range(len(M3))
                           for j in range(len(M3))))
        cond.append(row)
ann = [v for v in nullspace(cond + [[F(0)]*len(M6)], len(M6))]
ann = [v for v in ann if in_span(inv6, v)]
annsp = rref([v for v in nullspace(cond + [r for r in nullspace(inv6, len(M6))], len(M6))])[0] \
        if inv6 else []
print(f"   dim ANN (invariant sextics with Cat_F(K,K) = 0) = {len(annsp)}")
print(f"   rank = dim (Sym^6)^G - dim ANN : {len(inv6)} - {len(annsp)} = "
      f"{len(inv6)-len(annsp)} , measured dim image = {len(img)} : "
      f"{len(inv6)-len(annsp) == len(img)}")
assert len(inv6) - len(annsp) == len(img)
# F in image <=> F _|_ ANN, on random invariant sextics
ok = True
for _ in range(30):
    f = reynolds([F(random.randint(-6,6)) for _ in M6], M6, I6)
    inimg = in_span(img, f)
    perp = all(apolar(f, a, W6) == 0 for a in annsp)
    ok &= (inimg == perp)
print(f"   F in image <=> F _|_ ANN on 30 random invariant sextics: {ok}")
assert ok

# --- STEP F (claim 3): A(w_0^6) and its catalecticant --------------------
Aw = reynolds(power(w0, 6), M6, I6)
print(f"\nF. A(w_0^6) != 0 : {any(Aw)}")
CA = cat(Aw)
rank1 = [[F(evalpoly([F(int(t==i)) for t in range(len(M3))], w0, M3)) *
          F(evalpoly([F(int(t==j)) for t in range(len(M3))], w0, M3))
          for j in range(len(M3))] for i in range(len(M3))]
avg = [[sum(F(evalpoly([F(int(t==i)) for t in range(len(M3))], p, M3)) *
            F(evalpoly([F(int(t==j)) for t in range(len(M3))], p, M3)) for p in orbit)/len(orbit)
        for j in range(len(M3))] for i in range(len(M3))]
sc = None
for i in range(len(M3)):
    for j in range(len(M3)):
        if avg[i][j]: sc = CA[i][j]/avg[i][j]; break
    if sc is not None: break
print(f"   Cat_A(w_0^6) = {sc} x (orbit average of f(p)g(p)) : "
      f"{all(CA[i][j] == sc*avg[i][j] for i in range(len(M3)) for j in range(len(M3)))}")
print(f"   rank of the orbit-average form  = {rank(avg)}")
print(f"   rank of the rank-one form f(w_0)g(w_0) = {rank(rank1)}")
print(f"   so Cat_A(w_0^6) is NOT (f,g) -> f(w_0)g(w_0): "
      f"{any(CA[i][j] != sc*rank1[i][j] for i in range(len(M3)) for j in range(len(M3)))}")
wi = wj = None
for i in range(len(M3)):
    for j in range(len(M3)):
        if CA[i][j] != sc*rank1[i][j]: wi, wj = i, j; break
    if wi is not None: break
print(f"   witness: on (m_{wi}, m_{wj}) the true catalecticant is {CA[wi][wj]} "
      f"and the stated rank-one form is {sc*rank1[wi][wj]}")
print(f"   both kill K x K though: "
      f"{all(sum(K[a][i]*avg[i][j]*K[b][j] for i in range(len(M3)) for j in range(len(M3))) == 0 for a in range(len(K)) for b in range(len(K)))}"
      f" / {all(sum(K[a][i]*rank1[i][j]*K[b][j] for i in range(len(M3)) for j in range(len(M3))) == 0 for a in range(len(K)) for b in range(len(K)))}")
# <F, A(w_0^6)> = F(w_0) for invariant F
ok = True
for _ in range(20):
    f = reynolds([F(random.randint(-6,6)) for _ in M6], M6, I6)
    ok &= apolar(f, Aw, W6) == evalpoly(f, w0, M6)
print(f"   <F, A(w_0^6)> = F(w_0) exactly, for invariant F: {ok}  "
      f"(constant 1, not merely 'proportional')")
assert ok
f_noninv = [F(random.randint(-6,6)) for _ in M6]
print(f"   plant: drop invariance of F -> <F, A(w_0^6)> = "
      f"{apolar(f_noninv, Aw, W6)} vs F(w_0) = {evalpoly(f_noninv, w0, M6)}: "
      f"differs: {apolar(f_noninv, Aw, W6) != evalpoly(f_noninv, w0, M6)}")
print(f"   A(w_0^6) lies in ANN: {in_span(annsp, Aw) if annsp else 'ANN is 0'}")
