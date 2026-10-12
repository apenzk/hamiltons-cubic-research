"""The eigen-grading of the witness: identify it and rotate into its adapted frame."""
import sys
import numpy as np
sys.path.insert(0, 'scripts/reviewers/r296')
import core296 as c

n = 8
W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
lam, V = np.linalg.eigh(W)
pos, neg = lam > 1e-9, lam < -1e-9
Vp = V[:, pos]
cst = c.cst(n)
phis = np.zeros((28, n, n))
for a, (i, j) in enumerate(c.pairs_of(n)):
    phis[a, i, j] = 1.0; phis[a, j, i] = -1.0
Pm = np.einsum('ak,aij->kij', Vp, phis)          # a basis of p as 8x8 skew matrices

# S_mpp and S_mmm to full precision
cE = np.einsum('ia,jb,kg,ijk->abg', V, V, V, cst)
T = cE ** 2
print(f"S_mmm = sum_(m,m,m) c^2 = {T[np.ix_(neg,neg,neg)].sum():.6e}")
print(f"S_mpp = sum_(m,p,p) c^2 = {T[np.ix_(neg,pos,pos)].sum():.6e}")
print(f"max |c_abg| over (m,p,p) = {np.abs(cE[np.ix_(neg,pos,pos)]).max():.3e}")
print(f"max |c_abg| over (m,m,m) = {np.abs(cE[np.ix_(neg,neg,neg)]).max():.3e}")
print(f"max |c_abg| over (p,p,p) = {np.abs(cE[np.ix_(pos,pos,pos)]).max():.3e}  (should be O(1))")

# the invariant subspaces of p on R^8
rows = []
for A_ in Pm:
    for i in range(n):
        for j in range(i, n):
            E = np.zeros((n, n)); E[i, j] = E[j, i] = 1.0
            rows.append((E @ A_ - A_ @ E).reshape(-1))
Mtx = np.array(rows)
u, s, vt = np.linalg.svd(Mtx)
# commutant = nullspace of the map X -> [X, A] on symmetric X; rebuild in Sym coords
S = []
for i in range(n):
    for j in range(i, n):
        E = np.zeros((n, n)); E[i, j] = E[j, i] = 1.0 / (1.0 if i == j else np.sqrt(2))
        S.append(E)
S = np.array(S)
Rws = []
for A_ in Pm:
    Rws.append(np.array([(E @ A_ - A_ @ E).reshape(-1) for E in S]).T)
Big = np.vstack(Rws)
u2, s2, vt2 = np.linalg.svd(Big)
k = int((s2 < 1e-8 * s2[0]).sum())
print(f"\nsymmetric commutant of p on R^8 has dimension {k}")
ker = vt2[len(S) - k:]
Cmt = np.einsum('kd,dij->kij', ker, S)
# simultaneous eigenbasis: the projectors
X = Cmt[0] + 0.37 * (Cmt[1] if k > 1 else 0)
w, U = np.linalg.eigh(X)
print(f"commutant element eigenvalues: {np.round(w, 8)}")
grp = {}
for idx, val in enumerate(np.round(w, 8)):
    grp.setdefault(val, []).append(idx)
dims = sorted(len(v) for v in grp.values())
print(f"=> R^8 splits under p as {dims}")

# principal angles of the 3-space against the coordinate R^3
for val, cols in grp.items():
    Ub = U[:, cols]
    ang = np.linalg.svd(Ub.T @ np.eye(n)[:, :3], compute_uv=False)
    print(f"   block of dim {len(cols)}: cosines of principal angles with the coordinate"
          f" R^3 = {np.round(ang, 6)}")

# rotate into the adapted frame: p becomes the coordinate so(3)+so(5)
order = sum([grp[v] for v in sorted(grp, key=lambda v: len(grp[v]))], [])
R = U[:, order]
if np.linalg.det(R) < 0:
    R[:, -1] *= -1
I = np.array([p[0] for p in c.pairs_of(n)]); J = np.array([p[1] for p in c.pairs_of(n)])
L = R[np.ix_(I, I)] * R[np.ix_(J, J)] - R[np.ix_(I, J)] * R[np.ix_(J, I)]
Wa = L.T @ W @ L
Pi, Mi = c.graded_split(n, 3)
print(f"\nin the adapted frame:")
print(f"   off-block mass ||W[p,m]|| = {np.linalg.norm(Wa[np.ix_(Pi,Mi)]):.2e}")
print(f"   eigenvalues of the p-block: {np.round(np.linalg.eigvalsh(Wa[np.ix_(Pi,Pi)]),6)}")
print(f"   eigenvalues of the m-block: {np.round(np.linalg.eigvalsh(Wa[np.ix_(Mi,Mi)]),6)}")
print(f"   theta unchanged: {c.theta_of(n, Wa):.12f}")
print(f"   Weyl residuals: {tuple('%.1e' % v for v in c.weyl_residuals(n, Wa))}")
print(f"   off-diagonal mass in this frame: "
      f"{np.linalg.norm(Wa - np.diag(np.diag(Wa))):.6f}")
np.save('scripts/reviewers/r296/W_adapted.npy', Wa)
