import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np
from scipy.optimize import least_squares
SP=_os.path.join(_ROOT, 'scripts/reviewers/r121/')
exec(open(SP+'r121_newton_scan.py').read().split('for n in [5,6]:')[0])
n=5; rng=np.random.default_rng(11)
F=scan(n,400,rng)
W=[w for t,w in F if abs(t-0.8280787)<1e-6][0]
th=ip4(W,Q(W))
print("theta =",th," theta^2 =",th**2," 24/35 =",24/35," |Q-thW|inf =",np.abs(Q(W)-th*W).max())
S0=s20_basis(n); Rm=ring_matrix(W,S0); Rm=(Rm+Rm.T)/2
ev,evec=np.linalg.eigh(Rm)
print("ring spectrum:",np.round(ev,6))
k=int(np.sum(ev<ev[0]+1e-9)); print("bottom eigenspace dim =",k)
rr=np.random.default_rng(3)
for t in range(4):
    c=rr.standard_normal(k); c/=np.linalg.norm(c)
    h=np.einsum('a,aij->ij',evec[:,:k]@c,S0); h/=np.linalg.norm(h)
    L=sum(LOSS(W,h)); mu=-ev[0]
    print(f"  random h in bottom eigenspace: LOSS={L:.9f}  LOSS-mu^2/n={L-mu*mu/n:+.9f}  nu(nu+lam)={ev[0]*(ev[0]+th):.9f}")
Mw=op_matrix(W,so_basis(n))
print("Lambda^2 spectrum:",np.round(np.linalg.eigvalsh((Mw+Mw.T)/2),6))
print("mu =",-ev[0]," (n-1)/n*mu =",(n-1)/n*(-ev[0])," sqrt(3/2) =",np.sqrt(1.5)," CD_n holds:",th<=max(np.sqrt(1.5),(n-1)/n*(-ev[0]))+1e-12)
