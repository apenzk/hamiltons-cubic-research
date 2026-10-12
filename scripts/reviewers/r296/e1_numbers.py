"""E1: every quoted number on the witness, recomputed from the definitions."""
import sys
import numpy as np
sys.path.insert(0, 'scripts/reviewers/r296')
import core296 as c

n = 8
W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
th = c.theta_of(n, W)
print(f"||W||          = {np.linalg.norm(W):.17f}   (exactly 1? {np.linalg.norm(W) == 1.0})")
print(f"theta          = {th:.12f}")
R = c.Q(n, W) - th * W
print(f"||Q(W)-thW||   max {np.abs(R).max():.2e}   fro {np.linalg.norm(R):.2e}")
bi, ri, tr = c.weyl_residuals(n, W)
print(f"bianchi {bi:.2e}  ricci {ri:.2e}  trace {tr:.2e}")

# Delta, S_mmm, Casimir total, from the definitions
lam, V = np.linalg.eigh(W)
A = c.ad(n)                                  # A[a] = ad(phi_a)
cE = np.einsum('ai,bj,gk,ijk->abg', V, V, V, np.transpose(A, (0, 2, 1)) * 0 + c.cst(n))
T = cE ** 2
g = np.einsum('dab,ab->d', T, (lam[:, None] - lam[None, :]) ** 2)
pos, neg = lam > 1e-9, lam < -1e-9
print(f"\nDelta (trace of g over lam>0)  = {g[pos].sum():.9f}")
print(f"sum_gamma g_gamma             = {g.sum():.9f}   4(n-1) = {4*(n-1)}")
print(f"S_mmm = sum_(mmm) c^2         = {T[np.ix_(neg, neg, neg)].sum():.3e}")
print(f"S_mpp                         = {T[np.ix_(neg, pos, pos)].sum():.6f}")
print(f"dim m = {int(neg.sum())}   dim p = {int(pos.sum())}   ker = {int((np.abs(lam)<=1e-9).sum())}")
print(f"distinct positive eigenvalues : {len(set(np.round(lam[pos], 8)))}")

# Casimir cross-check: sum_d g_d should be sum_ab (lam_a-lam_b)^2 * sum_d c_dab^2
print(f"\nnorm check on the eigenbasis structure constants:"
      f" max|c_E| = {np.abs(cE).max():.4f},"
      f" antisymmetry {np.abs(cE + np.transpose(cE,(1,0,2))).max():.1e}")

# conditioning of the criticality system on V, for a Newton-Kantorovich statement
basis, Pi, Mi = c.block_basis(n, 3)
x = np.einsum('aij,ij->a', basis, W)
print(f"\nW lies in V: ||W - sum x_a B_a|| = "
      f"{np.linalg.norm(W - np.einsum('a,aij->ij', x, basis)):.2e}   ||x|| = {np.linalg.norm(x):.15f}")
QW = c.Q(n, W)
DQ = np.array([W @ B + B @ W + 2.0 * c.sharp_bil(n, W, B) for B in basis])
M = np.einsum('aij,bij->ab', basis, DQ)
gq = np.einsum('ij,bij->b', QW, basis)
Bw = np.einsum('aij,ij->a', basis, W)
Jc = M - 3.0 * np.outer(Bw, gq) - th * np.eye(len(x))
Jf = np.vstack([Jc, 2.0 * x])
sv = np.linalg.svd(Jf, compute_uv=False)
Fv = np.append(np.einsum('aij,ij->a', basis, QW - th * W), float(x @ x) - 1.0)
print(f"residual ||F(x)|| = {np.linalg.norm(Fv):.2e}")
print(f"Jacobian singular values: max {sv[0]:.4f}  min {sv[-1]:.4f}  cond {sv[0]/sv[-1]:.1f}")
print(f"=> Newton correction bound ||F||/sigma_min = {np.linalg.norm(Fv)/sv[-1]:.2e}")
