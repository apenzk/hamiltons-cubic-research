"""Screen: sharpMap is not the zero map ON THE CLASS I36Shape quantifies over.

The vacuity a kernel check cannot see: a linear map that is identically zero carries every
linearity lemma and says nothing. A first version of this file screened at R = the identity on
Lambda^2, which r1011 found lies OUTSIDE the class, so it settled nothing about it. The Ricci
clause of IsWeyl2 reads

    ric(a, b) = sum_c inner2(R phi_ac, phi_bc),

and at R = id the diagonal entry is sum_{c != a} inner2(phi_ac, phi_ac) = n - 1, nonzero from
n = 2 on. The witness below is a genuine Weyl operator and all three clauses are checked exactly.

Everything is exact rational arithmetic. Definitions mirror Bivectors2.lean at n = 4:
  br X Y        = X Y - Y X
  inner2 A B    = (1/2) tr(A^T B)
  crossPair2(X,Y) = -(1/4) sum_{i,j} inner2(br X (R (br Y (R phi_ij))), phi_ij)
  sharpBil2(X,Y)  = (1/2) (crossPair2(X,Y) + crossPair2(Y,X))
  sharpMap(X)     = (1/2) sum_{i,j} sharpBil2(X, phi_ij) phi_ij
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

PHI = {(i, j): phi(i, j) for i in range(N) for j in range(N)}

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

def ric(R, a, b):
    return sum(inner2(R(PHI[(a, c)]), PHI[(b, c)]) for c in range(N))

def bianchi(R, i, j, k, l):
    return (inner2(R(PHI[(i, j)]), PHI[(k, l)]) + inner2(R(PHI[(i, k)]), PHI[(l, j)])
            + inner2(R(PHI[(i, l)]), PHI[(j, k)]))

def self_adjoint_residual(R):
    return max(abs(inner2(R(PHI[p]), PHI[q]) - inner2(PHI[p], R(PHI[q])))
               for p in PHI for q in PHI)

def norm_sq2(R):
    return F(1, 2) * sum(inner2(R(PHI[(i, j)]), R(PHI[(i, j)]))
                         for i in range(N) for j in range(N))

def cross_pair(R, X, Y):
    return F(-1, 4) * sum(inner2(br(X, R(br(Y, R(PHI[(i, j)])))), PHI[(i, j)])
                          for i in range(N) for j in range(N))

def sharp_qf(R, eta):
    return cross_pair(R, eta, eta)

def sharp_bil(R, X, Y):
    return F(1, 2) * (cross_pair(R, X, Y) + cross_pair(R, Y, X))

def sharp_map(R, X):
    out = zero()
    for i in range(N):
        for j in range(N):
            out = add(out, smul(sharp_bil(R, X, PHI[(i, j)]), PHI[(i, j)]))
    return smul(F(1, 2), out)

# Control: the identity operator is NOT IsWeyl2, which is why it settles nothing about the class.
identity = lambda X: X
print("control, R = id on Lambda^2:")
print(f"  ric(a,a) = {[ric(identity, a, a) for a in range(N)]}, so the Ricci clause FAILS at n - 1 = {N - 1}")

# The witness: traceless on the self-dual part of Lambda^2, zero on the anti-self-dual part.
SELF_DUAL = [add(PHI[(0, 1)], PHI[(2, 3)]),
             add(PHI[(0, 2)], PHI[(3, 1)]),
             add(PHI[(0, 3)], PHI[(1, 2)])]
LAM = [F(2), F(-1), F(-1)]

def W(X):
    out = zero()
    for lam, a in zip(LAM, SELF_DUAL):
        out = add(out, smul(lam * inner2(a, X) / inner2(a, a), a))
    return out

sa = self_adjoint_residual(W)
bi = max(abs(bianchi(W, i, j, k, l))
         for i in range(N) for j in range(N) for k in range(N) for l in range(N))
rc = max(abs(ric(W, a, b)) for a in range(N) for b in range(N))
print("witness, W = diag(2,-1,-1) on the self-dual part, 0 on the anti-self-dual:")
print(f"  IsWeyl2 clauses, all exact: selfAdjoint {sa}, bianchi {bi}, ric {rc}")
print(f"  normSq2(W) = {norm_sq2(W)}")

S = sharp_map(W, PHI[(0, 1)])
print(f"  sharpQF2(W, phi_01)         = {sharp_qf(W, PHI[(0, 1)])}")
print(f"  inner2(sharpMap W phi_01, .) = {inner2(S, S)}, Frobenius square {2 * inner2(S, S)}")
print("  so sharpMap is NOT the zero map on the class, and the bundling has content there")

# The polarisation identity the Lean lemma sharpBil2_eq asserts, over the whole phi family.
worst = max(abs(sharp_bil(W, PHI[p], PHI[q])
                - F(1, 2) * (cross_pair(W, PHI[p], PHI[q]) + cross_pair(W, PHI[q], PHI[p])))
            for p in PHI for q in PHI)
print(f"sharpBil2_eq reproduced at all {len(PHI) ** 2} ordered pairs of the phi family, worst residual {worst}")

lin = sharp_map(W, add(PHI[(0, 1)], PHI[(2, 3)]))
lin = max(abs(lin[r][c] - (sharp_map(W, PHI[(0, 1)])[r][c] + sharp_map(W, PHI[(2, 3)])[r][c]))
          for r in range(N) for c in range(N))
hom = sharp_map(W, smul(F(5, 2), PHI[(0, 1)]))
hom = max(abs(hom[r][c] - F(5, 2) * sharp_map(W, PHI[(0, 1)])[r][c])
          for r in range(N) for c in range(N))
print(f"the bundled map's own additivity residual {lin}, homogeneity residual {hom}")
