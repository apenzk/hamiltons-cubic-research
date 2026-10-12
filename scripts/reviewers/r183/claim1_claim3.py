"""Reviewer 183.  Two questions, both answered exactly over Q.

CLAIM 1.  run_n5_sextic_basis.py builds F_5 with
    q(W)    = sum_{abcd} W_abcd W_abcd          (rank-4 TENSOR norm)
    trM3(W) = tr(M^3), M = W.reshape(25,25)     (25x25 flattening)
while run_n5_extremiser.py works with the 10x10 operator A on Lambda^2,
A_{(ij),(kl)} = W_ijkl for i<j, k<l, and reports |W_0|^2 = tr(A^2) = 1 and
tr(W_0^3) = tr(A^3) = 1/sqrt6.  Question: are these the same polynomial?

CLAIM 3.  run_n5_inner_product.py takes the rank-4 tensor norm as the invariant
form and tests skewness on 3 random pairs per generator.  Question: is it
invariant, and how does it compare with the Lambda^2 operator form?
"""
from fractions import Fraction as F
import importlib.util, sys, os, random

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
def load(name):
    spec = importlib.util.spec_from_file_location(name[:-3], os.path.join(d, name))
    m = importlib.util.module_from_spec(spec)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    spec.loader.exec_module(m); sys.stdout = o
    return m

wm = load("run_n5_weyl_module.py")
N, NP, PAIRS, PIDX, SPAIRS, BASIS, GENS = (wm.N, wm.NP, wm.PAIRS, wm.PIDX,
                                           wm.SPAIRS, wm.BASIS, wm.GENS)
print(f"Weyl_5 rebuilt from run_n5_weyl_module: dim {len(BASIS)}")

TEN = [wm.sym2_to_R({SPAIRS[k]: c for k, c in enumerate(b) if c}) for b in BASIS]

def zero4():
    return [[[[F(0)]*N for _ in range(N)] for _ in range(N)] for _ in range(N)]

def comb(cs):
    R = zero4()
    for c, T in zip(cs, TEN):
        if not c: continue
        for i in range(N):
            for j in range(N):
                for k in range(N):
                    for l in range(N):
                        if T[i][j][k][l]: R[i][j][k][l] += c*T[i][j][k][l]
    return R

def op10(R):
    """the Lambda^2 operator A_{(ij),(kl)} = R_ijkl in the ORTHONORMAL PAIRS basis."""
    return [[R[i][j][k][l] for (k, l) in PAIRS] for (i, j) in PAIRS]

def q_tensor(R):
    return sum(R[i][j][k][l]**2 for i in range(N) for j in range(N)
               for k in range(N) for l in range(N))

def trM3_tensor(R):
    """tr(M^3) with M_{(ab),(cd)} = R_abcd over ALL ordered index pairs (25x25)."""
    # contract in two steps to stay cheap
    P = [[[[F(0)]*N for _ in range(N)] for _ in range(N)] for _ in range(N)]
    for a in range(N):
        for b in range(N):
            for e in range(N):
                for f in range(N):
                    s = F(0)
                    for c in range(N):
                        for dd in range(N):
                            if R[a][b][c][dd] and R[c][dd][e][f]:
                                s += R[a][b][c][dd]*R[c][dd][e][f]
                    P[a][b][e][f] = s
    return sum(P[a][b][e][f]*R[e][f][a][b] for a in range(N) for b in range(N)
               for e in range(N) for f in range(N))

def trA2(A): return sum(A[i][k]*A[k][i] for i in range(NP) for k in range(NP))
def trA3(A): return sum(A[i][k]*A[k][l]*A[l][i]
                        for i in range(NP) for k in range(NP) for l in range(NP))

def F5_built(R):   return F(3,2)*q_tensor(R)**3 - 9*trM3_tensor(R)**2
def F5_record(A):  return F(3,2)*trA2(A)**3 - 9*trA3(A)**2

print("\n=== CLAIM 1: the two conventions, on random exact points of Weyl_5 ===")
rnd = random.Random(183)
worst = True
for t in range(6):
    cs = [F(rnd.randint(-4, 4)) for _ in range(35)]
    R = comb(cs); A = op10(R)
    q, m3, a2, a3 = q_tensor(R), trM3_tensor(R), trA2(A), trA3(A)
    ok2 = (q == 4*a2); ok3 = (m3 == 8*a3)
    fb, fr = F5_built(R), F5_record(A)
    ok6 = (fb == 64*fr)
    worst &= ok2 and ok3 and ok6
    print(f"  pt{t}: q = 4*tr(A^2): {ok2} | trM3 = 8*tr(A^3): {ok3} | "
          f"F5_built = 64*F5_record: {ok6}")
print(f"  ALL: {worst}")

print("\n=== CLAIM 1: the extremiser W_0 ===")
def formvec(terms):
    v = [F(0)]*NP
    for (i, j), c in terms:
        for k, cc in wm.wedge(i, j).items(): v[k] += F(c)*cc
    return v
W1 = formvec([((0,1),1), ((2,3),1)])
W2 = formvec([((0,2),1), ((1,3),-1)])
W3 = formvec([((0,3),1), ((1,2),1)])
S = [[F(0)]*NP for _ in range(NP)]
for w, s in ((W1,2), (W2,-1), (W3,-1)):
    nrm = sum(x*x for x in w)
    for a in range(NP):
        for b in range(NP):
            if w[a] and w[b]: S[a][b] += F(s)*w[a]*w[b]/nrm
# S = sqrt6 * W_0 as an operator; lift to the rank-4 tensor
RS = zero4()
for ai, (i, j) in enumerate(PAIRS):
    for bi, (k, l) in enumerate(PAIRS):
        v = S[ai][bi]
        if not v: continue
        for si, (p, q_) in ((1,(i,j)), (-1,(j,i))):
            for sj, (r, s_) in ((1,(k,l)), (-1,(l,k))):
                RS[p][q_][r][s_] += si*sj*v
# sanity: RS is in Weyl_5 (Bianchi + Ricci)
bi_ok = all(RS[i][j][k][l] + RS[i][k][l][j] + RS[i][l][j][k] == 0
            for i in range(N) for j in range(N) for k in range(N) for l in range(N))
ric_ok = all(sum(RS[a][i][a][j] for a in range(N)) == 0
             for i in range(N) for j in range(N))
print(f"  sqrt6*W_0 built as a rank-4 tensor; Bianchi {bi_ok}, Ricci-flat {ric_ok}")
a2S, a3S = trA2(S), trA3(S)
print(f"  operator route : tr(A^2) = {a2S} -> |W_0|^2 = {F(a2S,6)}, "
      f"tr(A^3) = {a3S} -> tr(W_0^3)^2 = {F(a3S,6)**2/6}")
qS, m3S = q_tensor(RS), trM3_tensor(RS)
print(f"  tensor route   : q = {qS} (= 4*tr(A^2): {qS==4*a2S}), "
      f"trM3 = {m3S} (= 8*tr(A^3): {m3S==8*a3S})")
print(f"  F5_built(sqrt6 W_0)  = {F5_built(RS)}   VANISHES: {F5_built(RS)==0}")
print(f"  F5_record(sqrt6 W_0) = {F5_record(S)}   VANISHES: {F5_record(S)==0}")
print(f"  and F5_built = 64 * F5_record here too: {F5_built(RS)==64*F5_record(S)}")

print("\n=== CLAIM 3: the Gram, exactly ===")
def tdot(Aa, Bb):
    return sum(Aa[i][j][k][l]*Bb[i][j][k][l]
               for i in range(N) for j in range(N) for k in range(N) for l in range(N))
Gm = [[F(0)]*35 for _ in range(35)]
for i in range(35):
    for j in range(i, 35):
        Gm[i][j] = Gm[j][i] = tdot(TEN[i], TEN[j])
OPS = [op10(T) for T in TEN]
Gop = [[sum(OPS[i][a][b]*OPS[j][a][b] for a in range(NP) for b in range(NP))
        for j in range(35)] for i in range(35)]
print(f"  tensor Gram = 4 * (Lambda^2 operator Gram), entrywise: "
      f"{all(Gm[i][j] == 4*Gop[i][j] for i in range(35) for j in range(35))}")

print("\n=== CLAIM 3: skewness, COMPLETELY (A^T G + G A = 0), not 3 samples ===")
allskew = True
for gi, A in enumerate(GENS):
    Mx = [[sum(A[k][i]*Gm[k][j] for k in range(35) if A[k][i])
           + sum(Gm[i][k]*A[k][j] for k in range(35) if A[k][j])
           for j in range(35)] for i in range(35)]
    z = all(Mx[i][j] == 0 for i in range(35) for j in range(35))
    allskew &= z
    if not z: print(f"  generator {gi} ({PAIRS[gi]}) FAILS skewness")
print(f"  all {len(GENS)} generators exactly skew for the tensor Gram: {allskew}")

allskew_op = True
for gi, A in enumerate(GENS):
    Mx = [[sum(A[k][i]*Gop[k][j] for k in range(35) if A[k][i])
           + sum(Gop[i][k]*A[k][j] for k in range(35) if A[k][j])
           for j in range(35)] for i in range(35)]
    allskew_op &= all(Mx[i][j] == 0 for i in range(35) for j in range(35))
print(f"  ... and for the operator Gram (a positive multiple): {allskew_op}")

print("\n=== CLAIM 3: is the invariant form UNIQUE up to scale? ===")
# Weyl_5 is irreducible for so(5) (hw (2,2), dim 35), so the space of invariant
# symmetric forms is 1-dimensional.  Verify directly: solve A^T X + X A = 0 over
# all generators, X symmetric, and report the dimension of the solution space.
idx = [(a, b) for a in range(35) for b in range(a, 35)]
pos = {(a,b): k for k, (a,b) in enumerate(idx)}
pos.update({(b,a): k for (a,b), k in list(pos.items())})
rows = []
for A in GENS:
    for i in range(35):
        for j in range(i, 35):
            row = [F(0)]*len(idx)
            for k in range(35):
                if A[k][i]: row[pos[(k,j)]] += A[k][i]
                if A[k][j]: row[pos[(i,k)]] += A[k][j]
            if any(row): rows.append(row)
# rank over Q via a prime-free exact elimination on a random projection is slow;
# do exact elimination directly (rows are sparse).
def rank_exact(rows, n):
    M = [r[:] for r in rows]; r = 0
    for c in range(n):
        p = next((k for k in range(r, len(M)) if M[k][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        inv = F(1)/M[r][c]; M[r] = [x*inv for x in M[r]]
        for k in range(r+1, len(M)):
            if M[k][c]:
                f = M[k][c]; M[k] = [x - f*y for x, y in zip(M[k], M[r])]
        r += 1
        if r == len(M): break
    return r
rk = rank_exact(rows, len(idx))
print(f"  symmetric invariant forms: dim = {len(idx)} - {rk} = {len(idx)-rk} "
      f"(1 means unique up to scale)")
