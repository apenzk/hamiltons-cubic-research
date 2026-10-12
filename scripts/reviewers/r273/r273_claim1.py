"""r273 Claim 1: reproduce the half-percent table independently, and give the closed form."""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, r273_core as K
from itertools import combinations

def report(m):
    n = 2*m
    idx, N, c, M = K.sphere_product_M(m)
    pos = {p:k for k,p in enumerate(idx)}
    # --- verify M really is a Weyl tensor: first Bianchi + trace free ---
    bmax = 0.0
    for (i,j,k,l) in combinations(range(n),4):
        v = K.Rval(M,pos,i,j,k,l)+K.Rval(M,pos,i,k,l,j)+K.Rval(M,pos,i,l,j,k)
        bmax = max(bmax, abs(v))
    ric = np.zeros((n,n))
    for i in range(n):
        for k in range(n):
            ric[i,k] = sum(K.Rval(M,pos,i,j,k,j) for j in range(n))
    Ms = K.sharp(M,c)
    tr3 = np.trace(M@M@M)
    ip  = float(np.sum(Ms*M))
    nrm = float(np.linalg.norm(Ms))
    th0 = np.sqrt(2*(n-1)*(n-2))/n
    # closed forms derived by hand
    E = 8*m**4 - 28*m**3 + 32*m**2 - 12*m + 1
    cf_tr3 = 1.0/(m*np.sqrt((m-1)*(2*m-1)))
    cf_ip  = (2*m-3)/np.sqrt((m-1)*(2*m-1))
    cf_nrm = np.sqrt(E)/(np.sqrt(m*(m-1))*(2*m-1))
    cf_th  = np.sqrt((2*m-1)*(m-1))/m
    return dict(n=n, bianchi=bmax, ricci=np.abs(ric).max(), fro=np.linalg.norm(M),
                tr3=tr3, ip=ip, nrm=nrm, theta=tr3+ip, th0=th0,
                excess=(tr3+nrm)/th0-1, ratio=nrm/abs(ip),
                cf_err=max(abs(tr3-cf_tr3),abs(ip-cf_ip),abs(nrm-cf_nrm),abs(th0-cf_th)))

print(f"{'n':>3} {'|Bianchi|':>10} {'|Ric|':>10} {'||M||':>8} {'tr(M^3)':>10} {'||M#||':>10} {'sum':>10} {'theta':>10} {'theta_0':>10} {'excess%':>9} {'||M#||/<>':>10} {'cf err':>9}")
for m in [3,4,5,6,7,8,9,10,12]:
    r = report(m)
    print(f"{r['n']:>3} {r['bianchi']:>10.2e} {r['ricci']:>10.2e} {r['fro']:>8.5f} {r['tr3']:>10.5f} {r['nrm']:>10.5f} {r['tr3']+r['nrm']:>10.5f} {r['theta']:>10.6f} {r['th0']:>10.6f} {100*r['excess']:>9.4f} {r['ratio']:>10.6f} {r['cf_err']:>9.1e}")
