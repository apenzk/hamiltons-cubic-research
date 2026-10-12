import numpy as np
from core111 import Core
import points111 as P

def upper_hull(pts):
    """upper concave envelope of a 2-D point cloud, as a list of hull vertices
    sorted by x."""
    pts = sorted(set(map(tuple, np.round(pts, 12))))
    h = []
    for p in pts:
        while len(h) >= 2:
            (x1,y1),(x2,y2) = h[-2], h[-1]
            # keep p only if it is above the line through h[-2], h[-1] -> pop
            cross = (x2-x1)*(p[1]-y1) - (y2-y1)*(p[0]-x1)
            if cross >= -1e-14: h.pop()
            else: break
        h.append(p)
    return np.array(h)

def env_eval(h, x):
    xs, ys = h[:,0], h[:,1]
    x = np.clip(x, xs[0], xs[-1])
    return np.interp(x, xs, ys)

def analyse(C, M):
    n = C.n; rho = 2.0*(n-2)
    lam, V = C.spectral(M)
    T, A = C.Ttensor(V)
    R = T.sum(axis=2)
    g = np.einsum('gab,ab->g', T, (lam[:,None]-lam[None,:])**2)
    lo, hi = lam.min(), lam.max()
    U = rho*(hi-lo)**2
    a = (-2*lam - rho*lo)/(hi-lo); b = rho - a
    Rf = 2*(a*hi**2 + b*lo**2) - 2*lo*hi*rho
    closed = (a-b)*(hi**2 - lo**2)
    # joint LP over pair-masses: max sum w_p (la-lb)^2  s.t. sum w = rho,
    #   sum w (la+lb)/2 = -2 lam_g,  w >= 0.
    s = 0.5*(lam[:,None]+lam[None,:]); cc = (lam[:,None]-lam[None,:])**2
    h = upper_hull(np.stack([s.ravel(), cc.ravel()], 1))
    JLP = rho*env_eval(h, -2*lam/rho)
    return dict(lam=lam, g=g, U=U, Rf=Rf, JLP=JLP, closed=closed, a=a, b=b, lo=lo, hi=hi)

rng = np.random.default_rng(2024)
print("%3s %-13s %9s %9s %9s %9s %9s %9s" %
      ("n","point","max g","U","max Rf","max JLP","JLP/U","closed-form err"))
for n in (6,8,10):
    C = Core(n)
    pts = [("S^%dxS^%d"%(n//2,n//2), P.sphere_product(C,(n//2,n//2)))]
    if n>=8: pts.append(("S^%dxS^%d"%(n//2-1,n//2+1), P.sphere_product(C,(n//2-1,n//2+1))))
    C4,M4 = P.cp2_native(); _,Mp = P.pad(C4,M4,n); pts.append(("CP2 padded", Mp))
    for k in range(3): pts.append(("random%d"%k, P.random_weyl(C,rng)))
    for name,M in pts:
        d = analyse(C,M)
        viol = (d['g'] - d['JLP']).max()
        print("%3d %-13s %9.5f %9.5f %9.5f %9.5f %9.5f %9.2e   maxviol(g-JLP)=%.2e"
              % (n,name,d['g'].max(),d['U'],d['Rf'].max(),d['JLP'].max(),
                 d['JLP'].max()/d['U'], np.abs(d['closed']-(d['Rf']-d['U'])).max(), viol))
