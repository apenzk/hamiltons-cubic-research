"""E1: is there an EXACT critical point next to the saved float64 one?

F(W) = Q(W) - theta(W) W restricted to Weyl_8 and to the unit sphere.  DF has a kernel
of orbit directions [ad(x), W]; the distance from W to an exact zero is bounded by
||F|| / sigma_min(DF restricted to the orbit's orthogonal complement).
"""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r295'); sys.path.insert(0, 'scripts/lib')
from r295_core import *
from review_r30_core import weyl_basis, sharp_bilin

n = 8
W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
B = weyl_basis(n)                                  # (300,28,28)
d = B.shape[0]
QW = Qmap(n, W); th = float(np.sum(QW * W))
F = QW - th * W
print('theta = %.12f   ||F||_F = %.3e' % (th, np.linalg.norm(F)))
print('F lies in Weyl_8:  off-Weyl mass = %.3e'
      % np.linalg.norm(F.reshape(-1) - B.reshape(d, -1).T @ (B.reshape(d, -1) @ F.reshape(-1))))

DQ = np.array([W @ Bb + Bb @ W + 2.0 * sharp_bilin(n, W, Bb) for Bb in B])
M = np.einsum('aij,bij->ab', B, DQ)                # <B_a, DQ[B_b]>
gq = np.einsum('ij,bij->b', QW, B)
Bw = np.einsum('aij,ij->a', B, W)
Jm = M - np.outer(Bw, gq) - th * np.eye(d)         # d/dc of <B_a, Q - theta W>
# restrict to the tangent of the unit sphere
tang = np.eye(d) - np.outer(Bw, Bw) / (Bw @ Bw)
Jt = tang @ Jm @ tang
# orbit directions [ad(x), W] inside Weyl_8
Ad = np.transpose(cst(n), (0, 2, 1))
orb = np.array([(Ad[a] @ W - W @ Ad[a]).reshape(-1) for a in range(28)])
orbc = orb @ B.reshape(d, -1).T
u, so, _ = np.linalg.svd(orbc)
r = int((so > 1e-9).sum())
print('orbit tangent dimension inside Weyl_8: %d  (isotropy dim %d)' % (r, 28 - r))
Uo = np.linalg.svd(orbc, full_matrices=True)[2][:r]    # row basis of the orbit
Pperp = np.eye(d) - Uo.T @ Uo
Jr = Pperp @ Jt @ Pperp
sv = np.linalg.svd(Jr, compute_uv=False)
nz = sv[sv > 1e-9]
print('singular values of DF on (orbit + radial)^perp:')
print('   largest %.6f   smallest nonzero %.6f   count > 1e-9: %d (dim available %d)'
      % (nz[0], nz[-1], len(nz), d - r - 1))
Fc = B.reshape(d, -1) @ F.reshape(-1)
print('Newton step bound: ||F|| / sigma_min = %.3e / %.4f = %.3e'
      % (np.linalg.norm(Fc), nz[-1], np.linalg.norm(Fc) / nz[-1]))
lamJ = np.linalg.eigvalsh(0.5 * (Jr + Jr.T))
print('symmetric part of DF: %d negative, %d positive eigenvalues -> the point is a SADDLE'
      % (int((lamJ < -1e-9).sum()), int((lamJ > 1e-9).sum())))
