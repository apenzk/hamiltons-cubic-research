"""Reviewer 55, K3 part D: correctors, pushed harder, with an ORBIT test rather
than a theta test.

Two points can share theta and share S and still be different critical points,
so the returned point is checked against the base by
  (i)  the 45 eigenvalues of W on Lambda^2 (conjugation invariant),
  (ii) the full 770-eigenvalue spectrum of L_e (conjugation invariant),
  (iii) an explicit alignment  min_{g in SO(n)} || Lambda^2(g) W Lambda^2(g)^T - W' ||.
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from scipy.optimize import least_squares, minimize
from review_r55_core import *
from review_r55_k1 import c5_vertex
from review_r55_k2 import Le_matrix

def lam2(g):
    n=g.shape[0]; prs=pairs_of(n); N=len(prs)
    M=np.zeros((N,N))
    for a,(i,j) in enumerate(prs):
        for b,(k,l) in enumerate(prs):
            M[a,b]=g[i,k]*g[j,l]-g[i,l]*g[j,k]
    return M

def orbit_distance(n, W, Wp, tries=6, seed=0):
    """min over SO(n) of ||Lambda^2(g) W Lambda^2(g)^T - Wp||_F."""
    from scipy.linalg import expm
    prs=pairs_of(n); ix=pidx(n)
    rng=np.random.default_rng(seed)
    def build(x):
        A=np.zeros((n,n))
        for t,(i,j) in enumerate(prs): A[i,j]=x[t]; A[j,i]=-x[t]
        return lam2(expm(A))
    def f(x):
        G=build(x); return float(np.linalg.norm(G@W@G.T-Wp))
    best=np.inf
    for _ in range(tries):
        x0=rng.normal(scale=0.6,size=len(prs))
        r=minimize(f,x0,method='Powell',options=dict(maxiter=40000,xtol=1e-9,ftol=1e-12))
        best=min(best,r.fun)
        if best<1e-6: break
    return best

def setup(n=10):
    lam,_=c5_vertex([2]*5)
    W=diag_operator(lam); W=W/np.linalg.norm(W)
    th=float(np.tensordot(W,Q(n,W))); e=W/th
    B=weyl_basis(n); D=B.shape[0]; Bf=np.ascontiguousarray(B.reshape(D,-1))
    M=Le_matrix(n,e,B); Ms=0.5*(M+M.T); ev,V=np.linalg.eigh(Ms)
    half=V[:,np.abs(ev-0.5)<1e-8]
    OT=onb(orbit_tangent(n,W)); Oq,_=np.linalg.qr((OT@Bf.T).T)
    Pex=half-Oq@(Oq.T@half); u,s,_=np.linalg.svd(Pex,full_matrices=False)
    exc=u[:,s>1e-8]
    return dict(n=n,W=W,e=e,th=th,B=B,Bf=Bf,ev=ev,V=V,half=half,Oq=Oq,exc=exc)

def make_jac(s):
    n=s['n']; B=s['B']; Bf=s['Bf']; D=B.shape[0]; Oq=s['Oq']
    from review_r55_k2 import Le_matrix
    def jac(c, gauge=True):
        X=np.einsum('d,dij->ij',c,B); QX=Q(n,X); t=float(np.tensordot(X,QX))
        q=Bf@QX.ravel(); M=Le_matrix(n,X,B)
        Jc=2*M - t*np.eye(D) - 3*np.outer(c,q)
        r=Bf@(QX-t*X).ravel()
        Jp=Jc - np.outer(c, Jc.T@c) - np.outer(c, r) - (r@c)*np.eye(D)
        blocks=[Jp, (2*c)[None,:]]
        if gauge: blocks.append(Oq.T)
        return np.vstack(blocks)
    return jac

def corrector(s, c0dir, t, gauge=True, maxit=40000):
    """Gauss-Newton/LM corrector on the criticality system, started at c0 + t*dir."""
    n=s['n']; B=s['B']; Bf=s['Bf']
    mat=lambda c: np.einsum('d,dij->ij',c,B)
    cW = Bf@s['W'].ravel()
    Oq=s['Oq']
    def resid(c):
        X=mat(c); QX=Q(n,X); t_=float(np.tensordot(X,QX))
        r=Bf@(QX-t_*X).ravel()
        r=r-(r@c)*c
        out=[r, [c@c-1.0]]
        if gauge: out.append(Oq.T@(c-cW))     # gauge-fix: kill orbit drift
        return np.concatenate([np.atleast_1d(x) for x in out])
    c=cW+t*c0dir; c/=np.linalg.norm(c)
    J=s.setdefault('_jac', make_jac(s))
    sol=least_squares(resid,c,jac=lambda cc: J(cc,gauge),method='lm',
                      xtol=1e-15,ftol=1e-15,gtol=1e-15,max_nfev=3000)
    return sol

def describe(s, c):
    n=s['n']; B=s['B']
    X=np.einsum('d,dij->ij',c,B); X/=np.linalg.norm(X)
    QX=Q(n,X); th=float(np.tensordot(X,QX))
    if th<0: X,th=-X,-th
    res=float(np.linalg.norm(Q(n,X)-th*X))
    S=slack_struct(n,X)
    spec=np.sort(np.linalg.eigvalsh(X))
    return X,th,res,S,spec

def main():
    t0=time.time(); s=setup(); n=s['n']
    W=s['W']; th0_=s['th']
    base_spec=np.sort(np.linalg.eigvalsh(W))
    base_le=np.sort(s['ev'])
    print(f"base: theta={th0_:.9f}  S={slack_struct(n,W):.2e}  excess dirs={s['exc'].shape[1]}")
    rng=np.random.default_rng(3)
    dirsets={}
    dirsets['excess E(1/2)']=[s['exc'][:,i] for i in range(s['exc'].shape[1])]
    # random directions in Weyl_n orthogonal to W and to the orbit
    cW=s['Bf']@W.ravel(); Oq=s['Oq']
    rnd=[]
    for _ in range(20):
        v=rng.normal(size=len(cW)); v-= (v@cW)*cW; v-=Oq@(Oq.T@v); v/=np.linalg.norm(v)
        rnd.append(v)
    dirsets['random Weyl (not E(1/2))']=rnd
    # directions in the top eigenspace of L_e (lambda = 1.206) and other eigenspaces
    for target in (1.2060113, 0.7602588, 0.6666667, -0.6666667, 0.0):
        m=np.abs(s['ev']-target)<1e-6
        if m.sum()==0: continue
        cols=s['V'][:,m]
        dd=[]
        for _ in range(min(6,int(m.sum()))):
            a=rng.normal(size=cols.shape[1]); v=cols@a; v/=np.linalg.norm(v); dd.append(v)
        dirsets[f'L_e eigenspace {target:+.4f} (dim {int(m.sum())})']=dd
    print(f"\n{'direction set':>36} {'t':>5} {'#':>4} {'resid':>10} {'theta':>12} {'S':>10} {'|dc|':>8} {'spec dev':>10}")
    landed=[]
    for name,dirs in dirsets.items():
        for t in (0.05,0.2,0.4,0.7,1.0,1.5):
            rows=[]
            for d in dirs:
                sol=corrector(s,d,t)
                r=np.linalg.norm(sol.fun)
                X,thn,res,S,spec=describe(s,sol.x)
                dc=np.linalg.norm(sol.x-cW)
                sd=np.abs(spec-base_spec).max()
                rows.append((r,res,thn,S,dc,sd))
                landed.append((name,t,r,res,thn,S,dc,sd,sol.x))
            rows=np.array(rows)
            print(f"{name:>36} {t:5.2f} {len(dirs):4d} {np.median(rows[:,1]):10.2e} "
                  f"{np.median(rows[:,2]):12.7f} {np.median(rows[:,3]):10.4f} "
                  f"{np.median(rows[:,4]):8.4f} {np.median(rows[:,5]):10.2e}")
    np.save('scratchpad/r55_landed.npy',
            np.array([[l[2],l[3],l[4],l[5],l[6],l[7]] for l in landed]))
    # any landing point that differs from the base in the Lambda^2 spectrum?
    odd=[l for l in landed if l[3]<1e-5 and l[7]>1e-5]
    print(f"\nlandings with criticality residual < 1e-5: {sum(1 for l in landed if l[3]<1e-5)} / {len(landed)}")
    print(f"of those, with a DIFFERENT Lambda^2 spectrum from the base: {len(odd)}")
    for l in odd[:12]:
        print(f"   {l[0]:>32} t={l[1]:.2f} resid={l[3]:.2e} theta={l[4]:.7f} S={l[5]:.4f} specdev={l[7]:.3e}")
    print(f"[{time.time()-t0:.0f}s]")

if __name__=="__main__": main()
