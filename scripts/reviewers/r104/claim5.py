import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r104'))
import numpy as np, weyl104 as w, relax104 as R
from scipy.optimize import minimize
from scipy.linalg import expm

def rotate(W,Q):
    return np.einsum('ia,jb,kc,ld,abcd->ijkl',Q,Q,Q,Q,W,optimize=True)

def t_of(W,n):
    K=w.vertex_matrix(W,n); return np.sum(K**2),K

def kappa2(W,n,nstarts=8,seed=0):
    rng=np.random.default_rng(seed)
    tri=np.triu_indices(n,1)
    def negt(x):
        A=np.zeros((n,n)); A[tri]=x; A=A-A.T
        return -t_of(rotate(W,expm(A)),n)[0]
    best=(-9e9,None)
    starts=[np.zeros(len(tri[0]))]+[rng.standard_normal(len(tri[0]))*s for s in (0.3,0.6,1.0,1.5)*2][:nstarts]
    for x0 in starts:
        r=minimize(negt,x0,method='Powell',options={'maxiter':20000,'xtol':1e-8,'ftol':1e-10})
        if -r.fun>best[0]:
            A=np.zeros((n,n)); A[tri]=r.x; A=A-A.T
            best=(-r.fun,expm(A))
    return best

def theta_of(W,n):
    M=w.tensor_to_M(W,n); K=w.vertex_matrix(W,n)
    vecs,_=w.K_eigvecs_on_1perp(K,n)
    Rop=w.ring_W_operator(W,n,list(vecs))
    return 1.5*w.p3(np.linalg.eigvalsh(M))-0.5*w.p3(np.linalg.eigvalsh(Rop))

n=int(sys.argv[1]) if len(sys.argv)>1 else 6
th0=np.sqrt(2*(n-1)*(n-2))/n
print(f"n={n}  theta_0={th0:.6f}")
print(f"{'W':>16} {'theta':>9} {'t(gen frame)':>13} {'kappa^2':>9} {'Relax@K(F*)':>12} {'ratio':>7}")
rng=np.random.default_rng(777)
cases=[]
for i in range(6):
    cases.append((f"random {i}", w.random_weyl(n,rng)))
# sphere product and a perturbation of it
def sphere_prod(p,q):
    m=p+q; Rt=np.zeros((m,m,m,m))
    for blk in (list(range(p)),list(range(p,m))):
        gb=np.zeros((m,m))
        for i in blk: gb[i,i]=1.0
        Rt+=0.5*w.kn(gb,gb)
    W=w.weyl_project(w.bianchi_project(Rt),m)
    return W/np.linalg.norm(w.tensor_to_M(W,m))
if n%2==0:
    Wsp=sphere_prod(n//2,n//2); cases.append(("S^k x S^k",Wsp))
    for eps in (0.05,0.15,0.35):
        Wp=Wsp+eps*w.random_weyl(n,np.random.default_rng(3))
        Wp=Wp/np.linalg.norm(w.tensor_to_M(Wp,n))
        cases.append((f"S^kxS^k + {eps}",Wp))
for name,W in cases:
    th=theta_of(W,n)
    tg,_=t_of(W,n)
    k2,Q=kappa2(W,n,seed=1)
    Wb=rotate(W,Q); _,Kb=t_of(Wb,n)
    v,a,b=R.relax_for_K(Kb,nstarts=60)
    print(f"{name:>16} {th:>9.5f} {tg:>13.5f} {k2:>9.5f} {v:>12.5f} {v/th0:>7.3f}")
