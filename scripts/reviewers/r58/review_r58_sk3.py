import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *
from review_r58_sk2 import Rring_mat, sigma_and_b

def weyl4_12(q,r):
    P=phis(4); pr=pairs(4); e=lambda i,j:P[pr.index((i,j))]
    SD=[(e(0,1)+e(2,3))/np.sqrt(2),(e(0,2)-e(1,3))/np.sqrt(2),(e(0,3)+e(1,2))/np.sqrt(2)]
    V=np.array([[0.5*np.trace(s.T@P[a]) for a in range(6)] for s in SD])
    W=(q+r)*np.outer(V[0],V[0])-q*np.outer(V[1],V[1])-r*np.outer(V[2],V[2])
    return W/fro(W)

def product_spheres(p,q):
    """Weyl part of the curvature operator of S^p(1) x S^q(1)."""
    n=p+q; pr=pairs(n); N=len(pr)
    R=np.zeros((n,n,n,n))
    def g(i,j): return 1.0 if i==j else 0.0
    for i in range(n):
     for j in range(n):
      for k in range(n):
       for l in range(n):
        v=0.0
        if all(x<p for x in (i,j,k,l)): v+=g(i,k)*g(j,l)-g(i,l)*g(j,k)
        if all(x>=p for x in (i,j,k,l)): v+=g(i,k)*g(j,l)-g(i,l)*g(j,k)
        R[i,j,k,l]=v
    W=np.zeros((N,N))
    for a,(i,j) in enumerate(pr):
        for b,(k,l) in enumerate(pr): W[a,b]=R[i,j,k,l]
    W=project_weyl(W,n)
    return W/fro(W)

print('=== padded W_CP2 : bound tightness ===')
W4=wcp2()
for n in [6,8,10]:
    W=pad(W4,4,n); b,S2,Sa,k=sigma_and_b(W,n); lm=np.linalg.eigvalsh(Rring_mat(W,n))[-1]
    print('  n=%2d  #neg=%d  lam_max(Rring)=%.9f  2b*Sigma=%.9f  ratio=%.6f  theta=%.6f'%(n,k,lm,2*b*S2,lm/(2*b*S2),theta(W,n)))

print()
print('=== structured points OUTSIDE the stratum: does the truncated bound fail? ===')
for (p,q) in [(3,3),(4,4),(2,4),(5,5),(3,5)]:
    n=p+q
    if n>10: continue
    W=product_spheres(p,q)
    b,S2,Sa,k=sigma_and_b(W,n); lm=np.linalg.eigvalsh(Rring_mat(W,n))[-1]
    print('  S^%d x S^%d (n=%2d)  #neg=%3d  lam_max(Rring)=%.6f  2b*Sigma(top2)=%.6f  ratio=%.4f  %s   [2b*Sigma(all)=%.4f]'%(
        p,q,n,k,lm,2*b*S2,lm/(2*b*S2),'FAILS' if lm>2*b*S2+1e-9 else 'holds',2*b*Sa))
    for m in [n+2]:
        Wp=pad(W,n,m); b,S2,Sa,k=sigma_and_b(Wp,m); lm=np.linalg.eigvalsh(Rring_mat(Wp,m))[-1]
        print('      padded to n=%2d   #neg=%3d  lam_max=%.6f  2b*Sigma(top2)=%.6f  ratio=%.4f  %s'%(
            m,k,lm,2*b*S2,lm/(2*b*S2),'FAILS' if lm>2*b*S2+1e-9 else 'holds'))

print()
print('=== ascent: maximise lam_max(Rring_W) - 2 b Sigma(top2) over unit Weyl_n ===')
from scipy.optimize import minimize
for n in [5,6]:
    B=weyl_basis(n); d=len(B); rng=np.random.default_rng(11); best=-9; bw=None
    def f(x):
        W=np.einsum('d,dij->ij',x,B); W/=fro(W)
        b,S2,Sa,k=sigma_and_b(W,n)
        if k==0: return 9.0
        lm=np.linalg.eigvalsh(Rring_mat(W,n))[-1]
        return -(lm-2*b*S2)
    for t in range(12):
        res=minimize(f,rng.standard_normal(d),method='Powell',
                     options={'maxiter':40000,'maxfev':40000,'xtol':1e-9,'ftol':1e-11})
        if -res.fun>best: best=-res.fun; bw=res.x
    W=np.einsum('d,dij->ij',bw,B); W/=fro(W)
    b,S2,Sa,k=sigma_and_b(W,n); lm=np.linalg.eigvalsh(Rring_mat(W,n))[-1]
    print('  n=%d  max (lam_max - 2b Sigma) = %+.9f  at #neg=%d  lam_max=%.6f 2bSigma=%.6f  theta=%.6f'%(
        n,best,k,lm,2*b*S2,theta(W,n)))
