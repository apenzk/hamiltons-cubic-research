"""Why ||omega ^ omega|| is CONSTANT on the eigenspace: the plane is self-dual in one 4-space."""
import itertools, sys
import numpy as np
sys.path.insert(0, 'scripts/reviewers/r296')
import core296 as c
from e2_plucker import as_matrix, wedge_coeffs, wedge_norm, eigenspace, QUADS, PRS

n = 8
W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
L = np.linalg.eigvalsh(W)[0]
E, _ = eigenspace(W, L)
M1, M2 = as_matrix(E[0]), as_matrix(E[1])

print("A. the two wedge identities behind the constancy")
a, d = wedge_coeffs(E[0]), wedge_coeffs(E[1])
b = 0.5 * (wedge_coeffs(E[0] + E[1]) - a - d)      # = omega1 ^ omega2
print(f"   ||w1^w1 - w2^w2|| = {np.linalg.norm(a - d):.3e}")
print(f"   ||w1^w2||         = {np.linalg.norm(b):.3e}")
print(f"   ||w1^w1||         = {np.linalg.norm(a):.15f}")
print("   => omega ^ omega is the SAME 4-form for every unit omega in the plane.")

print("\nB. the common 4-dimensional support U")
U = np.linalg.svd(M1)[2][:4]                        # row space of M1
print(f"   principal angles U(w1) vs U(w2): {np.round(np.linalg.svd(U @ np.linalg.svd(M2)[2][:4].T, compute_uv=False), 12)}")
Pu = U.T @ U
print(f"   ||M1 - Pu M1 Pu|| = {np.linalg.norm(M1 - Pu@M1@Pu):.2e}"
      f"   ||M2 - Pu M2 Pu|| = {np.linalg.norm(M2 - Pu@M2@Pu):.2e}")
print("   the plane lies in Lambda^2 U with U of dimension 4.")

print("\nC. inside Lambda^2 U: self-duality")
# coordinates of the plane in an orthonormal basis of U
G = np.linalg.qr(U.T)[0]            # 8 x 4 orthonormal columns spanning U
m1 = G.T @ M1 @ G; m2 = G.T @ M2 @ G
def sd(m):
    """(self-dual part, anti-self-dual part) norms of a 4x4 skew matrix"""
    star = np.array([[m[2,3], -m[1,3], m[1,2]]])   # unused placeholder
    v = np.array([m[0,1], m[0,2], m[0,3]]); w = np.array([m[2,3], -m[1,3], m[1,2]])
    return np.linalg.norm(v + w), np.linalg.norm(v - w)
for lab, m in (('w1', m1), ('w2', m2)):
    p_, q_ = sd(m)
    print(f"   {lab}: |self-dual part| = {p_:.15f}   |anti-self-dual part| = {q_:.3e}")
print("   both generators are SELF-DUAL in U, so the whole plane is;")
print("   on Lambda^2_+(U), omega^omega = |omega|^2 vol_U identically -- constancy is exact.")

print("\nD. where U sits relative to the so(3)+so(5) split")
P3 = np.zeros((8, 8)); P3[:3, :3] = np.eye(3)
print(f"   principal angles of U with R^3 : "
      f"{np.round(np.linalg.svd(G.T @ np.eye(8)[:, :3], compute_uv=False), 6)}")
print(f"   principal angles of U with R^5 : "
      f"{np.round(np.linalg.svd(G.T @ np.eye(8)[:, 3:], compute_uv=False), 6)}")

print("\nE. isotropy: does a symmetry of W rotate the plane?")
A = c.ad(n)
rows = [(A[k] @ W - W @ A[k]).reshape(-1) for k in range(28)]
Mtx = np.array(rows).T
s = np.linalg.svd(Mtx, compute_uv=False)
tol = 1e-8 * s[0]
k_dim = int((s < tol).sum())
print(f"   dim k(W) = dim ker(ad -> [ad, W]) = {k_dim}")
u_, s_, vt_ = np.linalg.svd(Mtx)
K = vt_[28 - k_dim:]                 # coefficient vectors of so(8) elements commuting
acts = []
for kv in K:
    Ak = np.einsum('a,aij->ij', kv, A)
    blk = E @ Ak @ E.T
    acts.append(np.linalg.norm(blk))
print(f"   norms of the action of a k(W) basis on the 2-plane: {np.round(acts, 6)}")
print(f"   max |E A E^T + (E A E^T)^T| over k(W): "
      f"{max(float(np.abs((E@np.einsum('a,aij->ij', kv, A)@E.T) + (E@np.einsum('a,aij->ij', kv, A)@E.T).T).max()) for kv in K):.2e}")

print("\nF. a control the certificate must pass: another eigenspace WITH decomposables")
for lam, dim in [(-0.159366051800, 2), (-0.121635354887, 6), (0.316805943137, 2)]:
    Ex, _ = eigenspace(W, lam)
    vals = [wedge_norm(np.cos(t)*Ex[0] + np.sin(t)*Ex[1]) for t in np.linspace(0, np.pi, 400)] if Ex.shape[0] == 2 else []
    if vals:
        print(f"   lambda={lam:+.6f} dim {Ex.shape[0]}: min over the circle {min(vals):.6f}"
              f"  max {max(vals):.6f}")
    else:
        print(f"   lambda={lam:+.6f} dim {Ex.shape[0]}: (higher dimensional, skipped)")
