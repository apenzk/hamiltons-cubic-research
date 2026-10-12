"""Screen: which of Phi's six slot permutations hold, and where the rotation's hypothesis may sit.

phiTri(A,B,C) = -(1/4) sum_{p,q} inner2( B[A phi_p, C phi_q], [phi_p, phi_q] ) at n = 4,
exact rational arithmetic throughout.

Two questions the record could not answer:
  (a) is there a SECOND easy transposition, which with the proved outer swap would generate S_3
      and make the rotation free?
  (b) does the rotation's self-adjointness have to sit on the first slot?
"""
from fractions import Fraction as F
import itertools
import random

N = 4

def zero():
    return [[F(0)] * N for _ in range(N)]

def phi(i, j):
    M = zero()
    if i != j:
        M[i][j] += F(1)
        M[j][i] -= F(1)
    return M

PHI = [(i, j) for i in range(N) for j in range(N)]
P = {p: phi(*p) for p in PHI}
BASIS = [(i, j) for i in range(N) for j in range(N) if i < j]

def add(A, B):
    return [[A[r][c] + B[r][c] for c in range(N)] for r in range(N)]

def sub(A, B):
    return [[A[r][c] - B[r][c] for c in range(N)] for r in range(N)]

def smul(s, A):
    return [[s * A[r][c] for c in range(N)] for r in range(N)]

def mul(A, B):
    return [[sum(A[r][k] * B[k][c] for k in range(N)) for c in range(N)] for r in range(N)]

def inner2(A, B):
    return F(1, 2) * sum(sum(A[k][c] * B[k][c] for k in range(N)) for c in range(N))

def br(X, Y):
    return sub(mul(X, Y), mul(Y, X))

def phiTri(A, B, C):
    return F(-1, 4) * sum(inner2(B(br(A(P[p]), C(P[q]))), br(P[p], P[q]))
                          for p in PHI for q in PHI)

def from_entries(e):
    def op(X):
        out = zero()
        for a, x in enumerate(BASIS):
            c = sum(e[a][b] * inner2(P[f], X) for b, f in enumerate(BASIS))
            out = add(out, smul(c, P[x]))
        return out
    return op

def random_op(self_adjoint=False):
    e = [[F(random.randint(-3, 3)) for _ in range(len(BASIS))] for _ in range(len(BASIS))]
    if self_adjoint:
        for a in range(len(BASIS)):
            for b in range(a):
                e[a][b] = e[b][a]
    return from_entries(e)

PERMS = list(itertools.permutations([0, 1, 2]))
NAMES = {(0, 1, 2): 'Phi(A;B,C)', (0, 2, 1): 'Phi(A;C,B)', (1, 0, 2): 'Phi(B;A,C)',
         (1, 2, 0): 'Phi(B;C,A)', (2, 0, 1): 'Phi(C;A,B)', (2, 1, 0): 'Phi(C;B,A)'}

random.seed(21)
TRIALS = 8
for self_adjoint in (False, True):
    fails = {p: 0 for p in PERMS}
    for _ in range(TRIALS):
        ops = [random_op(self_adjoint) for _ in range(3)]
        base = phiTri(*ops)
        for p in PERMS:
            if phiTri(ops[p[0]], ops[p[1]], ops[p[2]]) != base:
                fails[p] += 1
    label = "all three self-adjoint" if self_adjoint else "arbitrary"
    print(f"--- {TRIALS} triples, {label} ---")
    for p in PERMS:
        verdict = "agrees" if fails[p] == 0 else f"fails {fails[p]}/{TRIALS}"
        print(f"    {NAMES[p]:<14} {verdict}")

print("--- where the rotation's hypothesis may sit ---")
random.seed(33)
T = 10
only_a = only_bc = 0
for _ in range(T):
    A, B, C = random_op(True), random_op(), random_op()
    if phiTri(A, B, C) != phiTri(B, C, A):
        only_a += 1
    A2, B2, C2 = random_op(), random_op(True), random_op(True)
    if phiTri(A2, B2, C2) != phiTri(B2, C2, A2):
        only_bc += 1
print(f"    A self-adjoint, B and C arbitrary:  fails {only_a}/{T}")
print(f"    A arbitrary, B and C self-adjoint:  fails {only_bc}/{T}")
