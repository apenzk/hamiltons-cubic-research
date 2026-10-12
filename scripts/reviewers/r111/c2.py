import numpy as np
from core111 import Core
import points111 as P

def caps(C, M):
    n = C.n
    lam, V = C.spectral(M)
    T, A = C.Ttensor(V)
    R = T.sum(axis=2)
    g = np.einsum('gab,ab->g', T, (lam[:, None]-lam[None, :])**2)
    Q = np.einsum('gab,a,b->g', T, lam, lam)
    lo, hi = lam.min(), lam.max()
    rho = 2.0*(n-2)
    uni = rho*(hi-lo)**2
    # two-moment LP: mass a at hi, b at lo, a+b=rho, a*hi+b*lo=-2 lam_g
    a = (-2*lam - rho*lo)/(hi-lo)
    b = rho - a
    m2 = a*hi**2 + b*lo**2                 # max of sum lam^2 R_ga
    Qlow = lo*hi*rho                       # min of Q_g from T>=0
    ref = 2*m2 - 2*Qlow
    return lam, g, Q, uni, ref, a, b, lo, hi

rng = np.random.default_rng(2024)
print("Claim 2.  uniform cap U = 2(n-2)(lmax-lmin)^2 ; refined cap Rf.\n")
print("%3s %-13s %10s %10s %8s %12s %12s" % ("n","point","max g","U","Rf/U","max(Rf-U)","max|(a-b)(hi+lo)-(Rf-U)|"))
rows=[]
for n in (6,8,10):
    C = Core(n)
    pts = [("S^%dxS^%d"%(n//2,n//2), P.sphere_product(C,(n//2,n//2)))]
    if n>=8: pts.append(("S^%dxS^%d"%(n//2-1,n//2+1), P.sphere_product(C,(n//2-1,n//2+1))))
    C4,M4 = P.cp2_native(); _,Mp = P.pad(C4,M4,n); pts.append(("CP2 padded", Mp))
    for k in range(3): pts.append(("random%d"%k, P.random_weyl(C,rng)))
    for name,M in pts:
        lam,g,Q,uni,ref,a,b,lo,hi = caps(C,M)
        closed = (a-b)*(hi+lo)
        print("%3d %-13s %10.5f %10.5f %8.5f %12.4e %12.2e"
              % (n,name,g.max(),uni,ref.max()/uni,(ref-uni).max(),np.abs(closed-(ref-uni)).max()))
        rows.append((n,name,g,uni,ref))
print("\nSaturation of the UNIFORM cap, per gamma and in aggregate:")
print("%3s %-13s %12s %12s %12s" % ("n","point","min U-g","max U-g","sum g vs rho*(hi-lo)^2*D"))
for n,name,g,uni,ref in rows:
    print("%3d %-13s %12.5f %12.5f   sum g=%.5f  D*U=%.5f" % (n,name,(uni-g).min(),(uni-g).max(),g.sum(),uni*len(g)))
