"""E1 numbers, corrected transform, plus the degeneracy structure of the Jacobian."""
import sys
import numpy as np
sys.path.insert(0, 'scripts/reviewers/r296')
import core296 as c

n = 8
W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
th = c.theta_of(n, W)
lam, V = np.linalg.eigh(W)
cst = c.cst(n)
cE = np.einsum('ia,jb,kg,ijk->abg', V, V, V, cst)     # eigenbasis structure constants
T = cE ** 2
g = np.einsum('dab,ab->d', T, (lam[:, None] - lam[None, :]) ** 2)
pos, neg = lam > 1e-9, lam < -1e-9
print(f"theta   = {th:.12f}")
print(f"Delta   = {g[pos].sum():.9f}      (recorded 1.512231)")
print(f"sum g   = {g.sum():.12f}          4(n-1) = {4*(n-1)}")
print(f"S_mmm   = {T[np.ix_(neg,neg,neg)].sum():.3e}   S_mpp = {T[np.ix_(neg,pos,pos)].sum():.6f}")
print(f"dim m   = {int(neg.sum())}  dim p = {int(pos.sum())}  ker = {int((np.abs(lam)<=1e-9).sum())}")
print(f"distinct positive eigenvalues = {len(set(np.round(lam[pos],8)))}")

# --- Jacobian degeneracy vs the symmetry orbit inside V ---
basis, Pi, Mi = c.block_basis(n, 3)
x = np.einsum('aij,ij->a', basis, W)
QW = c.Q(n, W)
DQ = np.array([W @ B + B @ W + 2.0 * c.sharp_bil(n, W, B) for B in basis])
M = np.einsum('aij,bij->ab', basis, DQ)
gq = np.einsum('ij,bij->b', QW, basis)
Bw = np.einsum('aij,ij->a', basis, W)
J = np.vstack([M - 3.0*np.outer(Bw, gq) - th*np.eye(len(x)), 2.0*x])
sv = np.linalg.svd(J, compute_uv=False)
print(f"\nJacobian on V: singular values, smallest 20:\n{np.round(sv[-20:], 6)}")
nul = int((sv < 1e-8).sum())
print(f"numerical nullity of J = {nul}")

# tangent to the SO(3)xSO(5) orbit through W, inside V
prs = c.pairs_of(n)
sub = [a for a, (i, j) in enumerate(prs) if (i < 3) == (j < 3)]     # so(3)+so(5)
A = c.ad(n)
orb = np.array([A[a] @ W - W @ A[a] for a in sub])
Ocoef = np.einsum('kij,aij->ka', orb, basis)
s2 = np.linalg.svd(Ocoef, compute_uv=False)
dim_orb = int((s2 > 1e-9).sum())
print(f"dim of the so(3)+so(5) orbit direction inside V = {dim_orb}"
      f"   (dim so(3)+so(5) = {len(sub)})")
# does the kernel of J coincide with the orbit tangent?
u, s_, vt = np.linalg.svd(J)
K = vt[len(x)-nul:] if nul else np.zeros((0, len(x)))
if nul and dim_orb:
    Qo = np.linalg.qr(Ocoef[:, :].T)[0][:, :dim_orb]
    print(f"principal angles between ker J and the orbit tangent: "
          f"{np.round(np.linalg.svd(K @ Qo, compute_uv=False), 8)}")
print(f"\nsigma_min of J off the kernel = {sv[-nul-1] if nul else sv[-1]:.6f}")
Fv = np.append(np.einsum('aij,ij->a', basis, QW - th*W), float(x@x)-1.0)
print(f"||F(x)|| = {np.linalg.norm(Fv):.2e}  =>  correction transverse to the orbit"
      f" <= {np.linalg.norm(Fv)/(sv[-nul-1] if nul else sv[-1]):.2e}")
