import numpy as np
from scipy.optimize import linprog
# Necessary condition for a spectrum to come from a Weyl tensor:
#   exists R >= 0, symmetric, zero diagonal, entries <= 2, row sums 2(n-2),
#   with R lam = -2 lam.   (All four hold for every Weyl tensor.)
# Maximise the min-bound ONLY over spectra passing this filter.
def feasible(lam,n):
    N=len(lam); idx=[(i,j) for i in range(N) for j in range(i+1,N)]; nv=len(idx)
    A=[];b=[]
    for a in range(N):
        row=np.zeros(nv)
        for k,(i,j) in enumerate(idx):
            if i==a: row[k]=lam[j]
            elif j==a: row[k]=lam[i]
        A.append(row); b.append(-2*lam[a])
    for a in range(N):
        row=np.zeros(nv)
        for k,(i,j) in enumerate(idx):
            if i==a or j==a: row[k]=1.0
        A.append(row); b.append(2.0*(n-2))
    r=linprog(np.zeros(nv),A_eq=np.array(A),b_eq=np.array(b),bounds=(0,2),method='highs')
    return r.status==0
def bd(lam,n,N):
    P=lam[lam>1e-12]; ng=lam[lam<-1e-12]; d=len(ng)
    if d<1 or len(P)<1: return -9,0
    s=P.sum(); u=(P**2).sum(); v=(ng**2).sum(); l1=P.max(); b=-ng.min()
    top=np.sort(P)[::-1][:3]; h=3.0/np.sum(1.0/top) if len(top)>=3 else l1
    ppp=min(h*(s*s-u), l1**3*(n-2)*(2*N-3*d)/2.0)
    pmm=min(3*l1*(s*s-v), 1.5*l1*b*b*(n-2)*d)
    return (lam**3).sum()+ppp+pmm, d
def theta0(n): return (n-1)/n*np.sqrt(2*(n-2)/(n-1))
for n in (6,8):
    N=n*(n-1)//2; cap=n*n//4; rng=np.random.default_rng(4)
    bestF=(-9,0); bestU=(-9,0); nf=0; tried=0
    for _ in range(4000):
        d=int(rng.integers(3,min(cap,N-1)))
        ng=rng.random(d)**rng.uniform(.3,3); pos=rng.random(N-d)**rng.uniform(.3,3)
        pos=pos*ng.sum()/pos.sum(); lam=np.concatenate([-ng,pos]); lam/=np.linalg.norm(lam)
        val,dd=bd(lam,n,N); tried+=1
        if val>bestU[0]: bestU=(val,dd)
        if feasible(lam,n):
            nf+=1
            if val>bestF[0]: bestF=(val,dd)
    print(f"  n={n}: {nf}/{tried} spectra pass the realisability filter",flush=True)
    print(f"    max bound, unfiltered : {bestU[0]:9.4f} at d={bestU[1]}",flush=True)
    print(f"    max bound, FILTERED   : {bestF[0]:9.4f} at d={bestF[1]}"
          f"   target {max(theta0(n),np.sqrt(1.5)):.6f}",flush=True)
print("DONE",flush=True)
