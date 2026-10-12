"""E1: rigorous LOWER bounds on the constrained relaxation at the best two-block w, n=5..12."""
import numpy as np, itertools, math, sys, time
from scipy.optimize import linprog
from scipy.sparse import coo_matrix, vstack

def theta0(n): return math.sqrt(2*(n-1)*(n-2))/n

def build(N):
    taus=np.array(list(itertools.combinations(range(N),3)))
    pair_id={ab:i for i,ab in enumerate(itertools.combinations(range(N),2))}
    nt=len(taus)
    ri=np.concatenate([taus[:,0],taus[:,1],taus[:,2]])
    rj=np.tile(np.arange(nt),3); rv=np.full(3*nt,2.0)
    Arow=coo_matrix((rv,(ri,rj)),shape=(N,nt)).tocsr()
    pi_=[];pj=[];pv=[]
    for col in [(0,1),(0,2),(1,2)]:
        for k in range(nt):
            u,v=taus[k,col[0]],taus[k,col[1]]
            pi_.append(pair_id[(u,v)]); pj.append(k); pv.append(1.0)
    Apair=coo_matrix((pv,(pi_,pj)),shape=(len(pair_id),nt)).tocsr()
    return taus,Arow,Apair

def solve(n,w,taus,Arow,Apair,use_trace,use_diag,Cpair=2.0):
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
            coef=2.0*w[o1]*w[o2]
            di.append(a); dj.append(np.arange(nt)); dv.append(coef)
        D=coo_matrix((np.concatenate(dv),(np.concatenate(di),np.concatenate(dj))),shape=(N,nt)).tocsr()
        A_ub.append(D); b_ub.append(np.full(N,2.0)); A_ub.append(-D); b_ub.append(np.full(N,2.0))
    A_eq=vstack(A_eq).tocsr(); b_eq=np.concatenate(b_eq)
    A_ub=vstack(A_ub).tocsr(); b_ub=np.concatenate(b_ub)
    r=linprog(-obj,A_ub=A_ub,b_ub=b_ub,A_eq=A_eq,b_eq=b_eq,bounds=(0,None),method='highs')
    return None if not r.success else (w**3).sum()-r.fun

def twoblock(N,p):
    s=math.sqrt(p*(N-p)/N); return np.array([s/p]*p+[-s/(N-p)]*(N-p))

print(f"{'n':>3} {'N':>4} {'#vars':>7} | {'S1 repeat-free':>15} {'S2 +tr(W#)':>13} {'S3 +|V|<=1':>13} | {'theta0':>8} {'S3/th0':>7} {'S3/sqrt(n-2)':>13}")
for n in [5,6,7,8,9,10,12]:
    N=n*(n-1)//2
    t0=time.time(); taus,Arow,Apair=build(N)
    res={}
    for key,(ut,ud) in {'S1':(False,False),'S2':(True,False),'S3':(True,True)}.items():
        best=-1e9
        ps=sorted(set([p for p in range(max(3,n-2), min(N-3, 3*n))] + [N//2, N//3, N//4]))
        for p in ps:
            if p<3 or N-p<3: continue
            v=solve(n,twoblock(N,p),taus,Arow,Apair,ut,ud)
            if v is not None and v>best: best=v
        res[key]=best
    print(f"{n:>3} {N:>4} {len(taus):>7} | {res['S1']:>15.6f} {res['S2']:>13.6f} {res['S3']:>13.6f} | "
          f"{theta0(n):>8.6f} {res['S3']/theta0(n):>7.3f} {res['S3']/math.sqrt(n-2):>13.6f}   [{time.time()-t0:.0f}s]")
