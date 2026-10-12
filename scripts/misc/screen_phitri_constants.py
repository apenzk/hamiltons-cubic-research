"""Screen: the constant in sharpPair2 = -1/2 phiTri(R,R,R), and both of phiTri's symmetries.

Typed BEFORE the two sorrys in PhiTri.lean were written, because a sorry on a false statement is
a debt that can never be paid: the layer once carried one for a day on a closed form whose binder
quantified over every weight while the derivation needed a symmetric one.

Mirrors PhiTri.lean at n = 4, exact rational arithmetic:
  phiTri(A,B,C) = -(1/4) sum_{p,q} inner2( B[A phi_p, C phi_q], [phi_p, phi_q] )
The witness is a genuine Weyl operator, diag(2,-1,-1) on the self-dual part of Lambda^2(R^4).
"""
from fractions import Fraction as F

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

SD = [add(P[(0, 1)], P[(2, 3)]), add(P[(0, 2)], P[(3, 1)]), add(P[(0, 3)], P[(1, 2)])]
LAM = [F(2), F(-1), F(-1)]

def W(X):
    out = zero()
    for lam, a in zip(LAM, SD):
        out = add(out, smul(lam * inner2(a, X) / inner2(a, a), a))
    return out

def S(X):
    return smul(inner2(P[(0, 1)], X), P[(2, 3)])

def cross_pair(R, X, Y):
    return F(-1, 4) * sum(inner2(br(X, R(br(Y, R(P[p])))), P[p]) for p in PHI)

def sharp_bil(R, X, Y):
    return F(1, 2) * (cross_pair(R, X, Y) + cross_pair(R, Y, X))

def sharp_map(R, X):
    out = zero()
    for p in PHI:
        out = add(out, smul(sharp_bil(R, X, P[p]), P[p]))
    return smul(F(1, 2), out)

def innerOp2(A, B):
    return F(1, 2) * sum(inner2(A(P[p]), B(P[p])) for p in PHI)

def sharpPair2(R):
    return innerOp2(R, lambda X: sharp_map(R, X))

def phiTri(A, B, C):
    return F(-1, 4) * sum(inner2(B(br(A(P[p]), C(P[q]))), br(P[p], P[q]))
                          for p in PHI for q in PHI)

lhs, rhs = sharpPair2(W), phiTri(W, W, W)
print(f"sharpPair2(W) = {lhs}, phiTri(W,W,W) = {rhs}")
print(f"  sharpPair2 = c * phiTri at c = {F(lhs, rhs) if rhs else 'undefined'}, "
      f"and the typed constant is -1/2: {lhs == F(-1, 2) * rhs}")

print(f"outer swap, no hypothesis:  phiTri(W,W,S) - phiTri(S,W,W) = {phiTri(W, W, S) - phiTri(S, W, W)}")
print(f"rotation at self-adjoint W: phiTri(W,S,W) - phiTri(S,W,W) = {phiTri(W, S, W) - phiTri(S, W, W)}")
print(f"the Phi half collapses:     {phiTri(S,W,W) + phiTri(W,S,W) + phiTri(W,W,S)} "
      f"against 3 * {phiTri(S, W, W)} = {3 * phiTri(S, W, W)}")

# Control: is the self-adjointness hypothesis on the rotation load-bearing?
#
# A FIRST CONTROL USED ONE STRUCTURED NON-SELF-ADJOINT WITNESS AND RETURNED 0, which would have
# read as the hypothesis being decoration. It is not: the plain rotation fails at essentially
# every triple, and a single structured witness cleared it by accident. One witness is not a
# control. What IS unconditional is the STARRED form, Phi(A;B,C) = Phi(B;C,A*), which is why the
# self-adjointness enters at all: it turns A* back into A.
import random

BASIS = [(i, j) for i in range(N) for j in range(N) if i < j]

def adjoint(A):
    def Astar(X):
        out = zero()
        for e in BASIS:
            out = add(out, smul(inner2(X, A(P[e])), P[e]))
        return out
    return Astar

def from_entries(entries):
    def op(X):
        out = zero()
        for a, e in enumerate(BASIS):
            c = sum(entries[a][b] * inner2(P[f], X) for b, f in enumerate(BASIS))
            out = add(out, smul(c, P[e]))
        return out
    return op

random.seed(7)
def random_op():
    return from_entries([[F(random.randint(-3, 3)) for _ in range(len(BASIS))]
                         for _ in range(len(BASIS))])

plain = starred = 0
TRIALS = 12
for _ in range(TRIALS):
    A, B, C = random_op(), random_op(), random_op()
    if phiTri(A, B, C) != phiTri(B, C, A):
        plain += 1
    if phiTri(A, B, C) != phiTri(B, C, adjoint(A)):
        starred += 1
print(f"{TRIALS} random triples:")
print(f"  Phi(A;B,C) = Phi(B;C,A)  fails {plain}/{TRIALS}, so the self-adjointness IS load-bearing")
print(f"  Phi(A;B,C) = Phi(B;C,A*) fails {starred}/{TRIALS}, the unconditional form")
