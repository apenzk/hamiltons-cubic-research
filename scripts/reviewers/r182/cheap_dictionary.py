"""Claim 5: a dictionary route that never builds a copy.

CLAIM UNDER TEST.  Let M be a unitary rep of a compact G, V_lam an irrep of
dimension d, and {phi_1..phi_m} a basis of Hom_G(V_lam, M).  Fix v in V_lam.
Put u_i = phi_i(v) -- for a highest weight v these are exactly the highest
weight vectors the record already has.  For x in M write P_lam x = sum_i
phi_i(y_i), y_i in V_lam.  The record's dictionary entries are

    B_ij(x) = <y_i, y_j>_{V_lam}.

Define instead, with p_i(x) := <x, u_i> a single linear functional built from
u_i alone,

    A_ij(x) = int_G p_i(gx) conj(p_j(gx)) dg      (Reynolds average).

THE IDENTITY:   A = (1/(d |v|^2)) N B N^dagger,   N_ij = <u_i, u_j>.

N is the Gram matrix of the highest weight vectors, invertible, and the map
B -> A is a CONGRUENCE, so A is a legitimate dictionary in its own right:
sum_ij G_ij B_ij = sum_ij G'_ij A_ij with G' = d|v|^2 N^dagger^{-1} G N^{-1},
and G' >= 0 iff G >= 0.  Nothing in A's definition mentions a copy.

Test 1: octahedral rotation group on Sym^3(R^3), exact over Q, multiplicity 2.
Test 2: a complex case, to pin the conjugation convention.
"""
from fractions import Fraction as F
from itertools import product
import random

# ---------------- Test 1: rotation group of the cube on Sym^3(R^3) ----------
def rot_group():
    """the 24 rotations of the cube: signed permutation matrices, det +1."""
    out = []
    for perm in [(0,1,2),(0,2,1),(1,0,2),(1,2,0),(2,0,1),(2,1,0)]:
        for s in product((1,-1), repeat=3):
            M = [[0]*3 for _ in range(3)]
            for i in range(3): M[i][perm[i]] = s[i]
            d = (M[0][0]*(M[1][1]*M[2][2]-M[1][2]*M[2][1])
                 - M[0][1]*(M[1][0]*M[2][2]-M[1][2]*M[2][0])
                 + M[0][2]*(M[1][0]*M[2][1]-M[1][1]*M[2][0]))
            if d == 1: out.append(M)
    return out

MON = [a for a in product(range(4), repeat=3) if sum(a) == 3]     # 10 monomials
MI  = {a: k for k, a in enumerate(MON)}
def fact(n): return 1 if n <= 1 else n*fact(n-1)
def multi(a): return fact(3)//(fact(a[0])*fact(a[1])*fact(a[2]))
# Bombieri pairing: <z^a, z^b> = delta * a!/3!, so <(w.z)^3, p> = p(w).
WT = [F(fact(a[0])*fact(a[1])*fact(a[2]), fact(3)) for a in MON]
def ip_M(p, q): return sum(WT[k]*p[k]*q[k] for k in range(10))

def act_poly(g):
    """matrix of p -> p(g^T z) on the monomial basis (g orthogonal, so this is
    the same as p -> p(g^{-1} z), and it is unitary for the Bombieri pairing)."""
    cols = []
    for a in MON:
        # substitute z_i -> sum_j g[j][i] z_j  (i.e. (g^T z)_i)
        poly = {(0,0,0): F(1)}
        for i in range(3):
            for _ in range(a[i]):
                new = {}
                for mono, c in poly.items():
                    for j in range(3):
                        if g[j][i]:
                            m2 = list(mono); m2[j] += 1; m2 = tuple(m2)
                            new[m2] = new.get(m2, F(0)) + c*g[j][i]
                poly = new
        col = [F(0)]*10
        for mono, c in poly.items(): col[MI[mono]] = c
        cols.append(col)
    return [[cols[j][i] for j in range(10)] for i in range(10)]

def cube3(w):
    """the vector W^3 in Sym^3, i.e. the polynomial (w.z)^3."""
    out = [F(0)]*10
    for k, a in enumerate(MON):
        out[k] = F(multi(a)) * w[0]**a[0] * w[1]**a[1] * w[2]**a[2]
    return out

def nullspace(rows, n):
    M = [[F(x) for x in r] for r in rows]; piv = []; r = 0
    for c in range(n):
        p = next((k for k in range(r, len(M)) if M[k][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        inv = F(1)/M[r][c]; M[r] = [x*inv for x in M[r]]
        for k in range(len(M)):
            if k != r and M[k][c]:
                f = M[k][c]; M[k] = [x - f*y for x, y in zip(M[k], M[r])]
        piv.append(c); r += 1
    out = []
    for f in [c for c in range(n) if c not in piv]:
        v = [F(0)]*n; v[f] = F(1)
        for i, c in enumerate(piv): v[c] = -M[i][f]
        out.append(v)
    return out

def solve(A, b):
    """least-length exact solve of A x = b, A full column rank."""
    m, n = len(A), len(A[0])
    M = [[F(A[i][j]) for j in range(n)] + [F(b[i])] for i in range(m)]
    piv, r = [], 0
    for c in range(n):
        p = next((k for k in range(r, m) if M[k][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        inv = F(1)/M[r][c]; M[r] = [x*inv for x in M[r]]
        for k in range(m):
            if k != r and M[k][c]:
                f = M[k][c]; M[k] = [x - f*y for x, y in zip(M[k], M[r])]
        piv.append(c); r += 1
    for k in range(len(piv), m):
        if M[k][n]: return None
    x = [F(0)]*n
    for i, c in enumerate(piv): x[c] = M[i][n]
    return x

print("=== Test 1: octahedral group on Sym^3(R^3), lam = the standard 3-dim ===")
Gp = rot_group()
print(f"  group order {len(Gp)} (expect 24)")
RM = [act_poly(g) for g in Gp]
# Hom_G(V, M) with V = R^3 the defining rep: Phi g = rho(g) Phi, 10x3 unknowns
rows = []
for g, R in zip(Gp, RM):
    for a in range(10):
        for b in range(3):
            r = [F(0)]*30
            for c in range(3): r[a*3+c] += g[c][b]           # (Phi g)_{ab}
            for c in range(10): r[c*3+b] -= R[a][c]          # (rho(g) Phi)_{ab}
            rows.append(r)
NS = nullspace(rows, 30)
# double-check equivariance for the whole group
def as_Phi(v): return [[v[a*3+b] for b in range(3)] for a in range(10)]
PHI = [as_Phi(v) for v in NS]
ok = True
for g, R in zip(Gp, RM):
    for P in PHI:
        L = [[sum(P[a][c]*g[c][b] for c in range(3)) for b in range(3)] for a in range(10)]
        Rt = [[sum(R[a][c]*P[c][b] for c in range(10)) for b in range(3)] for a in range(10)]
        if L != Rt: ok = False
print(f"  dim Hom_G(V, Sym^3 R^3) = {len(PHI)} (expect 2 -- V sits in H_1 and in H_3)")
print(f"  every basis map is equivariant for all 24 elements: {ok}")

d_lam = 3
v = [F(1), F(0), F(0)]                       # the fixed vector of V_lam
nv2 = sum(c*c for c in v)
U = [[sum(P[a][b]*v[b] for b in range(3)) for a in range(10)] for P in PHI]
N = [[ip_M(U[i], U[j]) for j in range(2)] for i in range(2)]
print(f"  N = <u_i,u_j> = {[[str(x) for x in r] for r in N]}")

# columns Phi_i(e_k) span the isotypic component
COLS = [[P[a][k] for a in range(10)] for P in PHI for k in range(3)]
A6 = [[COLS[j][a] for j in range(6)] for a in range(10)]

random.seed(182); bad = 0
for trial in range(6):
    w = [F(random.randint(-4, 4)) for _ in range(3)]
    x = cube3(w)
    # project x onto the isotypic component (orthogonal wrt the Bombieri pairing)
    Gr = [[ip_M(COLS[i], COLS[j]) for j in range(6)] for i in range(6)]
    rhs = [ip_M(COLS[i], x) for i in range(6)]
    coef = solve(Gr, rhs)
    y = [coef[0:3], coef[3:6]]
    B = [[sum(y[i][k]*y[j][k] for k in range(3)) for j in range(2)] for i in range(2)]
    # A_ij by exact averaging over the group: p_i(gW) = <(gW)^3, u_i>
    A = [[F(0)]*2 for _ in range(2)]
    for g in Gp:
        gw = [sum(g[a][b]*w[b] for b in range(3)) for a in range(3)]
        gx = cube3(gw)
        p = [ip_M(gx, U[i]) for i in range(2)]
        for i in range(2):
            for j in range(2): A[i][j] += p[i]*p[j]
    A = [[A[i][j]/len(Gp) for j in range(2)] for i in range(2)]
    NBN = [[sum(N[k][i]*B[k][l]*N[l][j] for k in range(2) for l in range(2))
            for j in range(2)] for i in range(2)]
    pred = [[NBN[i][j]/(d_lam*nv2) for j in range(2)] for i in range(2)]
    match = (A == pred)
    if not match: bad += 1
    print(f"  W={[str(c) for c in w]}  A == N B N^T /(d|v|^2): {match}")
print(f"  identity holds at every sample: {bad == 0}")

# ---- same test in a MIXED basis of Hom, so N is not diagonal and the ----
# ---- congruence has to do real work -------------------------------------
print("\n=== Test 1b: a mixed basis of Hom_G, N no longer diagonal ===")
MIX = [[F(1), F(2)], [F(1), F(-1)]]
PHI2 = [[[sum(MIX[i][k]*PHI[k][a][b] for k in range(2)) for b in range(3)]
         for a in range(10)] for i in range(2)]
U2 = [[sum(P[a][b]*v[b] for b in range(3)) for a in range(10)] for P in PHI2]
N2 = [[ip_M(U2[i], U2[j]) for j in range(2)] for i in range(2)]
print(f"  N = {[[str(x) for x in r] for r in N2]}")
COLS2 = [[P[a][k] for a in range(10)] for P in PHI2 for k in range(3)]
Gr2 = [[ip_M(COLS2[i], COLS2[j]) for j in range(6)] for i in range(6)]
ok2 = trivial = 0
for trial in range(6):
    w = [F(random.randint(-4, 4)) for _ in range(3)]
    x = cube3(w)
    coef = solve(Gr2, [ip_M(COLS2[i], x) for i in range(6)])
    y = [coef[0:3], coef[3:6]]
    B = [[sum(y[i][k]*y[j][k] for k in range(3)) for j in range(2)] for i in range(2)]
    A = [[F(0)]*2 for _ in range(2)]
    for g in Gp:
        gx = cube3([sum(g[a][b]*w[b] for b in range(3)) for a in range(3)])
        p = [ip_M(gx, U2[i]) for i in range(2)]
        for i in range(2):
            for j in range(2): A[i][j] += p[i]*p[j]
    A = [[A[i][j]/len(Gp) for j in range(2)] for i in range(2)]
    pred = [[sum(N2[k][i]*B[k][l]*N2[l][j] for k in range(2) for l in range(2))
             / (d_lam*nv2) for j in range(2)] for i in range(2)]
    ok2 += (A == pred); trivial += (A == B)
print(f"  A == N B N^T/(d|v|^2) at all 6 samples: {ok2 == 6}")
print(f"  and the congruence is NOT the identity map (A == B never): {trivial == 0}")

# ---------------- Test 2: a complex case, to pin the conjugation ------------
print("\n=== Test 2: complex rep, Z/7 on C^4, lam a nontrivial character ===")
import cmath
n_g, dimM = 7, 4
z = cmath.exp(2j*cmath.pi/n_g)
chars = [1, 1, 2, 3]                 # M = chi^1 + chi^1 + chi^2 + chi^3
rho = lambda k: [[z**(k*chars[a]) if a == b else 0 for b in range(dimM)]
                 for a in range(dimM)]
# lam = chi^1, d = 1, multiplicity 2 (coordinates 0 and 1); v = 1
COPY = [0, 1]
Phi = [[1 if a == c else 0 for a in range(dimM)] for c in COPY]   # V_lam -> M
# mix them so N is not diagonal
MIXC = [[1, 2+1j], [1j, -1]]
Uc = [[sum(MIXC[i][k]*Phi[k][a] for k in range(2)) for a in range(dimM)]
      for i in range(2)]
ipc = lambda p, q: sum(p[a]*q[a].conjugate() for a in range(dimM))
Nc = [[ipc(Uc[i], Uc[j]) for j in range(2)] for i in range(2)]
worst = 0.0
random.seed(7)
for trial in range(5):
    x = [complex(random.randint(-3, 3), random.randint(-3, 3)) for _ in range(dimM)]
    # y_i: P_lam x = sum_i Phi_i(y_i);  Phi_i = column MIXC applied, so solve 2x2
    Mx = [[MIXC[i][k] for i in range(2)] for k in range(2)]   # column i is Phi_i(v)
    det = Mx[0][0]*Mx[1][1] - Mx[0][1]*Mx[1][0]
    rhs = [x[0], x[1]]
    y = [(Mx[1][1]*rhs[0] - Mx[0][1]*rhs[1])/det,
         (-Mx[1][0]*rhs[0] + Mx[0][0]*rhs[1])/det]
    B = [[y[i]*y[j].conjugate() for j in range(2)] for i in range(2)]
    A = [[0j]*2 for _ in range(2)]
    for k in range(n_g):
        R = rho(k)
        gx = [sum(R[a][b]*x[b] for b in range(dimM)) for a in range(dimM)]
        p = [ipc(gx, Uc[i]) for i in range(2)]
        for i in range(2):
            for j in range(2): A[i][j] += p[i]*p[j].conjugate()
    A = [[A[i][j]/n_g for j in range(2)] for i in range(2)]
    pred = [[sum(Nc[k][i]*B[k][l]*Nc[l][j].conjugate() for k in range(2)
                 for l in range(2)) for j in range(2)] for i in range(2)]
    worst = max(worst, max(abs(A[i][j]-pred[i][j]) for i in range(2) for j in range(2)))
print(f"  max |A - N^T B conj(N)| over 5 random x, d=1, |v|=1: {worst:.3e}")
print("  (convention: A = N^T B conj(N) / (d |v|^2), N Hermitian -- a congruence)")
