import numpy as np, itertools
from scipy.optimize import linprog
def lpval(n,lam,killmm=False):
    N=n*(n-1)//2
    tri=[tuple(s) for s in itertools.combinations(range(N),3)]
    inc=[[] for _ in range(N)]
    for i,s in enumerate(tri):
        for a in s: inc[a].append((i,[x for x in s if x!=a]))
    nt=len(tri); Aeq=np.zeros((2*N,nt+1)); beq=np.zeros(2*N)
    for a in range(N):
        for (i,(b,c)) in inc[a]: Aeq[a,i]=lam[b]*lam[c]
        Aeq[a,nt]=-lam[a]; beq[a]=-lam[a]**2
        for (i,_) in inc[a]: Aeq[N+a,i]=1.0
        beq[N+a]=n-2.0
    bnd=[(0,None)]*nt+[(None,None)]
    if killmm:
        neg=lam<0
        for i,s in enumerate(tri):
            if all(neg[x] for x in s): bnd[i]=(0,0)
    c=np.zeros(nt+1); c[nt]=-1.0
    r=linprog(c,A_eq=Aeq,b_eq=beq,bounds=bnd,method='highs')
    return r.x[nt] if r.success else None
for n,dm in [(8,16),(10,25)]:
    N=n*(n-1)//2; dp=N-dm
    a=np.sqrt(2*(n-2)/(n-1))/n; b=a*n/(n-2)
    lam=np.array([-a]*dm+[b]*dp)
    th0=np.sqrt(2*(n-1)*(n-2))/n
    print(f"n={n}: balanced-product spectrum, LP theta = {lpval(n,lam):.12f}  theta_0 = {th0:.12f}"
          f"  (with S_mmm=0 imposed: {lpval(n,lam,True):.12f})")
