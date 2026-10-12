"""Screen: trOp is the trace, and trCube2_first_variation's self-adjointness is LOAD-BEARING.

The kernel proves the identity under its hypothesis and cannot say whether the hypothesis does
any work. This exhibits an R for which it FAILS, which is what makes the binder a hypothesis
rather than decoration. Mirrors TraceOp.lean at n = 4, exact rational arithmetic:
  trOp M       = (1/2) sum_{i,j} inner2(M phi_ij, phi_ij)
  innerOp2 A B = (1/2) sum_{i,j} inner2(A phi_ij, B phi_ij)
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

def smul(s, A):
    return [[s * A[r][c] for c in range(N)] for r in range(N)]

def inner2(A, B):
    return F(1, 2) * sum(sum(A[k][c] * B[k][c] for k in range(N)) for c in range(N))

def trOp(M):
    return F(1, 2) * sum(inner2(M(P[p]), P[p]) for p in PHI)

def innerOp2(A, B):
    return F(1, 2) * sum(inner2(A(P[p]), B(P[p])) for p in PHI)

def comp(A, B):
    return lambda X: A(B(X))

def is_self_adjoint(A):
    return all(inner2(A(P[p]), P[q]) == inner2(P[p], A(P[q])) for p in PHI for q in PHI)

def lhs_minus_rhs(R, S):
    RR = comp(R, R)
    lhs = innerOp2(comp(S, R), R) + innerOp2(comp(R, S), R) + innerOp2(RR, S)
    return lhs - 3 * innerOp2(S, RR)

identity = lambda X: X
print(f"trOp(id) = {trOp(identity)}, and dim Lambda^2 = n(n-1)/2 = {N * (N - 1) // 2}")

# A self-adjoint R: the Weyl witness, diag(2,-1,-1) on the self-dual part.
SD = [add(P[(0, 1)], P[(2, 3)]), add(P[(0, 2)], P[(3, 1)]), add(P[(0, 3)], P[(1, 2)])]
LAM = [F(2), F(-1), F(-1)]
def W(X):
    out = zero()
    for lam, a in zip(LAM, SD):
        out = add(out, smul(lam * inner2(a, X) / inner2(a, a), a))
    return out

# An arbitrary direction, deliberately NOT self-adjoint: phi_01 -> phi_23, everything else -> 0.
def S(X):
    return smul(inner2(P[(0, 1)], X), P[(2, 3)])

# A NON-self-adjoint R, to show the hypothesis is load-bearing.
def Rbad(X):
    return smul(inner2(P[(0, 1)], X), P[(0, 2)])

print(f"W self-adjoint?    {is_self_adjoint(W)};    S self-adjoint? {is_self_adjoint(S)}")
print(f"Rbad self-adjoint? {is_self_adjoint(Rbad)}")
print(f"at R = W    (hypothesis HOLDS): residual = {lhs_minus_rhs(W, S)}")
print(f"at R = Rbad (hypothesis FAILS): residual = {lhs_minus_rhs(Rbad, S)}")
print(f"at R = Rbad, direction W:       residual = {lhs_minus_rhs(Rbad, W)}")
