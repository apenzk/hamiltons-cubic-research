import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r100'))
from core import *
rng = np.random.default_rng(1001)

print("=== CLAIM 1: gradient form ===")
for n in [4,5,6,7,8]:
    B = weyl_basis(n); d = len(pairs(n))
    for trial in range(3):
        M, v = random_weyl(n, B, rng)
        W = full_tensor(M, n); A = Wring(W, n)
        Ms = sharp(M, n)
        prM2, cM2 = project_weyl(M@M, B, n)
        pris, cis = project_weyl(iota_star(A@A, n), B, n)
        prSh, cSh = project_weyl(Ms, B, n)
        # (a) literal claim: W^# == 1/2 pr(W^2) - 1/2 pr(iota*(Wring^2))
        rhs = 0.5*prM2 - 0.5*pris
        lit = np.linalg.norm(Ms - rhs)/np.linalg.norm(Ms)
        prj = np.linalg.norm(prSh - rhs)/max(np.linalg.norm(prSh),1e-300)
        # how much of M^# lies OUTSIDE W_n?
        out = np.linalg.norm(Ms - prSh)/np.linalg.norm(Ms)
        if trial==0:
            print(f"n={n}: rel err of LITERAL W^#=...   {lit:.3e}")
            print(f"      rel err of pr(W^#)=...        {prj:.3e}")
            print(f"      ||M^# - pr(M^#)||/||M^#||     {out:.3e}   (component of M^# outside W_n)")
            # Q(W) vs gradient of theta
            Q = 1.5*prM2 - 0.5*pris
            # numerical gradient of theta on W_n
            g = np.zeros(B.shape[1]); h=1e-6
            for r in range(min(12,B.shape[1])):
                e=np.zeros(B.shape[1]); e[r]=h
                Mp=sunvec(B@(v+e),d); Mm=sunvec(B@(v-e),d)
                g[r]=(theta_from_M(Mp,n)-theta_from_M(Mm,n))/(2*h)
            cQ = B.T@svec(Q)
            k=min(12,B.shape[1])
            ratio = g[:k]/cQ[:k]
            print(f"      grad(theta)/Q componentwise: min {ratio.min():.6f} max {ratio.max():.6f}")
    # sharp trilinear symmetry test
    M1,_=random_weyl(n,B,rng); M2,_=random_weyl(n,B,rng); M3,_=random_weyl(n,B,rng)
    def pol(X,Y):
        return 0.5*(sharp(X+Y,n)-sharp(X,n)-sharp(Y,n))
    t123=np.sum(pol(M1,M2)*M3); t132=np.sum(pol(M1,M3)*M2); t231=np.sum(pol(M2,M3)*M1)
    print(f"      sharp trilinear symmetry: {t123:.10f} {t132:.10f} {t231:.10f}")
