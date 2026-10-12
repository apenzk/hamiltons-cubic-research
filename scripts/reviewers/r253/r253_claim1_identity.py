"""r253, claim 1: does <P D(W), U> = <D(W), P U> = <D(W), U> hold, and what
happens when U is only APPROXIMATELY in the target?

Four parts:
  (A) the orthogonal Weyl projector IS idempotent and self-adjoint for the
      full-contraction pairing -- step one of the identity is sound FOR THAT P.
  (B) the file's stated reason ("the projector moving onto U where it acts as
      the identity") is idempotence, which is NOT enough: an O(n)-equivariant
      idempotent Q with the same image, acting as the identity on the target,
      breaks step one.  Exhibited.
  (C) the amplification factor kappa = ||D(W)|| / ||P D(W)|| for a real
      degree-3 projector-free carrier -- the factor any misalignment of U is
      multiplied by.
  (D) the decisive one: three carriers whose PROJECTIONS satisfy F_3 = F_1
      exactly.  With U exactly in the target the test reports the dependence.
      With U off by eps it reports INDEPENDENCE -- the answer the programme
      wants, obtained from the error.
"""
import numpy as np
rng = np.random.default_rng(7)

def KN(A,B): return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                     -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))

def P_weyl(X, n):
    """orthogonal projector onto the Weyl block of (R^n)^{ox 4}: pair
    antisymmetry, pair exchange, first Bianchi, trace removal."""
    X = 0.25*(X - X.transpose(1,0,2,3) - X.transpose(0,1,3,2) + X.transpose(1,0,3,2))
    X = 0.5*(X + X.transpose(2,3,0,1))
    X = X - (X + X.transpose(0,2,3,1) + X.transpose(0,3,1,2))/3.0
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', X); sc = np.trace(Ric); E = Ric - sc/n*g
    X = X - KN(E,g)/(n-2) - sc/(2*n*(n-1))*KN(g,g)
    return 0.5*(X + X.transpose(2,3,0,1))

ip = lambda A,B: float(np.einsum('abcd,abcd->', A, B))
nrm = lambda A: float(np.sqrt(ip(A,A)))

print("(A)  is P self-adjoint in the pairing the covariants use?")
for n in (6, 12):
    X = rng.standard_normal((n,)*4); Y = rng.standard_normal((n,)*4)
    PX = P_weyl(X, n)
    print(f"   n={n:>3}  ||P^2 X - P X||/||P X|| = {nrm(P_weyl(PX,n)-PX)/nrm(PX):.2e}"
          f"   |<PX,Y> - <X,PY>|/|<PX,Y>| = "
          f"{abs(ip(PX,Y)-ip(X,P_weyl(Y,n)))/abs(ip(PX,Y)):.2e}")
print("   -- idempotent and self-adjoint to machine precision.  Step one is")
print("      sound for the ORTHOGONAL projector, in the full-contraction pairing.\n")

print("(B)  but the file's REASON is idempotence, and idempotence is not enough")
n = 6
def Q(X):
    """O(n)-equivariant idempotent, same image as P, acting as the identity on
    the target: Q = P + P B (I - P) with B the index transposition b<->c.
    Q^2 = Q, Q|target = id, Q NOT self-adjoint."""
    PX = P_weyl(X, n); R = X - PX
    return PX + P_weyl(R.transpose(0,2,1,3), n)
X = rng.standard_normal((n,)*4); Y = rng.standard_normal((n,)*4)
QX = Q(X); U = P_weyl(rng.standard_normal((n,)*4), n)
print(f"   ||Q^2 X - Q X||/||Q X||        = {nrm(Q(QX)-QX)/nrm(QX):.2e}   (idempotent)")
print(f"   ||Q U - U||/||U||              = {nrm(Q(U)-U)/nrm(U):.2e}   "
      f"(acts as the identity ON THE TARGET)")
print(f"   |<Q X, Y> - <X, Q Y>|/|<Q X,Y>| = {abs(ip(QX,Y)-ip(X,Q(Y)))/abs(ip(QX,Y)):.2e}"
      f"   (NOT self-adjoint)")
print(f"   |<Q X, U> - <X, U>|/|<Q X, U>|  = {abs(ip(QX,U)-ip(X,U))/abs(ip(QX,U)):.2e}"
      f"   <-- THE IDENTITY FAILS")
print("   Q satisfies every property the docstring appeals to.  The identity")
print("   holds only because P is ORTHOGONAL -- a hypothesis the file never")
print("   states, and the (2,2) block has multiplicity 2 in the 4-fold tensor")
print("   power, so equivariant non-orthogonal idempotents onto it exist.\n")

def weyl_random(n, rng):
    R = rng.standard_normal((n,)*4)
    R = 0.25*(R - R.transpose(1,0,2,3) - R.transpose(0,1,3,2) + R.transpose(1,0,3,2))
    R = 0.5*(R + R.transpose(2,3,0,1))
    R = R - (R + R.transpose(0,2,3,1) + R.transpose(0,3,1,2))/3.0
    return P_weyl(R, n)

D1 = lambda W: np.einsum('abef,cdgh,efgh->abcd', W, W, W)
D2 = lambda W: np.einsum('aecf,bgdh,egfh->abcd', W, W, W)
I1 = lambda W: float(np.einsum('abcd,cdef,efab->', W, W, W))
K  = lambda W, n: np.einsum('ab,cd->abcd', np.eye(n), np.eye(n)) * I1(W)
D3 = lambda W, n: D1(W) + K(W, n)

print("(C)  kappa = ||D(W)|| / ||P D(W)||, the factor a misalignment is multiplied by")
for n in (6, 8, 12):
    W = weyl_random(n, rng)
    for name, D in (("D1", D1(W)), ("D2", D2(W)), ("D3 = D1 + K", D3(W, n))):
        print(f"   n={n:>3}  {name:<12} kappa = {nrm(D)/nrm(P_weyl(D,n)):.3e}")
print()

print("(D)  approximate U: the test flips from DEPENDENT to INDEPENDENT")
n = 8
print(f"   n = {n}.  Carriers D1, D2, D3 = D1 + K with K_abcd = d_ab d_cd I1(W).")
print(f"   P K = 0 exactly, so F_3 = P D_3 = P D_1 = F_1: the true function rank is 2.")
W0 = weyl_random(n, rng)
print(f"   check  ||P K(W)|| / ||K(W)|| = {nrm(P_weyl(K(W0,n),n))/nrm(K(W0,n)):.2e}"
      f"   (K really is killed by the projector)")
samples = [weyl_random(n, rng) for _ in range(6)]
Uexact  = [weyl_random(n, rng) for _ in range(6)]
Gpert   = [rng.standard_normal((n,)*4) for _ in range(6)]

def value_matrix(Us):
    rows = []
    for W in samples:
        cols = [D1(W), D2(W), D3(W, n)]
        for U in Us:
            rows.append([ip(c, U) for c in cols])
    return np.array(rows)

def rank_report(M):
    sv = np.linalg.svd(M, compute_uv=False)
    return int((sv > sv[0]*1e-10).sum()), sv[2]/sv[0]

r, ratio = rank_report(value_matrix(Uexact))
print(f"\n   U EXACTLY in the target:  rank {r}   sv3/sv1 = {ratio:.2e}   "
      f"(correct: the dependence is seen)")
print("\n   U off the target by a relative eps (U + eps*G, G generic):")
print("     eps        sv3/sv1      rank at the file's 1e-10 cut")
for eps in (1e-2, 1e-6, 1e-10, 1e-12, 1e-14, 1e-16):
    Us = [U/nrm(U) + eps*G/nrm(G) for U, G in zip(Uexact, Gpert)]
    r, ratio = rank_report(value_matrix(Us))
    flag = "  <-- FALSE INDEPENDENCE" if r == 3 else ""
    print(f"     {eps:.0e}   {ratio:.3e}    {r}{flag}")
print("\n   The spurious singular value is eps * ||K(W)|| against the signal")
print("   ||P D_1(W)||, i.e. eps * kappa.  The error direction is the dangerous")
print("   one: contamination RAISES the rank, so a misaligned U reports")
print("   independence -- the conclusion the programme is trying to establish.")
