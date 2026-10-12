"""E1: re-verify the general-w LP optimum by rebuilding the returned T as a FULL ORDERED TENSOR
and re-checking every constraint and the objective from raw sums."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import numpy as np, itertools, math, sys
from scipy.optimize import linprog
from scipy.sparse import coo_matrix, vstack
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r26_e1_lp4 import build, twoblock, theta0

def solve_full(n,w,taus,Arow,Apair,use_trace,use_diag,Cpair=2.0):
    N=len(w); kappa=2.0*(n-2); nt=len(taus)
    wa,wb,wc=w[taus[:,0]],w[taus[:,1]],w[taus[:,2]]
    obj=3.0*wa*wb*wc
    A_eq=[Arow]; b_eq=[np.full(N,kappa)]
    if use_trace:
        trv=2.0*(wa*wb+wa*wc+wb*wc)
        A_eq.append(coo_matrix(trv.reshape(1,-1))); b_eq.append(np.array([-2.0]))
    A_ub=[Apair]; b_ub=[np.full(Apair.shape[0],Cpair)]
    if use_diag:
        di,dj,dv=[],[],[]
        for col in range(3):
            a=taus[:,col]; o1=taus[:,(col+1)%3]; o2=taus[:,(col+2)%3]
            di.append(a); dj.append(np.arange(nt)); dv.append(2.0*w[o1]*w[o2])
        D=coo_matrix((np.concatenate(dv),(np.concatenate(di),np.concatenate(dj))),shape=(N,nt)).tocsr()
        A_ub.append(D); b_ub.append(np.full(N,2.0)); A_ub.append(-D); b_ub.append(np.full(N,2.0))
    A_eq=vstack(A_eq).tocsr(); b_eq=np.concatenate(b_eq)
    A_ub=vstack(A_ub).tocsr(); b_ub=np.concatenate(b_ub)
    r=linprog(-obj,A_ub=A_ub,b_ub=b_ub,A_eq=A_eq,b_eq=b_eq,bounds=(0,None),method='highs')
    if not r.success: return None,None
    return (w**3).sum()-r.fun, r.x

def audit_T(n,w,taus,t):
    N=len(w); T=np.zeros((N,N,N))
    for k,(a,b,c) in enumerate(taus):
        v=t[k]
        for p in itertools.permutations((a,b,c)): T[p]=v
    row=T.sum(axis=(1,2)); pair=T.sum(axis=2)
    obj=(w**3).sum()+0.5*np.einsum('a,b,c,abc->',w,w,w,T,optimize=True)
    tr=0.5*np.einsum('abc,b,c->',T,w,w)
    V=0.5*np.einsum('abc,b,c->a',T,w,w)
    return dict(minT=T.min(), row=(row.min(),row.max()), pair=pair.max(), obj=obj,
                trsharp=tr, maxV=np.abs(V).max(),
                sym=max(np.abs(T-np.transpose(T,p)).max() for p in [(0,2,1),(1,0,2),(2,1,0)]))

for n in [6,7]:
    N=n*(n-1)//2
    taus,Arow,Apair=build(N)
    rng=np.random.default_rng(77)
    best=(-1e9,None)
    # seeds: two-block + random, then ascent
    cands=[twoblock(N,p) for p in range(3,N-2)]+[ (lambda v: (v-v.mean())/np.linalg.norm(v-v.mean()))(rng.normal(size=N)) for _ in range(40)]
    for w in cands:
        v,t=solve_full(n,w,taus,Arow,Apair,True,True)
        if v is not None and v>best[0]: best=(v,w)
    cur=best[1]
    for it in range(500):
        w=cur+0.25*(0.99**it)*rng.normal(size=N); w-=w.mean(); w/=np.linalg.norm(w)
        v,t=solve_full(n,w,taus,Arow,Apair,True,True)
        if v is not None and v>best[0]: best=(v,w); cur=w
    v,t=solve_full(n,best[1],taus,Arow,Apair,True,True)
    a=audit_T(n,best[1],taus,t)
    print(f"n={n}: general-w LP optimum (S3 constraint set) = {v:.6f}   theta0 = {theta0(n):.6f}")
    print(f"   independent audit of the returned T as a full ordered tensor:")
    print(f"     min T = {a['minT']:.3e}   symmetry = {a['sym']:.2e}   row marginals [{a['row'][0]:.8f},{a['row'][1]:.8f}] (kappa={2*(n-2)})")
    print(f"     max pair marginal = {a['pair']:.8f} (<=2)   tr(W^#) = {a['trsharp']:.8f} (=-1)   max|V_a| = {a['maxV']:.6f} (<=1)")
    print(f"     objective recomputed from raw ordered sum = {a['obj']:.8f}")
    print(f"     eigenvalue vector w (sorted) = {np.sort(best[1])}")
