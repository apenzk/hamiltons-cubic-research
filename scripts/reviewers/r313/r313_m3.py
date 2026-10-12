"""M3: independent verification of the two r305 off-locus witnesses."""
import sys, numpy as np
sys.path.insert(0,'scripts/reviewers/r313')
import r313_lib as R
from r313_m1b import ad_matrix

def defect(n, W):
    N = W.shape[0]
    ev, V = np.linalg.eigh(W)
    tot = 0.0; Delta = 0.0; gs = []
    for k in range(N):
        X = R.mat_of(n, V[:, k])
        a = ad_matrix(n, X)
        g = np.linalg.norm(a @ W - W @ a)**2
        gs.append(g); tot += g
        if ev[k] > 1e-9: Delta += g
    return Delta, tot, ev, V, np.array(gs)

def support_op(n, W):
    """T_ip = sum_{jkl} W_ijkl W_pjkl ; ker T = the annihilator (frame independent)."""
    D = R.pidx(n)
    Wt = np.zeros((n,n,n,n))
    for (i,j),(a,sa) in D.items():
        for (k,l),(b,sb) in D.items():
            Wt[i,j,k,l] = sa*sb*W[a,b]
    return np.einsum('ijkl,pjkl->ip', Wt, Wt)

def simple_ranks(n, W, tol=1e-7):
    ev, V = np.linalg.eigh(W)
    out=[]
    for k in range(len(ev)):
        near = np.abs(ev-ev[k]) < tol
        if near.sum()==1 and abs(ev[k])>1e-9:
            X = R.mat_of(n, V[:,k])
            s = np.linalg.svd(X, compute_uv=False)
            out.append(int((s > 1e-8*s[0]).sum()))
    return sorted(set(out))

def gauss_newton(n, W, iters=60):
    """polish to Q(W)=theta W on the unit sphere of Weyl_n, by hand-rolled GN on lstsq."""
    B = R.weyl_basis(n); dim = B.shape[0]
    x = R.coords(n, W); x /= np.linalg.norm(x)
    for it in range(iters):
        Wc = R.from_coords(n, x)
        th = R.theta_of(n, Wc)
        Fm = R.Qmap(n, Wc) - th*Wc
        F = R.coords(n, Fm)
        # Jacobian of x -> coords(Q(W)-theta W), theta treated as a free variable
        J = np.zeros((dim, dim+1))
        c = R.struct(n)
        U = np.einsum('acd,ce->aed', c, Wc, optimize=True)
        for st in range(0, dim, 64):
            Hs = B[st:st+64]
            V2 = np.einsum('aed,bdf->baef', U, Hs, optimize=True)
            sh = 0.5*np.einsum('baef,cef->bac', V2, c, optimize=True)
            sh = 0.5*(sh+np.transpose(sh,(0,2,1)))
            img = Wc@Hs + Hs@Wc + 2*sh - th*Hs
            J[:, st:st+Hs.shape[0]] = np.einsum('kab,tab->tk', img, B)
        J[:, dim] = -x
        # constraint: keep unit norm -> project step orthogonal to x
        A = np.vstack([J, np.concatenate([x, [0.0]])])
        rhs = np.concatenate([-F, [0.0]])
        step, *_ = np.linalg.lstsq(A, rhs, rcond=None)
        x = x + step[:dim]
        x /= np.linalg.norm(x)
        if np.linalg.norm(F) < 1e-15: break
    Wc = R.from_coords(n, x)
    return Wc

n = 8
for name in ("r305_n8_seed9015","r305_n8_seed9018","r305_n8_seed9033","r305_n8_ratio_lt1"):
    W = np.load(f"scripts/reviewers/r305/out/{name}.npy")
    print(f"=== {name} ===")
    print(f"  symmetric: {np.linalg.norm(W-W.T):.2e}   ||W||^2 = {np.tensordot(W,W,axes=2):.12f}")
    print(f"  distance to Weyl_8: {np.linalg.norm(W-R.proj_weyl(n,W)):.2e}")
    res, th = R.crit_residual(n, W)
    print(f"  theta = {th:.12f}   criticality residual = {res:.2e}")
    Wp = gauss_newton(n, W)
    res2, th2 = R.crit_residual(n, Wp)
    if th2 < 0: Wp = -Wp; res2, th2 = R.crit_residual(n, Wp)
    print(f"  polished: theta = {th2:.12f}  residual = {res2:.2e}  moved {np.linalg.norm(Wp-W):.2e}")
    D, tot, ev, V, gs = defect(n, Wp)
    print(f"  Delta = {D:.9f}   sum g = {tot:.9f}  (4(n-1) = {4*(n-1)})")
    T = support_op(n, Wp)
    tev = np.linalg.eigvalsh(T)
    print(f"  support operator T: eigenvalues min={tev[0]:.3e} max={tev[-1]:.3e}  -> ker dim = {int((tev < 1e-9*tev[-1]).sum())}")
    print(f"  spectrum of W: {np.array2string(np.linalg.eigvalsh(Wp), precision=6, max_line_width=200)}")
    print(f"  ranks of simple eigenvectors: {simple_ranks(n, Wp)}")
    lam, evec, evs, Cp, Lm = R.lam_max_perp(n, Wp, th2)
    print(f"  lambda_max(L_e | W-perp) = {lam:.9f}   top few = {np.array2string(evs[-5:], precision=6)}")
