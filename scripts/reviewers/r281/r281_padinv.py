"""r281 Claim 3: are the quantities of posts 6, 33, 34, 35 padding-invariant?"""
import sys, os
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..'))
from review_r30_core import weyl_basis, Q, P, circ, sharp, pair_index, normalize
rng = np.random.default_rng(6281)

def rand_weyl(n):
    B = weyl_basis(n)
    c = rng.normal(size=B.shape[0])
    W = np.einsum('k,kij->ij', c, B)
    return W / np.sqrt(np.tensordot(W, W))

def pad(n0, W0, n):
    p0, i0 = pair_index(n0); pn, iN = pair_index(n)
    Wb = np.zeros((len(pn),) * 2)
    for a, pa in enumerate(p0):
        for b, pb in enumerate(p0):
            Wb[iN[pa], iN[pb]] = W0[a, b]
    return Wb

def LW_matrix(n, W):
    B = weyl_basis(n)
    d = B.shape[0]
    M = np.zeros((d, d))
    for k in range(d):
        C = circ(n, W, B[k])
        M[:, k] = np.einsum('lij,ij->l', B, C)
    return M

n0 = 6
W0 = rand_weyl(n0)
print(f"seed: random unit W in Weyl_{n0}")
rows = []
for n in (6, 7, 8):
    W = pad(n0, W0, n) if n > n0 else W0
    L = LW_matrix(n, W)
    tr2 = float(np.trace(L @ L)); tr3 = float(np.trace(L @ L @ L))
    sh = sharp(n, W)
    q34 = float(np.trace(W @ W @ W)) + float(np.sqrt(np.tensordot(sh, sh)))
    pred = (n-1)*(2*n-1)/4.0
    rows.append((n, tr2, pred, tr3, q34, P(n, W), np.tensordot(W, W)))
print(f"{'n':>3} {'tr(L_W^2)':>14} {'(n-1)(2n-1)/4':>15} {'tr(L_W^3)':>14} "
      f"{'tr(W^3)+||W#||_F':>18} {'P(W)':>14} {'||W||^2':>9}")
for r in rows:
    print(f"{r[0]:>3} {r[1]:>14.8f} {r[2]:>15.8f} {r[3]:>14.8f} {r[4]:>18.12f} {r[5]:>14.10f} {r[6]:>9.6f}")
print()
print("post 6 quantities tr(L_W^2), tr(L_W^3): CHANGE under padding (n-dependent coefficients)")
print("post 34/35 quantity tr(W^3)+||W^#||_F, and P, ||W||: INVARIANT under padding")
print()
print("=== padded W_CP2: the post-35 witness value at n=4..16 ===")
import itertools
def cp2_4():
    n = 4
    J = np.zeros((n, n)); J[1,0]=1.; J[0,1]=-1.; J[3,2]=1.; J[2,3]=-1.
    Jm = J.T.copy(); d = np.eye(n)
    R = np.zeros((n,)*4)
    for i,j,k,l in itertools.product(range(n), repeat=4):
        R[i,j,k,l] = (d[i,k]*d[j,l]-d[i,l]*d[j,k]) + (Jm[i,k]*Jm[j,l]-Jm[i,l]*Jm[j,k]) + 2*Jm[i,j]*Jm[k,l]
    p4, _ = pair_index(4)
    W = np.array([[R[i,j,k,l] for (k,l) in p4] for (i,j) in p4])
    B = weyl_basis(4); c = np.einsum('kij,ij->k', B, W)
    return normalize(np.einsum('k,kij->ij', c, B))
Wc = cp2_4()
for n in (4, 5, 6, 8, 10, 12):
    W = pad(4, Wc, n)
    sh = sharp(n, W)
    q = float(np.trace(W@W@W)) + float(np.sqrt(np.tensordot(sh, sh)))
    th0 = np.sqrt(2*(n-1)*(n-2))/n
    print(f"  n={n:2d}: tr(M^3)+||M^#||_F = {q:.12f}   P = {P(n,W):.12f}   theta_0(n) = {th0:.6f}")
