import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r99'))
from wlib import *
rng = np.random.default_rng(777)
def iota_star(X,n):
    B=s20_basis(n); Y=np.einsum('cb,cij,bkl->ijkl',X,B,B,optimize=True); return Y.transpose(0,2,3,1)
J=tensor_of_M
print("n=5 collapse test: is pr(iota*(ringW^2)) = c * pr(iota_1*(M^2)) ?")
for t in range(5):
    n=5; W=rand_weyl(n,rng); W/=np.linalg.norm(M_of(W)); M=M_of(W); rw=ringW(W)
    X1=pr(J(M@M,n)/4.0); X2=pr(iota_star(rw@rw,n))
    c=np.sum(X1*X2)/np.sum(X1*X1)
    print(f"   c={c:+.9f}   resid={np.linalg.norm(X2-c*X1)/np.linalg.norm(X2):.2e}")
print("\nis the trilinear form <M^#,N> symmetric => grad<M^#,M> = 3 iota_1^*(M^#)? (fd check)")
for n in [5,6,7]:
    d=dim_W(n)
    S=np.array([pr(rng.standard_normal((n,)*4)).reshape(-1) for _ in range(d+15)])
    U,s,Vt=np.linalg.svd(S,full_matrices=False); Bas=Vt[:d]
    W=rand_weyl(n,rng); W/=np.linalg.norm(M_of(W)); w0=W.reshape(-1)
    def f(v):
        Wv=v.reshape((n,)*4); Mv=M_of(Wv); return float(np.sum(sharp(Mv,n)*Mv))
    h=1e-5; g=np.zeros(d)
    for a in range(d): g[a]=(f(w0+h*Bas[a])-f(w0-h*Bas[a]))/(2*h)
    G=(Bas.T@g).reshape((n,)*4)
    T=3*pr(J(sharp(M_of(W),n),n)/4.0)
    print(f"   n={n}: ||grad - 3 pr(iota_1*(M^#))||/||grad|| = {np.linalg.norm(G-T)/np.linalg.norm(G):.2e}")
