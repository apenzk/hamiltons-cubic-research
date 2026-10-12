import sys; sys.path.insert(0,'scripts/reviewers/r294')
import numpy as np, core294 as C

def rowdata(n, W, V=None):
    lam, Ve = np.linalg.eigh(W)
    if V is None: V = Ve
    else: lam = np.diag(V.T @ W @ V)
    c = C.cconst(n); cp = np.einsum('ijk,ia,jb,kg->abg', c, V, V, V)
    T = cp**2
    R = T.sum(2); Qg = np.einsum('gab,a,b->g', T, lam, lam)
    g = np.einsum('gab,ab->g', T, (lam[:,None]-lam[None,:])**2)
    X = R @ lam**2
    return lam, T, R, Qg, g, X

print("=== D2 residual per row vs the gamma-gamma entry of Q(W) - theta W ===")
B = C.weyl_basis294(6); rng = np.random.default_rng(11)
for k in range(4):
    W = np.tensordot(rng.normal(size=B.shape[0]), B, axes=([0],[0])); W /= np.linalg.norm(W)
    th = C.theta(6, W); lam, T, R, Qg, g, X = rowdata(6, W)
    lamv, V = np.linalg.eigh(W)
    D = np.diag(V.T @ (C.Qop(6,W) - th*W) @ V)
    ok = np.abs(lam) > 1e-8
    res = X[ok]/(2*lam[ok]) + lam[ok] - g[ok]/(4*lam[ok]) - th
    print(f"  max|D2res - <(Q-thW)v,v>/lam| = {np.abs(res - D[ok]/lam[ok]).max():.3e}"
          f"   (D2res range {res.min():+.3f}..{res.max():+.3f})")

print("\n=== D3 as an inequality is exactly g_gamma >= 0 ===")
print("   theta <= X/(2lam)+lam  <=>  Q_g <= X_g  <=>  g_g = 2X_g-2Q_g >= 0, given row criticality.")

print("\n=== degenerate eigenspaces: rotate inside one, at a critical point ===")
n, W = C.sphere_product([3,3]); th = C.theta(n, W)
lam0, V0 = np.linalg.eigh(W)
grp = np.where(lam0 > 0)[0]            # 6-fold degenerate positive eigenspace
rng = np.random.default_rng(3)
A = rng.normal(size=(len(grp), len(grp))); Qr, _ = np.linalg.qr(A)
V = V0.copy(); V[:, grp] = V0[:, grp] @ Qr
lam, T, R, Qg, g, X = rowdata(n, W, V)
lam1, T1, R1, Qg1, g1, X1 = rowdata(n, W)
print(f"  X_gamma on the positive rows, canonical  : {np.round(X1[grp],6)}")
print(f"  X_gamma on the positive rows, rotated    : {np.round(X[grp],6)}")
print(f"  g_gamma rotated: {np.round(g[grp],9)}   Q_gamma rotated: {np.round(Qg[grp],6)}")
res = X[grp]/(2*lam[grp]) + lam[grp] - g[grp]/(4*lam[grp]) - th
print(f"  D2 residual after the rotation: {np.abs(res).max():.2e}")

print("\n=== a DEGENERATE, NON-critical point: is D2 basis dependent inside an eigenspace? ===")
Wc = np.tensordot(rng.normal(size=B.shape[0]), C.weyl_basis294(6), axes=([0],[0]))
# force a two-fold degeneracy by symmetrising a random Weyl tensor over nothing -> instead
# use the padded/critical-free route: take S^3xS^3 + a small Weyl perturbation that keeps
# the top eigenvalue simple; report the spread of D2 residuals inside the degenerate block.
n, W0 = C.sphere_product([3,3])
W = W0 + 1e-3*Wc/np.linalg.norm(Wc); W /= np.linalg.norm(W)
th = C.theta(n, W); lam, T, R, Qg, g, X = rowdata(n, W)
ok = np.abs(lam) > 1e-8
res = X[ok]/(2*lam[ok]) + lam[ok] - g[ok]/(4*lam[ok]) - th
print(f"  perturbed (crit residual {np.abs(C.Qop(n,W)-th*W).max():.2e}): D2 residual"
      f" {res.min():+.5f}..{res.max():+.5f}")

print("\n=== lam_gamma = 0 rows: what the identity degenerates to ===")
n0, W0 = C.cpm(2)
P0 = C.pairs(4); P1 = C.pairs(8); idx1 = {p:i for i,p in enumerate(P1)}
W = np.zeros((len(P1), len(P1)))
for a,(i,j) in enumerate(P0):
    for b,(k,l) in enumerate(P0):
        W[idx1[(i,j)], idx1[(k,l)]] = W0[a,b]
n = 8; th = C.theta(n, W)
print(f"  padded W_CP^2 into n=8: weyl {C.is_weyl(n,W)} theta {th:.6f}"
      f"  crit residual {np.abs(C.Qop(n,W)-th*W).max():.2e}")
lam, T, R, Qg, g, X = rowdata(n, W)
z = np.abs(lam) <= 1e-9
print(f"  #zero eigenvalues {z.sum()};  max|g_gamma - 2 X_gamma| on those rows ="
      f" {np.abs(g[z]-2*X[z]).max():.2e};  max|Q_gamma| there = {np.abs(Qg[z]).max():.2e}")
print(f"  X_gamma on the zero rows ranges {X[z].min():.4f}..{X[z].max():.4f} -- nonzero, so the"
      f" identity carries NO theta there")
ok = lam > 1e-9
res = X[ok]/(2*lam[ok]) + lam[ok] - g[ok]/(4*lam[ok]) - th
print(f"  D2 on the positive rows of the padded point: max residual {np.abs(res).max():.2e}")
