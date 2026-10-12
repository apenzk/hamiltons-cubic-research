"""Joint relaxation with K's own structure carried: K hollow symmetric, zero row sums.

For each admissible K the two inner problems are
   max p3(mu) s.t. mu > d_phi, sum mu = 0, sum mu^2 = 1
   min p3(om)  s.t. om > d,     sum om = 0, sum om^2 = 3
Majorization only LOWER-bounds spread, and Okumura maximises |p3| at fixed norm, so each
inner optimum is the Okumura value EXACTLY WHEN the Okumura vector majorizes the diagonal.
That is a cumulative-sum test -- exact, cheap, and needs no optimiser.  Where it fails the
constraint genuinely bites and the value must be computed.
"""
import numpy as np, itertools
rng=np.random.default_rng(113)
def okum(D,s2,sign=+1):
    b=np.sqrt(s2/(D*(D-1))); x=np.full(D,b); x[-1]=-(D-1)*b
    return sign*x
def majorizes(x,y,tol=1e-10):
    """does x majorize y?"""
    sx=np.sort(x)[::-1]; sy=np.sort(y)[::-1]
    return (np.cumsum(sx)-np.cumsum(sy)).min() >= -tol, (np.cumsum(sx)-np.cumsum(sy)).min()
def randK(n,t,rng):
    """random hollow symmetric with zero row sums, scaled to ||K||_F^2 = t."""
    A=rng.standard_normal((n,n)); K=(A+A.T)/2; np.fill_diagonal(K,0)
    for _ in range(500):
        r=K.sum(1)/(n-2)
        K=K-np.add.outer(r,r)+ (K.sum()/((n-1)*(n-2)))
        np.fill_diagonal(K,0); K=(K+K.T)/2
    nrm=np.linalg.norm(K)
    if nrm<1e-12: return None
    return K*np.sqrt(t)/nrm
def diags(K,n):
    pr=list(itertools.combinations(range(n),2))
    dphi=np.array([K[a,b] for (a,b) in pr])
    w,V=np.linalg.eigh(K); v1=np.ones(n)/np.sqrt(n)
    keep=[i for i in range(n) if abs(V[:,i]@v1)<0.9]
    return dphi, np.concatenate([dphi,-w[keep]])
for n in [6,8,12]:
    Dm=n*(n-1)//2; Do=(n-1)*(n+2)//2
    t0=np.sqrt(2*(n-1)*(n-2))/n
    print(f"\nn={n}  theta_0={t0:.6f}   (Okumura-feasible => relaxation = 4.0129-class, i.e. useless)")
    print(f"  {'t':>6} {'rowsum err':>11} {'mu-side Okumura feasible?':>26} {'om-side feasible?':>19}")
    for t in [0.5,1.0,1.5,1.8,1.95,1.999,2.0]:
        okm=oko=0; trials=6; worst=(9,9)
        for _ in range(trials):
            K=randK(n,t,rng)
            if K is None: continue
            dphi,d=diags(K,n)
            fm,sm=majorizes(okum(Dm,1.0,-1),dphi)      # the p3-MAXIMISING mu is -okum
            fo,so=majorizes(okum(Do,3.0,+1),d)         # the p3-MINIMISING omega is +okum
            okm+=fm; oko+=fo; worst=(min(worst[0],sm),min(worst[1],so))
            rs=np.abs(K.sum(1)).max()
        print(f"  {t:6.3f} {rs:11.1e} {f'{okm}/{trials}  (slack {worst[0]:+.3f})':>26} {f'{oko}/{trials}  (slack {worst[1]:+.3f})':>19}")
