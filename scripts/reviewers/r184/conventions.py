"""r184: pin down the rank-4 <-> Lambda^2 conventions and evaluate the built F_5
at the extremiser W_0, exactly over Q (sqrt6 carried symbolically)."""
from fractions import Fraction as F
import importlib.util, sys, os

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
def load(name):
    spec = importlib.util.spec_from_file_location(name[:-3], os.path.join(d, name))
    m = importlib.util.module_from_spec(spec)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    spec.loader.exec_module(m); sys.stdout = o
    return m

wm = load("run_n5_weyl_module.py")
N, NP, PAIRS, SPAIRS = wm.N, wm.NP, wm.PAIRS, wm.SPAIRS

# rebuild S = sqrt6 * W_0 exactly as run_n5_extremiser does
def formvec(terms):
    v = [F(0)]*NP
    for (i, j), c in terms:
        for k, cc in wm.wedge(i, j).items(): v[k] += F(c)*cc
    return v
W1 = formvec([((0,1),1), ((2,3),1)])
W2 = formvec([((0,2),1), ((1,3),-1)])
W3 = formvec([((0,3),1), ((1,2),1)])
S = [[F(0)]*NP for _ in range(NP)]
for w, s in ((W1,2),(W2,-1),(W3,-1)):
    nrm = sum(x*x for x in w)
    for a in range(NP):
        for b in range(NP):
            if w[a] and w[b]: S[a][b] += F(s)*w[a]*w[b]/nrm

def tr2(M): return sum(M[i][k]*M[k][i] for i in range(NP) for k in range(NP))
def tr3(M): return sum(M[i][k]*M[k][l]*M[l][i]
                       for i in range(NP) for k in range(NP) for l in range(NP))

print("== record's Lambda^2 numbers (S = sqrt6 W_0) ==")
print(f"  tr(S^2) = {tr2(S)}   |W_0|^2 = {F(tr2(S),6)}")
print(f"  tr(S^3) = {tr3(S)}   tr(W_0^3) = {F(tr3(S),6)}/sqrt6")

# --- the two candidate rank-4 realisations ---
def to_R(v):   # v: dict (a,b)->coeff on SPAIRS basis
    return wm.sym2_to_R(v)

def R_from_S(M, double):
    v = {}
    for (a,b) in SPAIRS:
        c = M[a][b]*( (2 if double else 1) if a != b else 1)
        if c: v[(a,b)] = c
    return to_R(v)

rows = wm.bianchi_rows() + wm.ricci_rows()
def check_lin(M, double):
    vec = [F(0)]*len(SPAIRS)
    for k,(a,b) in enumerate(SPAIRS):
        vec[k] = M[a][b]*((2 if double else 1) if a != b else 1)
    return not any(sum(r[i]*vec[i] for i in range(len(vec))) for r in rows)

for double in (True, False):
    R = R_from_S(S, double)
    nrm4 = sum(R[i][j][k][l]**2 for i in range(N) for j in range(N)
               for k in range(N) for l in range(N))
    # M = R.reshape(25,25); tr(M^3)
    idx = [(i,j) for i in range(N) for j in range(N)]
    M = [[R[i][j][k][l] for (k,l) in idx] for (i,j) in idx]
    def mm(A,B): return [[sum(A[i][t]*B[t][j] for t in range(len(A))) for j in range(len(A))] for i in range(len(A))]
    M2 = mm(M,M); M3 = mm(M2,M)
    trM3 = sum(M3[i][i] for i in range(len(M)))
    # the 10x10 R10 = [R_ijkl] on a<b, c<d
    R10 = [[R[i][j][k][l] for (k,l) in PAIRS] for (i,j) in PAIRS]
    print(f"\n== rank-4 R from S, doubling off-diagonal = {double} ==")
    print(f"  Bianchi+Ricci satisfied: {check_lin(S, double)}")
    print(f"  |R|^2 (full einsum)   = {nrm4}   vs tr(S^2) = {tr2(S)}  ratio {F(nrm4,tr2(S))}")
    print(f"  tr(M^3), M=25x25 flat = {trM3}   vs tr(S^3) = {tr3(S)}  ratio {F(trM3,tr3(S)) if tr3(S) else 'n/a'}")
    print(f"  R10 == S ?  {R10 == S};  R10 == 2S-diag ? {R10 == [[2*S[a][b] if a!=b else S[a][b] for b in range(NP)] for a in range(NP)]}")
    print(f"  tr(R10^3) = {tr3(R10)}, tr(R10^2) = {tr2(R10)}")
    # built F_5 on this R, with W_0 = R/sqrt6  => degree-6 homogeneous:
    # |W|^6 term: (nrm4/6)^3 ; tr(W^3)^2 term: (trM3/6^{3/2})^2 = trM3^2/216
    f5 = F(3,2)*F(nrm4,6)**3 - 9*F(trM3,1)**2/216
    print(f"  built F_5 at W_0 (scaling by 1/sqrt6) = {f5}")
