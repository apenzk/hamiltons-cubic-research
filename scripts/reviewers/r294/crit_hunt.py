"""Find my own critical points at n=6 (Q(W)=theta W on unit Weyl_6) and test D2/D3 there."""
import sys; sys.path.insert(0,'scripts/reviewers/r294')
import numpy as np, core294 as C
from scipy.optimize import least_squares

n = 6; B = C.weyl_basis294(n); dW = B.shape[0]
def W_of(c):
    W = np.tensordot(c, B, axes=([0],[0])); return W/np.linalg.norm(W)
def F(c):
    W = W_of(c); th = C.theta(n, W); Rres = C.Qop(n, W) - th*W
    return np.einsum('kij,ij->k', B, Rres)

rng = np.random.default_rng(2940)
found = []
for t in range(60):
    c0 = rng.normal(size=dW)
    r = least_squares(F, c0, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=4000)
    if np.abs(r.fun).max() < 1e-11:
        W = W_of(r.x); th = C.theta(n, W)
        if th > 1e-4: found.append((th, W))
found.sort(key=lambda x: -x[0])
print(f"converged critical points: {len(found)}, theta range "
      f"{found[-1][0]:.6f}..{found[0][0]:.6f}" if found else "none")

print(f"\n{'theta':>10s}{'critres':>10s}{'Delta':>10s}{'D2 max res':>12s}"
      f"{'min slack p':>13s}{'max slack p':>13s}{'D3-bound':>10s}{'min lam+':>10s}")
from d3_bound import d3bound
for th, W in found[:8]:
    lam, V, T = C.Tten(n, W); R, Qg, g, X = C.RQg(lam, T)
    p = lam > 1e-9
    res = X[p]/(2*lam[p]) + lam[p] - g[p]/(4*lam[p]) - th
    slack = g[p]/(4*lam[p])
    print(f"{th:10.6f}{np.abs(C.Qop(n,W)-th*W).max():10.1e}{g[p].sum():10.4f}"
          f"{np.abs(res).max():12.1e}{slack.min():13.6f}{slack.max():13.6f}"
          f"{d3bound(lam,n):10.4f}{lam[p].min():10.5f}")

print("\n=== degenerate eigenspace at a NON-symmetric critical point: rotate inside it ===")
if found:
    th, W = found[0]
    lam0, V0 = np.linalg.eigh(W)
    # find a degenerate positive block
    pos = np.where(lam0 > 1e-9)[0]
    blocks = []
    cur = [pos[0]]
    for a in pos[1:]:
        if abs(lam0[a]-lam0[cur[-1]]) < 1e-9: cur.append(a)
        else: blocks.append(cur); cur=[a]
    blocks.append(cur)
    blk = max(blocks, key=len)
    print(f"  largest positive block: size {len(blk)} at lam={lam0[blk[0]]:.6f}")
    if len(blk) > 1:
        rng2 = np.random.default_rng(7)
        Qr,_ = np.linalg.qr(rng2.normal(size=(len(blk),len(blk))))
        V = V0.copy(); V[:, blk] = V0[:, blk] @ Qr
        c = C.cconst(n)
        def dat(V):
            lam = np.diag(V.T @ W @ V)
            cp = np.einsum('ijk,ia,jb,kg->abg', c, V, V, V); T = cp**2
            R = T.sum(2); Qg = np.einsum('gab,a,b->g',T,lam,lam)
            g = np.einsum('gab,ab->g',T,(lam[:,None]-lam[None,:])**2); X = R@lam**2
            return lam, X, g, Qg
        l0,X0,g0,Q0 = dat(V0); l1,X1,g1,Q1 = dat(V)
        print(f"  X_gamma canonical {np.round(X0[blk],6)}")
        print(f"  X_gamma rotated   {np.round(X1[blk],6)}")
        print(f"  g_gamma canonical {np.round(g0[blk],6)}")
        print(f"  g_gamma rotated   {np.round(g1[blk],6)}")
        r0 = X0[blk]/(2*l0[blk])+l0[blk]-g0[blk]/(4*l0[blk])-th
        r1 = X1[blk]/(2*l1[blk])+l1[blk]-g1[blk]/(4*l1[blk])-th
        print(f"  D2 residual canonical {np.abs(r0).max():.2e}   rotated {np.abs(r1).max():.2e}")
