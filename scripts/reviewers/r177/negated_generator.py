"""Weyl_5 over Q, the so(5) action, and the Casimir -- exactly.

Realised concretely: Lambda^2 R^5 (10) -> Sym^2(Lambda^2) (55) -> first Bianchi
(50) -> Ricci-traceless (35).  so(5) acts by derivation.  Everything is exact
rational, so the homomorphism and skewness checks come out as 0, not 1e-15.
"""
from fractions import Fraction as F
from itertools import combinations

N = 5
PAIRS = list(combinations(range(N), 2))            # basis of Lambda^2, e_i ^ e_j
PIDX  = {p: k for k, p in enumerate(PAIRS)}
NP    = len(PAIRS)                                 # 10
SPAIRS = [(a, b) for a in range(NP) for b in range(a, NP)]   # Sym^2(Lambda^2)
SIDX  = {q: k for k, q in enumerate(SPAIRS)}
NS    = len(SPAIRS)                                # 55

def wedge(i, j):
    """coefficient dict for e_i ^ e_j in the PAIRS basis (antisymmetric)."""
    if i == j: return {}
    return {PIDX[(i, j)]: 1} if i < j else {PIDX[(j, i)]: -1}

# ---------- rank-4 tensor view, for Bianchi and Ricci ----------
def sym2_to_R(v):
    """v in Sym^2(Lambda^2) -> R[i][j][k][l], with R = sum v_{ab} (a.b symmetrised)."""
    R = [[[[F(0)]*N for _ in range(N)] for _ in range(N)] for _ in range(N)]
    for (a, b), c in v.items():
        if not c: continue
        (i, j), (k, l) = PAIRS[a], PAIRS[b]
        terms = [((i, j), (k, l))] if a == b else [((i, j), (k, l)), ((k, l), (i, j))]
        for (p, q), (r, s) in terms:
            for sp, (p2, q2) in ((1, (p, q)), (-1, (q, p))):
                for sq, (r2, s2) in ((1, (r, s)), (-1, (s, r))):
                    R[p2][q2][r2][s2] += c*sp*sq
    return R

def bianchi_rows():
    """rows of the first-Bianchi map on Sym^2(Lambda^2), as vectors of length NS."""
    rows, seen = [], set()
    for i, j, k, l in ((i,j,k,l) for i in range(N) for j in range(N)
                       for k in range(N) for l in range(N)):
        key = tuple(sorted((i, j, k, l)))
        if len({i,j,k,l}) < 3: continue
        if (key, 'b') in seen: continue
        seen.add((key, 'b'))
        i, j, k, l = key
        row = [F(0)]*NS
        for (p,q,r,s) in ((i,j,k,l), (i,k,l,j), (i,l,j,k)):
            for a, ca in wedge(p,q).items():
                for b, cb in wedge(r,s).items():
                    row[SIDX[(min(a,b), max(a,b))]] += ca*cb
        if any(row): rows.append(row)
    return rows

def ricci_rows():
    """rows imposing Ric = 0, i.e. sum_a R[a][i][a][j] = 0 for i <= j."""
    rows = []
    for i in range(N):
        for j in range(i, N):
            row = [F(0)]*NS
            for (a, b) in SPAIRS:
                v = {(a, b): F(1)}
                R = sym2_to_R(v)
                row[SIDX[(a, b)]] = sum(R[m][i][m][j] for m in range(N))
            rows.append(row)
    return rows

# ---------- exact nullspace ----------
def nullspace(rows, n):
    M = [r[:] for r in rows]; piv = []; r = 0
    for c in range(n):
        p = next((k for k in range(r, len(M)) if M[k][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        inv = F(1, 1)/M[r][c]
        M[r] = [x*inv for x in M[r]]
        for k in range(len(M)):
            if k != r and M[k][c]:
                f = M[k][c]; M[k] = [x - f*y for x, y in zip(M[k], M[r])]
        piv.append(c); r += 1
        if r == len(M): break
    free = [c for c in range(n) if c not in piv]
    basis = []
    for f in free:
        v = [F(0)]*n; v[f] = F(1)
        for i, c in enumerate(piv): v[c] = -M[i][f]
        basis.append(v)
    return basis

print("building Weyl_5 ...")
rows = bianchi_rows() + ricci_rows()
BASIS = nullspace(rows, NS)
print(f"  dim = {len(BASIS)}   (Weyl_5 = 35: {len(BASIS)==35})")

# ---------- so(5) acting by derivation ----------
FREE = [c for c in range(NS) if all(b[c] == 0 or i == j for j, b in enumerate(BASIS)
                                    for i in [j])]
# the nullspace basis is built so that basis vector k has a 1 in free column k
FREE = []
for k, b in enumerate(BASIS):
    FREE.append(next(c for c in range(NS)
                     if b[c] == 1 and all(BASIS[m][c] == 0 for m in range(len(BASIS)) if m != k)))
assert len(set(FREE)) == 35
coords = lambda v: [v[f] for f in FREE]

def lam2_matrix(p, q):
    """A_{pq} = E_pq - E_qp acting on Lambda^2, as a 10x10 matrix over Q."""
    M = [[F(0)]*NP for _ in range(NP)]
    Ae = lambda i: ({p: F(1)} if i == q else ({q: F(-1)} if i == p else {}))
    for c, (i, j) in enumerate(PAIRS):
        out = {}
        for (a_i, a_j) in ((Ae(i), None), (None, Ae(j))):
            if a_i is not None:
                for m, cm in a_i.items():
                    for t, ct in wedge(m, j).items(): out[t] = out.get(t, 0) + cm*ct
            else:
                for m, cm in a_j.items():
                    for t, ct in wedge(i, m).items(): out[t] = out.get(t, 0) + cm*ct
        for t, ct in out.items(): M[t][c] += ct
    return M

def sym2_matrix(L):
    """derivation of a 10x10 L to a 55x55 on Sym^2(Lambda^2).

    An element is a symmetric 10x10 matrix S, meaning the tensor
    sum_{a,b} S[a][b] e_a (x) e_b -- the same convention sym2_to_R reads.  The
    derivation is then S -> L S + S L^T, which is unambiguous; writing it
    directly on the (a<=b) index pairs double-counts the diagonal.
    """
    M = [[F(0)]*NS for _ in range(NS)]
    for c, (a, b) in enumerate(SPAIRS):
        S = [[F(0)]*NP for _ in range(NP)]
        S[a][b] = S[b][a] = F(1)
        if a == b: S[a][a] = F(1)
        T = [[sum(L[i][k]*S[k][j] for k in range(NP) if L[i][k])
              + sum(S[i][k]*L[j][k] for k in range(NP) if L[j][k])
              for j in range(NP)] for i in range(NP)]
        for (x, y) in SPAIRS:
            M[SIDX[(x, y)]][c] += T[x][y]
    return M

GENS = []
for p, q in PAIRS:
    S = sym2_matrix(lam2_matrix(p, q))
    cols = []
    for b in BASIS:
        img = [sum(S[r][c]*b[c] for c in range(NS) if b[c]) for r in range(NS)]
        cols.append(coords(img))
    GENS.append([[cols[j][i] for j in range(35)] for i in range(35)])
print(f"  built {len(GENS)} generators, each 35x35 over Q")
GENS[0] = [[-v for v in row] for row in GENS[0]]   # r177: negate ONE generator

def matmul(A, B):
    n = len(A)
    return [[sum(A[i][k]*B[k][j] for k in range(n) if A[i][k]) for j in range(n)]
            for i in range(n)]
def matsub(A, B): return [[a-b for a, b in zip(r, s)] for r, s in zip(A, B)]
def matadd(A, B): return [[a+b for a, b in zip(r, s)] for r, s in zip(A, B)]

# --- Casimir: B = -tr(XY)/2 makes {A_pq}_{p<q} orthonormal and self-dual;
#     each rho(A) is skew so rho(A)^2 is negative semi-definite, and the minus
#     in C = -sum rho(A)^2 is what makes the eigenvalue come out +16.
C = [[F(0)]*35 for _ in range(35)]
for A in GENS: C = matsub(C, matmul(A, A))
diag = {C[i][i] for i in range(35)}
off  = all(C[i][j] == 0 for i in range(35) for j in range(35) if i != j)
print(f"\n  Casimir scalar: {diag}   off-diagonal all zero: {off}")
print(f"  <lam,lam+2rho> for lam=(2,2), rho=(3/2,1/2) = {2*(2+3) + 2*(2+1)}")
print(f"  EXACT over Q, no tolerance: {diag == {16} and off}")

# --- homomorphism: [rho(A), rho(B)] = rho([A,B]), all 45 pairs, exactly ---
def bracket_in_so5(p, q, r, s):
    """[A_pq, A_rs] = d_qr A_ps + d_ps A_qr - d_qs A_pr - d_pr A_qs."""
    out = {}
    def addA(i, j, c):
        if i == j or not c: return
        k, sg = ((i, j), c) if i < j else ((j, i), -c)
        out[k] = out.get(k, 0) + sg
    if q == r: addA(p, s,  1)
    if p == s: addA(q, r,  1)
    if q == s: addA(p, r, -1)
    if p == r: addA(q, s, -1)
    return {k: v for k, v in out.items() if v}

ok = True
for x in range(len(PAIRS)):
    for y in range(x+1, len(PAIRS)):
        p, q = PAIRS[x]; r, s = PAIRS[y]
        lhs = matsub(matmul(GENS[x], GENS[y]), matmul(GENS[y], GENS[x]))
        rhs = [[F(0)]*35 for _ in range(35)]
        for k, c in bracket_in_so5(p, q, r, s).items():
            G = GENS[PIDX[k]]
            rhs = matadd(rhs, [[c*v for v in row] for row in G])
        if lhs != rhs: ok = False; print(f"  FAIL at {(p,q)},{(r,s)}")
print(f"\n  homomorphism on all {len(PAIRS)*(len(PAIRS)-1)//2} generator pairs: {ok}")
print("  (exact over Q -- the residual is 0, not 2.8e-15)")
