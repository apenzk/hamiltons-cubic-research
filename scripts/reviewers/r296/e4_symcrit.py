"""E4: symmetric criticality for V = Fix(conjugation by Lambda^2(s)), s = diag(I_3,-I_5)."""
import sys
import numpy as np
sys.path.insert(0, 'scripts/reviewers/r296')
import core296 as c

n, p = 8, 3
Pi, Mi = c.graded_split(n, p)
sigma = np.ones(28); sigma[Mi] = -1.0
S = np.diag(sigma)
s8 = np.diag([1.0]*3 + [-1.0]*5)
print(f"Lambda^2(s) in the pair basis is diag(+1 on p, -1 on m): "
      f"+1 count {int((sigma>0).sum())}, -1 count {int((sigma<0).sum())}")

# 1. Lambda^2(s) really is conjugation by s
I = np.array([q[0] for q in c.pairs_of(n)]); J = np.array([q[1] for q in c.pairs_of(n)])
L = s8[np.ix_(I, I)]*s8[np.ix_(J, J)] - s8[np.ix_(I, J)]*s8[np.ix_(J, I)]
print(f"   ||Lambda^2(s) - diag(sigma)|| = {np.linalg.norm(L - S):.2e}")

# 2. Fix(X -> S X S) = block-diagonal
rng = np.random.default_rng(0)
X = rng.normal(size=(28, 28)); X = X + X.T
F = 0.5*(X + S @ X @ S)
print(f"   fixed part has off-block mass {np.abs(F[np.ix_(Pi,Mi)]).max():.2e} (=0 by construction)")

# 3. equivariance of sharp under Ad(s), for a GENERAL symmetric matrix
Y = rng.normal(size=(28, 28)); Y = Y + Y.T
print(f"\nequivariance: ||sharp(S X S) - S sharp(X) S|| = "
      f"{np.abs(c.sharp(n, S@X@S) - S @ c.sharp(n, X) @ S).max():.2e}")
print(f"              ||Q(S X S)     - S Q(X) S||     = "
      f"{np.abs(c.Q(n, S@X@S) - S @ c.Q(n, X) @ S).max():.2e}")

# 4. Weyl_8 is Ad(s)-invariant
B = c.weyl_basis(n)
BS = np.einsum('ij,ajk,kl->ail', S, B, S)
G = np.einsum('aij,bij->ab', B, BS)             # coefficients of S B_a S in the basis
res = np.einsum('ab,bij->aij', G, B) - BS
print(f"\nWeyl_8 invariance: ||S B S - proj_Weyl(S B S)|| = {np.abs(res).max():.2e}")

# 5. the full gradient at points of V has no mass off V -- at 200 random points of V
basis, _, _ = c.block_basis(n, p)
print(f"\ndim V = {basis.shape[0]};  basis Ad(s)-invariance"
      f" {np.abs(np.einsum('ij,ajk,kl->ail', S, basis, S) - basis).max():.2e}")
worst_q, worst_g = 0.0, 0.0
PW = B.reshape(B.shape[0], -1)
for _ in range(200):
    x = rng.normal(size=basis.shape[0])
    W = np.einsum('a,aij->ij', x, basis); W /= np.linalg.norm(W)
    QW = c.Q(n, W)
    worst_q = max(worst_q, float(np.abs(QW[np.ix_(Pi, Mi)]).max()))
    gr = (PW.T @ (PW @ QW.reshape(-1))).reshape(28, 28)      # project onto Weyl_8
    worst_g = max(worst_g, float(np.abs(gr[np.ix_(Pi, Mi)]).max()))
print(f"over 200 random W in V:  max off-block |Q(W)| = {worst_q:.2e};"
      f"  max off-block |proj_Weyl Q(W)| = {worst_g:.2e}")
print("\nSo the off-V gradient mass is zero for a REASON, not by measurement:")
print("  Ad(s) is an inner-product-preserving automorphism of so(8), so Q is Ad(s)-")
print("  equivariant and Weyl_8 is Ad(s)-invariant; at W = sigma W sigma the gradient")
print("  3 proj_Weyl Q(W) is therefore sigma-fixed, i.e. in V.  Palais applies to the")
print("  Z_2 action on the unit sphere of Weyl_8 and V is its fixed-point set.")
