import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np
from scipy.optimize import least_squares
SP=_os.path.join(_ROOT, 'scripts/reviewers/r121/')
exec(open(SP+'r121_noncritical_and_projection.py').read().split('print("=== (b/d)')[0])

def weyl_basis(n,rng):
    d = n*(n+1)*(n+2)*(n-3)//12
    V=[]
    while len(V)<d:
        T=weyl_project(rng.standard_normal((n,n,n,n))).ravel()
        for u in V: T-=np.dot(T,u)*u
        nn=np.linalg.norm(T)
        if nn>1e-8: V.append(T/nn)
    return np.array(V), d

def scan(n,starts,rng):
    Bw,d=weyl_basis(n,rng)
    def toW(x): return (x@Bw).reshape(n,n,n,n)
    def res(x):
        W=toW(x); nW=np.sqrt(op_norm2(W))
        Wn=W/nW; QW=Q(Wn); th=ip4(Wn,QW)
        r=(QW-th*Wn).reshape(-1)@Bw.T
        return np.concatenate([r,[np.dot(x,x)-1]])
    found=[]
    for s in range(starts):
        x0=rng.standard_normal(d); x0/=np.linalg.norm(x0)
        sol=least_squares(res,x0,xtol=1e-14,ftol=1e-14,gtol=1e-14,max_nfev=400)
        if np.linalg.norm(sol.fun)>1e-9: continue
        W=toW(sol.x); W/=np.sqrt(op_norm2(W))
        th=ip4(W,Q(W))
        if th<1e-6: continue
        found.append((th,W))
    return found

for n in [5,6]:
    rng=np.random.default_rng(2024+n)
    F=scan(n,300 if n==5 else 200,rng)
    vals=sorted(set(round(t,7) for t,_ in F))
    print(f"--- n={n}: {len(F)} critical pts w/ theta>0, {len(vals)} distinct theta, max {max(vals) if vals else None}")
    worst=None
    for th,W in F:
        ev,h=bottom(W); mu=-ev[0]; L=sum(LOSS(W,h))
        cd = th - max(np.sqrt(1.5),(n-1)/n*mu)
        if worst is None or cd>worst[0]: worst=(cd,th,mu,L,L-mu*mu/n)
    if worst: print(f"    worst CD_n margin theta-max{{sqrt(3/2),(n-1)/n mu}} = {worst[0]:+.6f} at theta={worst[1]:.6f} mu={worst[2]:.6f} LOSS-mu^2/n={worst[4]:+.6f}")
    # list the branch-1 violators (LOSS<mu^2/n) and their theta
    v1=[(th,) for th,W in F]
    tops=sorted(F,key=lambda z:-z[0])[:6]
    for th,W in tops:
        ev,h=bottom(W); mu=-ev[0]; L=sum(LOSS(W,h))
        print(f"     theta={th:.7f} mu={mu:.6f} (n-1)/n mu={(n-1)/n*mu:.6f} LOSS-mu^2/n={L-mu*mu/n:+.6f} CD ok? {th<=max(np.sqrt(1.5),(n-1)/n*mu)+1e-9}")

print()
print("=== equality family beyond sphere products: 4+4 blocks, cross gamma, within (a,b,c) with a+b+c=-4gamma ===")
def blockW(n,S):
    W=np.zeros((n,n,n,n))
    for i in range(n):
        for j in range(n):
            if i!=j: W[i,j,i,j]+=S[i,j]; W[i,j,j,i]-=S[i,j]
    return W
n=8; g=-1.0
for (a,b,c) in [(1.0,1.0,2.0),(0.5,1.5,2.0),(-1.0,2.0,3.0),(4.0,0.0,0.0)]:
    if abs(a+b+c-(-4*g))>1e-12: continue
    S=np.zeros((8,8))
    pairs={(0,1):a,(2,3):a,(0,2):b,(1,3):b,(0,3):c,(1,2):c}
    for (i,j),v in pairs.items(): S[i,j]=S[j,i]=v; S[i+4,j+4]=S[j+4,i+4]=v
    for i in range(4):
        for j in range(4,8): S[i,j]=S[j,i]=g
    W=blockW(8,S)
    if np.abs(ricci(W)).max()>1e-10: print("  not Ricci flat",a,b,c); continue
    W/=np.sqrt(op_norm2(W)); ev,h=bottom(W); mu=-ev[0]; L=sum(LOSS(W,h))
    th=ip4(W,Q(W)); r=np.abs(Q(W)-th*W).max()
    print(f"  (a,b,c)=({a},{b},{c}) theta={th:.6f} crit_res={r:.1e} mu={mu:.6f} LOSS-mu^2/n={L-mu*mu/n:+.3e} v={np.round(np.diag(h),4)}")

print()
print("=== padded CP^2: N and h ===")
Wc=pad(cp2(),8); Wc/=np.sqrt(op_norm2(Wc))
N=np.einsum('impq,kmpq->ik',Wc,Wc); ev,h=bottom(Wc)
print("  N eig",np.round(np.linalg.eigvalsh(N),6)," 0.5*tr(N h^2)=",0.5*np.trace(N@h@h)," 0.5 lam_max(N)=",0.5*np.linalg.eigvalsh(N).max())
print("  h diag",np.round(np.diag(h),5)," offdiag",np.abs(h-np.diag(np.diag(h))).max())
u=np.einsum('ikpq->pqik',Wc); C=np.einsum('ipjq->pqij',Wc); comm=u@h-h@u
print("  t1=",0.25*np.einsum('pqij,pqij->',comm,comm)," t2=",np.einsum('pqij,pqji->',C@h,C@h)," t3=",-0.5*np.trace(N@h@h))
