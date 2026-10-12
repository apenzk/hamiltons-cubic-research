"""U3: ceiling of the 'all rows, pairing kept' relaxation, maximised over spectra."""
import numpy as np, itertools, sys
from scipy.optimize import linprog

def make(n):
    N=n*(n-1)//2
    tri=[tuple(s) for s in itertools.combinations(range(N),3)]
    tidx={s:i for i,s in enumerate(tri)}
    inc=[[] for _ in range(N)]
    for i,s in enumerate(tri):
        for a in s: inc[a].append((i,[x for x in s if x!=a]))
    return N,tri,tidx,inc

def lp(lam,n,N,tri,inc,killmm):
    nt=len(tri)
    Aeq=np.zeros((2*N,nt+1)); beq=np.zeros(2*N)
    for a in range(N):
        for (i,(b,c)) in inc[a]: Aeq[a,i]=lam[b]*lam[c]
        Aeq[a,nt]=-lam[a]; beq[a]=-lam[a]**2
        for (i,_) in inc[a]: Aeq[N+a,i]=1.0
        beq[N+a]=n-2.0
    bounds=[(0,None)]*nt+[(None,None)]
    if killmm:
        neg=lam<0
        for i,s in enumerate(tri):
            if neg[s[0]] and neg[s[1]] and neg[s[2]]: bounds[i]=(0,0)
    c=np.zeros(nt+1); c[nt]=-1.0
    r=linprog(c,A_eq=Aeq,b_eq=beq,bounds=bounds,method='highs')
    return r.x[nt] if r.success else None

def norm_spec(mu,nu):
    nu=nu*abs(mu.sum())/nu.sum()
    l=np.concatenate([-np.abs(mu),np.abs(nu)]); return l/np.linalg.norm(l)

n=6; N,tri,tidx,inc=make(n)
th0=np.sqrt(2*(n-1)*(n-2))/n
rng=np.random.default_rng(31337)
print(f"n={n} theta_0={th0:.9f}  cap dim m = {n*n//4}")
overall={}
for D in range(1,n*n//4+1):
    best=-9; bestl=None
    for t in range(60):
        mu=np.abs(rng.standard_normal(D))+0.05; nu=np.abs(rng.standard_normal(N-D))+0.05
        l=norm_spec(mu,nu)
        v=lp(l,n,N,tri,inc,True)
        if v is not None and v>best: best,bestl=v,l.copy()
    if bestl is None:
        print(f'  dim m={D}: no feasible spectrum sampled'); continue
    # local hill-climb
    step=0.15
    for it in range(220):
        cand=bestl+step*rng.standard_normal(N)
        mu=cand[:D]; nu=cand[D:]
        if (mu>=0).any() or (nu<=0).any(): continue
        l=norm_spec(-mu,nu)
        v=lp(l,n,N,tri,inc,True)
        if v is not None and v>best: best,bestl=v,l.copy()
        if it%60==59: step*=0.55
    v_nokill=lp(bestl,n,N,tri,inc,False)
    overall[D]=(best,v_nokill)
    print(f"  dim m={D:2d}: ceiling(S_mmm=0 imposed)={best:.6f}   same spectrum without it={v_nokill:.6f}")
print("MAX over dim m <= cap:", max(v[0] for v in overall.values()), " vs theta_0 =",th0)
