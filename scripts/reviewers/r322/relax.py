"""U3: how far can theta go if we keep ONLY the data the truncated walk identity supplies?
   Data kept: (i) the identity lam1(theta-lam1) = (1/2) sum_ab lam_a lam_b t_ab with t_ab = c_1ab^2;
              (ii) total mass sum t = 2(n-2);  (iii) row cap sum_b t_ab <= 2 (proved: sup|[v,phi]|^2 = 2);
              (iv) t_1a = 0 (ad(v)v = 0);  (v) truncation t_ab = 0 for a,b both in m  (S_mmm = 0);
              (vi) spectrum: sum lam = 0, sum lam^2 = 1, lam_1 = min;  (vii) Lemma 36: dim m <= floor(n^2/4).
   Everything discarded is exactly frame-realizability of t."""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np
from scipy.optimize import linprog, minimize

def lp_value(lam, n, rowcap=2.0, use_trunc=True, use_rowcap=True):
    N=len(lam); mass=2*(n-2)
    m = lam < 0
    idx=[(a,b) for a in range(1,N) for b in range(a+1,N)]
    if use_trunc:
        idx=[(a,b) for (a,b) in idx if not (m[a] and m[b])]
    if not idx: return None
    cost=np.array([2*lam[a]*lam[b] for (a,b) in idx])   # t symmetric, both orderings
    Aeq=np.ones((1,len(idx)))*2.0; beq=[mass]
    Aub=[]; bub=[]
    if use_rowcap:
        for a in range(1,N):
            row=np.array([ (1.0 if (a in e) else 0.0) for e in idx])
            Aub.append(row); bub.append(rowcap)
    Aub=np.array(Aub) if Aub else None; bub=np.array(bub) if bub else None
    r=linprog(cost,A_ub=Aub,b_ub=bub,A_eq=Aeq,b_eq=beq,bounds=[(0,None)]*len(idx),method='highs')
    if not r.success: return None
    return r.fun     # = sum_ab lam_a lam_b t_ab (minimised)

def theta_bound(lam, n, **kw):
    lam=np.sort(lam)
    v=lp_value(lam,n,**kw)
    if v is None: return -1e9
    return lam[0] + v/(2*lam[0])

def search(n, ntrials=60, seed=0, **kw):
    N=n*(n-1)//2; rng=np.random.default_rng(seed); best=-1e9; barg=None
    cap=(n*n)//4
    def f(x):
        lam=np.sort(x); lam=lam-lam.mean(); nr=np.linalg.norm(lam)
        if nr<1e-9: return 1e9
        lam=lam/nr
        if lam[0]>=0: return 1e9
        if (lam<0).sum()>cap: return 1e9
        return -theta_bound(lam,n,**kw)
    for t in range(ntrials):
        x0=rng.normal(size=N)
        r=minimize(f,x0,method='Nelder-Mead',options={'maxiter':6000,'fatol':1e-10,'xatol':1e-8})
        if -r.fun>best: best=-r.fun; lam=np.sort(r.x); lam=lam-lam.mean(); barg=lam/np.linalg.norm(lam)
    return best,barg

if __name__=='__main__':
    for n in [6,8]:
        for kw in [dict(use_rowcap=False),dict(use_rowcap=True)]:
            b,lam=search(n,ntrials=25,seed=3,**kw)
            print(f'n={n} rowcap={kw["use_rowcap"]}  sup theta over the relaxation = {b:.6f}   dim m={int((lam<0).sum())}  cap floor(n^2/4)={(n*n)//4}')
            print('   lam =',np.round(lam,5))
