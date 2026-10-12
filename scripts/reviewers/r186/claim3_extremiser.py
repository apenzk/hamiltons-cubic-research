"""Claim 3, r186: is the UNDOUBLED vector really W_0, and is it the object whose
spectrum and tr(W_0^3)=1/sqrt6 the script prints?

Everything here is built from scratch in Fraction arithmetic.  The only thing
imported from the record is run_n5_weyl_module (the coordinate map under audit)
and, for the independent route, the Fubini-Study curvature FORMULA re-typed from
scripts/cp2_tensor.py.
"""
from fractions import Fraction as F
from itertools import product, combinations
import importlib.util, sys, os, random

N = 5
PAIRS = list(combinations(range(N), 2))
PIDX = {p: k for k, p in enumerate(PAIRS)}
NP = len(PAIRS)

def zeros4(n=N):
    return [[[[F(0)]*n for _ in range(n)] for _ in range(n)] for _ in range(n)]

# ---------------- route A: the record's definition, as a 4-tensor ----------
# w1 = e0^e1 + e2^e3, w2 = e0^e2 - e1^e3, w3 = e0^e3 + e1^e2, each |w|^2 = 2
# (in COMPONENTS, sum_{ij} w_ij^2 = 4, i.e. twice the i<j sum).
# S = sqrt6 W_0 = sum_s (s/2) w^s (x) w^s  as a form on Lambda^2 with the i<j
# convention, i.e. R_ijkl = sum_s (s/2) w^s_ij w^s_kl for ALL i,j,k,l.
def formmat(terms):
    w = [[F(0)]*N for _ in range(N)]
    for (i, j), c in terms:
        w[i][j] += F(c); w[j][i] -= F(c)
    return w

W1 = formmat([((0,1),1), ((2,3),1)])
W2 = formmat([((0,2),1), ((1,3),-1)])
W3 = formmat([((0,3),1), ((1,2),1)])

RA = zeros4()
for w, s in ((W1,2), (W2,-1), (W3,-1)):
    nrm = sum(w[i][j]**2 for i in range(N) for j in range(N)) // 2   # the i<j norm, = 2
    for i, j, k, l in product(range(N), repeat=4):
        if w[i][j] and w[k][l]:
            RA[i][j][k][l] += F(s, 1)*w[i][j]*w[k][l]/nrm

# ---------------- symmetry / Bianchi / Ricci, straight from the definitions ---
def checks(R, name):
    anti12 = all(R[i][j][k][l] == -R[j][i][k][l] for i,j,k,l in product(range(N), repeat=4))
    anti34 = all(R[i][j][k][l] == -R[i][j][l][k] for i,j,k,l in product(range(N), repeat=4))
    pairsym = all(R[i][j][k][l] == R[k][l][i][j] for i,j,k,l in product(range(N), repeat=4))
    bianchi = max(abs(R[i][j][k][l] + R[i][k][l][j] + R[i][l][j][k])
                  for i,j,k,l in product(range(N), repeat=4))
    ric = max(abs(sum(R[m][i][m][j] for m in range(N)))
              for i in range(N) for j in range(N))
    print(f"  {name}: antisym(12)={anti12} antisym(34)={anti34} pair-sym={pairsym} "
          f"|Bianchi|max={bianchi} |Ric|max={ric}")
    return anti12 and anti34 and pairsym and bianchi == 0 and ric == 0

print("=== route A: sqrt6*W_0 built as a rank-4 tensor from the Lambda^+ definition ===")
okA = checks(RA, "R_A")

def op_of(R):
    """the Lambda^2 operator A_{(ij),(kl)} = R_ijkl on the i<j basis."""
    return [[R[i][j][k][l] for (k, l) in PAIRS] for (i, j) in PAIRS]

def traces(A):
    n = len(A)
    t1 = sum(A[i][i] for i in range(n))
    t2 = sum(A[i][k]*A[k][i] for i in range(n) for k in range(n))
    t3 = sum(A[i][k]*A[k][l]*A[l][i] for i in range(n) for k in range(n) for l in range(n))
    return t1, t2, t3

A_A = op_of(RA)
t1, t2, t3 = traces(A_A)
print(f"  tr(A)={t1}  tr(A^2)={t2}  tr(A^3)={t3}")
print(f"  => |W_0|^2_Lambda2 = {F(t2,6)}, tr(W_0^3) = {F(t3,6)}/sqrt6")

import numpy as np
ev = np.linalg.eigvalsh(np.array([[float(x) for x in r] for r in A_A]))
print(f"  spectrum (numeric, of sqrt6 W_0): {np.round(sorted(ev, reverse=True), 12)}")

# ---------------- route B: Fubini-Study curvature, Weyl part, independently ----
# R_ijkl = a(d_ik d_jl - d_il d_jk) + a(J_ik J_jl - J_il J_jk) + 2a J_ij J_kl
# with J the constant complex structure on span(e0..e3).  This is the CONSTANT
# HOLOMORPHIC SECTIONAL CURVATURE tensor -- CP^2's curvature, and it shares no
# code with route A.  Take its Weyl part in dimension 4, then pad to R^5.
print("\n=== route B: Fubini-Study curvature -> Weyl part, in dimension 4 ===")
n4 = 4
J = [[F(0)]*n4 for _ in range(n4)]
J[0][1] = F(-1); J[1][0] = F(1); J[2][3] = F(-1); J[3][2] = F(1)   # J[i][k] = <J e_i, e_k>
d = [[F(1 if i == j else 0) for j in range(n4)] for i in range(n4)]
RB = [[[[F(0)]*n4 for _ in range(n4)] for _ in range(n4)] for _ in range(n4)]
for i, j, k, l in product(range(n4), repeat=4):
    RB[i][j][k][l] = (d[i][k]*d[j][l] - d[i][l]*d[j][k]
                      + J[i][k]*J[j][l] - J[i][l]*J[j][k]
                      + 2*J[i][j]*J[k][l])
Ric = [[sum(RB[m][i][m][j] for m in range(n4)) for j in range(n4)] for i in range(n4)]
sc = sum(Ric[i][i] for i in range(n4))
print(f"  Ric = {sc/n4} * g (Einstein): "
      f"{all(Ric[i][j] == (sc/n4 if i == j else 0) for i in range(n4) for j in range(n4))}"
      f"   scalar = {sc}")
# Weyl = R - (1/(n-2))(Ric o g) + (sc/((n-1)(n-2))/2)(g o g) with the Kulkarni-Nomizu
def kn(h, g):
    return [[[[h[i][k]*g[j][l] + h[j][l]*g[i][k] - h[i][l]*g[j][k] - h[j][k]*g[i][l]
               for l in range(n4)] for k in range(n4)] for j in range(n4)] for i in range(n4)]
KN1 = kn(Ric, d); KN2 = kn(d, d)
WB = [[[[RB[i][j][k][l] - F(1, n4-2)*KN1[i][j][k][l]
         + F(sc, 2*(n4-1)*(n4-2))*KN2[i][j][k][l]
         for l in range(n4)] for k in range(n4)] for j in range(n4)] for i in range(n4)]
WB5 = zeros4()
for i, j, k, l in product(range(n4), repeat=4):
    WB5[i][j][k][l] = WB[i][j][k][l]
okB = checks(WB5, "Weyl(FS) padded")

# proportionality to route A
ratios = {RA[i][j][k][l]/WB5[i][j][k][l] for i,j,k,l in product(range(N), repeat=4)
          if WB5[i][j][k][l]}
zeros_match = all((RA[i][j][k][l] == 0) == (WB5[i][j][k][l] == 0)
                  for i,j,k,l in product(range(N), repeat=4))
print(f"  supports coincide: {zeros_match}   ratio R_A / Weyl(FS): {ratios}")
c = ratios.pop() if len(ratios) == 1 else None
print(f"  R_A = {c} * Weyl(FS): {c is not None}  (positive multiple: {c is not None and c > 0})")

# ---------------- the coordinate map under audit ----------------------------
print("\n=== the record's coordinate map: does vec[k]=S[a][b] mean R_A? ===")
dpath = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
spec = importlib.util.spec_from_file_location(
    "wm", os.path.join(dpath, "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(spec)
out = sys.stdout; sys.stdout = open(os.devnull, "w")
spec.loader.exec_module(wm); sys.stdout = out

S = A_A                       # the same 10x10 the record calls S
vec_undoubled = {(a, b): S[a][b] for (a, b) in wm.SPAIRS}
vec_doubled = {(a, b): (2*S[a][b] if a != b else S[a][a]) for (a, b) in wm.SPAIRS}

def tensor_from(v):
    R = wm.sym2_to_R(v)
    return [[[[R[i][j][k][l] for l in range(N)] for k in range(N)]
             for j in range(N)] for i in range(N)]

TU = tensor_from(vec_undoubled)
TD = tensor_from(vec_doubled)
print(f"  sym2_to_R(undoubled) == R_A entrywise: "
      f"{all(TU[i][j][k][l] == RA[i][j][k][l] for i,j,k,l in product(range(N), repeat=4))}")
print(f"  sym2_to_R(doubled)  == R_A entrywise: "
      f"{all(TD[i][j][k][l] == RA[i][j][k][l] for i,j,k,l in product(range(N), repeat=4))}")
AD = op_of(TD)
diagS = [[S[i][j] if i == j else F(0) for j in range(NP)] for i in range(NP)]
print(f"  operator of the doubled vector == 2S - diag(S): "
      f"{all(AD[i][j] == 2*S[i][j] - diagS[i][j] for i in range(NP) for j in range(NP))}")
print(f"  traces of the doubled object: {traces(AD)}   (route A: {traces(A_A)})")

# ---------------- does the membership test have teeth? ----------------------
print("\n=== teeth: the Bianchi+Ricci row system ===")
rows = wm.bianchi_rows() + wm.ricci_rows()
NS = len(wm.SPAIRS)
def resid(v):
    x = [v[q] for q in wm.SPAIRS]
    return [sum(r[i]*x[i] for i in range(NS)) for r in rows]
def rank(M):
    M = [r[:] for r in M]; r = 0
    for c in range(NS):
        p = next((k for k in range(r, len(M)) if M[k][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        inv = F(1)/M[r][c]; M[r] = [x*inv for x in M[r]]
        for k in range(len(M)):
            if k != r and M[k][c]:
                f = M[k][c]; M[k] = [x - f*y for x, y in zip(M[k], M[r])]
        r += 1
    return r
rk = rank(rows)
print(f"  {len(rows)} rows of rank {rk} on a {NS}-dim space -> solution space {NS-rk} (35: {NS-rk==35})")
print(f"  undoubled residual all zero: {not any(resid(vec_undoubled))}")
print(f"  doubled   residual all zero: {not any(resid(vec_doubled))}")
rnd = random.Random(186)
fails = 0
for _ in range(20):
    v = {q: F(rnd.randint(-9, 9)) for q in wm.SPAIRS}
    nz = sum(1 for x in resid(v) if x)
    fails += (nz > 0)
print(f"  20 random symmetric coordinate vectors rejected: {fails}/20")
# structured near-misses
tests = {}
# (a) a wrong eigenvalue assignment on the same Lambda^+ frame
RW = zeros4()
for w, s in ((W1,1), (W2,1), (W3,-2)):
    for i,j,k,l in product(range(N), repeat=4):
        if w[i][j] and w[k][l]: RW[i][j][k][l] += F(s,2)*w[i][j]*w[k][l]
tests["Lambda^+ frame, eigenvalues (1,1,-2)"] = op_of(RW)
# (b) an ANTI-self-dual frame with (2,-1,-1)
V1 = formmat([((0,1),1), ((2,3),-1)])
V2 = formmat([((0,2),1), ((1,3),1)])
V3 = formmat([((0,3),1), ((1,2),-1)])
RM = zeros4()
for w, s in ((V1,2), (V2,-1), (V3,-1)):
    for i,j,k,l in product(range(N), repeat=4):
        if w[i][j] and w[k][l]: RM[i][j][k][l] += F(s,2)*w[i][j]*w[k][l]
tests["Lambda^- frame, eigenvalues (2,-1,-1)"] = op_of(RM)
# (c) S with one off-diagonal entry perturbed
Sp = [r[:] for r in S]; Sp[0][5] += F(1); Sp[5][0] += F(1)
tests["S with one off-diagonal bumped by 1"] = Sp
# (d) S with the (0,1)x(0,1) diagonal entry bumped
Sq = [r[:] for r in S]; Sq[0][0] += F(1)
tests["S with one diagonal entry bumped by 1"] = Sq
# (e) transpose-free garbage: S conjugated by a coordinate swap of Lambda^2 basis
perm = list(range(NP)); perm[0], perm[1] = perm[1], perm[0]
Sr = [[S[perm[i]][perm[j]] for j in range(NP)] for i in range(NP)]
tests["S with two Lambda^2 basis vectors swapped"] = Sr
for nm, M in tests.items():
    v = {(a, b): M[a][b] for (a, b) in wm.SPAIRS}
    nz = sum(1 for x in resid(v) if x)
    t = traces(M)
    print(f"  {nm}: rows violated {nz}/{len(rows)}, tr^2={t[1]} tr^3={t[2]}")
