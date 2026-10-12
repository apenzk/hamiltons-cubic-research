import sys, os, glob
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core, points, le, g123

def S_mmm(n, W, tol=1e-8):
    c = core.cstruct(n)
    lam, V = np.linalg.eigh(W)
    m = V[:, lam < -tol]
    if m.shape[1] == 0: return 0.0, 0
    T = np.einsum('abg,ai,bj,gk->ijk', c, m, m, m, optimize=True)
    return float(np.sum(T*T)), m.shape[1]

def analyse(nm, W, n):
    W = 0.5*(W+W.T); W = W/np.linalg.norm(W)
    th = core.P(n, W)
    if th < 0:
        pass
    Lm, _, B, Bf = le.Lmat(n, W, th)
    Lp, Uc, w = le.restrict_perp(Lm, Bf, W); Lp = 0.5*(Lp+Lp.T)
    ev = np.linalg.eigvalsh(Lp)
    rows, s, nA = g123.HA_span(n, W, True, True)
    Mc = g123.compress(n, W, th, rows); Mc = 0.5*(Mc+Mc.T)
    evV = np.linalg.eigvalsh(Mc)
    keep = np.abs(evV) > 1e-8
    avg = np.trace(Mc)/rows.shape[0]
    avg_nk = evV[keep].mean() if keep.sum() else float('nan')
    d, tot, lamW, g = points.defect(n, W)
    S, dm = S_mmm(n, W)
    crit = np.linalg.norm(core.Q(n,W)-th*W)
    return dict(name=nm, n=n, theta=th, crit=crit, Delta=d, S=S, dimm=dm,
                lam_full=ev[-1], dimV=rows.shape[0], avg=avg, avg_nk=avg_nk,
                nker=int((~keep).sum()), lmaxV=evV[-1])

if __name__ == "__main__":
    items = []
    for f in sorted(glob.glob('scripts/reviewers/r295/sol_*.npy')) + sorted(glob.glob('scripts/reviewers/r296/W_1*.npy')):
        W = np.load(f); N = W.shape[0]
        n = int(round((1+np.sqrt(1+8*N))/2))
        items.append((os.path.basename(f), W, n))
    items.append(("S^3xS^5",)+points.sphere_product([3,5]))
    items.append(("S^4xS^4",)+points.sphere_product([4,4]))
    items.append(("CP^4",)+points.cpm(4))
    items.append(("C5blowup",)+points.c5_blowup())
    items.append(("S^5xS^5",)+points.sphere_product([5,5]))
    items.append(("S2xS3xS3",)+points.sphere_product([2,3,3]))
    print(f"{'point':26s} {'n':>2s} {'theta':>10s} {'Delta':>8s} {'S_mmm':>9s} {'lam_max':>9s} "
          f"{'dimV':>4s} {'ker':>3s} {'avgV':>8s} {'avg-noker':>9s} {'lmaxV':>8s}")
    for nm, W, n in items:
        o = analyse(nm, W, n)
        flag = "  <<< lam_max<=1/2 with Delta>0" if (o['lam_full'] <= 0.5+1e-9 and o['Delta'] > 1e-6) else ""
        print(f"{o['name']:26s} {o['n']:2d} {o['theta']:10.6f} {o['Delta']:8.4f} {o['S']:9.2e} "
              f"{o['lam_full']:9.6f} {o['dimV']:4d} {o['nker']:3d} {o['avg']:8.6f} {o['avg_nk']:9.6f} {o['lmaxV']:8.6f}{flag}")
