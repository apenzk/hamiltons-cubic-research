"""E1 (f): add the exact invariant  tr(W^#) = -||W||^2  and re-solve the relaxation."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, itertools, math, sys
from scipy.optimize import linprog
from scipy.sparse import coo_matrix, vstack
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r26_core import *

def theta0(n): return math.sqrt(2*(n-1)*(n-2))/n

def build(N, repeat_free=True):
    """precompute LP structure independent of w"""
    if repeat_free:
        taus = [t for t in itertools.combinations(range(N),3)]
    else:
        taus = [t for t in itertools.combinations_with_replacement(range(N),3)]
    nt = len(taus)
    pair_id = {}
    for ab in itertools.combinations(range(N),2): pair_id[ab]=len(pair_id)
    ri,rj,rv = [],[],[]
    pi_,pj,pv = [],[],[]
    permcount = []
    for k,tau in enumerate(taus):
        Pm = sorted(set(itertools.permutations(tau)))
        permcount.append(Pm)
        cnt={}
        for p in Pm: cnt[p[0]]=cnt.get(p[0],0)+1
        for a,c in cnt.items(): ri.append(a); rj.append(k); rv.append(float(c))
        c2={}
        for p in Pm:
            if p[0]==p[1]: continue
            c2[(p[0],p[1])]=c2.get((p[0],p[1]),0)+1
        for (a,b),c in c2.items():
            key=(a,b) if a<b else (b,a)
            pi_.append(pair_id[key]); pj.append(k); pv.append(float(c)/2.0)
    Arow = coo_matrix((rv,(ri,rj)),shape=(N,nt)).tocsr()
    Apair= coo_matrix((pv,(pi_,pj)),shape=(len(pair_id),nt)).tocsr()
    return taus, permcount, Arow, Apair

def solve(n, w, taus, permcount, Arow, Apair, use_trace=True, Cpair=2.0):
    N = len(w); kappa=2.0*(n-2)
    nt=len(taus)
    obj=np.empty(nt); trv=np.empty(nt)
    for k,Pm in enumerate(permcount):
        t=taus[k]
        obj[k]=0.5*len(Pm)*w[t[0]]*w[t[1]]*w[t[2]]
        trv[k]=0.5*sum(w[p[1]]*w[p[2]] for p in Pm)
    A_eq=[Arow]; b_eq=[np.full(N,kappa)]
    if use_trace:
        A_eq.append(coo_matrix(trv.reshape(1,-1))); b_eq.append(np.array([-1.0]))
    A_eq=vstack(A_eq).tocsr(); b_eq=np.concatenate(b_eq)
    res=linprog(-obj, A_ub=Apair, b_ub=np.full(Apair.shape[0],Cpair),
                A_eq=A_eq, b_eq=b_eq, bounds=(0,None), method='highs')
    if not res.success: return None, res
    return (w**3).sum() - res.fun, res

def rand_w(N, rng):
    w=rng.normal(size=N); w-=w.mean(); return w/np.linalg.norm(w)

def twoblock_w(N,p):
    s=math.sqrt(p*(N-p)/N); w=np.array([s/p]*p+[-s/(N-p)]*(N-p)); return w

for n in [5,6,7]:
    N=n*(n-1)//2
    taus,pc,Arow,Apair = build(N, repeat_free=True)
    print(f"\n=== n={n}, N={N}, {len(taus)} LP variables, theta0={theta0(n):.6f} ===")
    rng=np.random.default_rng(5)
    for label,use_trace in [("NO trace constraint (as claimed)",False),
                            ("WITH tr(W^#)=-1 (the missing constraint)",True)]:
        best=-1e9; bestw=None
        cands=[twoblock_w(N,p) for p in range(2,N-1)]+[rand_w(N,rng) for _ in range(25)]
        # add the actual eigenvalue spectrum of the balanced sphere product
        C=struct_const(n); B=weyl_basis(n)
        for lab in range(1):
            pass
        for w in cands:
            v,res=solve(n,w,taus,pc,Arow,Apair,use_trace=use_trace)
            if v is not None and v>best: best,bestw=v,w
        # local ascent over w
        for it in range(400):
            w=bestw+ (0.15*(0.98**it))*rand_w(N,rng)
            w-=w.mean(); w/=np.linalg.norm(w)
            v,res=solve(n,w,taus,pc,Arow,Apair,use_trace=use_trace)
            if v is not None and v>best: best,bestw=v,w
        print(f"  {label:45s}  relaxation max ~ {best:.6f}   ratio to theta0 = {best/theta0(n):.4f}")
