"""Claim 5: coordinate-diagonal Weyl tensor with <=2 negative eigenvalues is a padded Weyl_4."""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *

def diagW(n,w):
    pr=pairs(n); N=len(pr)
    return np.diag(np.array([w[i,j] for (i,j) in pr]))

print('=== (a) diagonal + zero row sums really is in Weyl_n (Bianchi automatic?) ===')
rng=np.random.default_rng(0)
for n in [5,6,7]:
    A=rng.standard_normal((n,n)); w=A+A.T; np.fill_diagonal(w,0)
    # project to zero row sums, zero diagonal, symmetric
    for _ in range(500):
        rs=w.sum(1); w=w-(np.add.outer(rs,rs))/(n-2)+ (rs.sum())/((n-1)*(n-2))
        np.fill_diagonal(w,0); w=(w+w.T)/2
    W=diagW(n,w)
    print('  n=%d  max|rowsum|=%.1e  Bianchi=%.1e  |Ric|=%.1e'%(n,np.max(np.abs(w.sum(1))),bianchi_resid(W,n),np.max(np.abs(ricci(W,n)))))

print()
print('=== (b) exhaustive search: diagonal Weyl_n with at most 2 negative entries -- what support sizes occur? ===')
from scipy.optimize import linprog
for n in [5,6,7,8]:
    pr=pairs(n); N=len(pr); found=set()
    for negset in itertools.chain(itertools.combinations(range(N),1), itertools.combinations(range(N),2)):
        # variables w_p ; constraints: rows sum 0 ; w_p >= 0 for p not in negset ; w_p <= -eps for p in negset
        Aeq=np.zeros((n,N))
        for p,(i,j) in enumerate(pr): Aeq[i,p]=1; Aeq[j,p]=1
        bounds=[(1e-6,None) if p not in negset else (None,-1e-6) for p in range(N)]
        # maximise total mass to get a generic interior solution
        c=-np.ones(N); c[list(negset)]=1.0
        res=linprog(c,A_eq=Aeq,b_eq=np.zeros(n),bounds=[(-10,10)]*N if False else
                    [(1e-6,10) if p not in negset else (-10,-1e-6) for p in range(N)],method='highs')
        if res.status==0:
            w=res.x; sup=set()
            for p,(i,j) in enumerate(pr):
                if abs(w[p])>1e-7: sup.add(i); sup.add(j)
            found.add(len(sup))
    # also: allow zero entries (support may be smaller) -> feasibility with >=0 not >0 off negset
    print('  n=%d  support sizes attainable with <=2 negative entries: %s'%(n,sorted(found) if found else 'INFEASIBLE (none)'))

print()
print('=== (c) but zero entries are allowed: redo with w_p >= 0 (not >0) off the negative set ===')
for n in [5,6,7,8]:
    pr=pairs(n); N=len(pr); sizes=set(); examples=[]
    for negset in itertools.chain([()],itertools.combinations(range(N),1), itertools.combinations(range(N),2)):
        Aeq=np.zeros((n,N))
        for p,(i,j) in enumerate(pr): Aeq[i,p]=1; Aeq[j,p]=1
        bnds=[(0,10) if p not in negset else (-10,-1e-6) for p in range(N)]
        # maximise sum of positive entries -> largest possible support
        c=np.zeros(N); c[[p for p in range(N) if p not in negset]]=-1.0
        res=linprog(c,A_eq=Aeq,b_eq=np.zeros(n),bounds=bnds,method='highs')
        if res.status==0:
            w=res.x; sup=set()
            for p,(i,j) in enumerate(pr):
                if abs(w[p])>1e-7: sup.add(i); sup.add(j)
            sizes.add(len(sup))
            if len(sup)>4: examples.append((negset,np.round(w,4)))
    print('  n=%d  support sizes: %s   support>4 examples: %d'%(n,sorted(sizes),len(examples)))
    if examples: print('      ',examples[0])

print()
print('=== (d) max theta over diagonal Weyl_4 with <=2 negative eigenvalues ===')
# diagonal Weyl_4: w12=w34=p, w13=w24=q, w14=w23=r, p+q+r=0
import sympy as sp
best=(-9,None)
for p in np.linspace(-1,1,401):
    for q in np.linspace(-1,1,401):
        r=-p-q
        vals=np.array([p,q,r])
        if np.sum(vals<-1e-12)>1: continue     # each appears twice -> at most one negative value
        nrm=np.sqrt(2*(p*p+q*q+r*r))
        if nrm<1e-9: continue
        w=np.zeros((4,4))
        w[0,1]=w[1,0]=w[2,3]=w[3,2]=p/nrm
        w[0,2]=w[2,0]=w[1,3]=w[3,1]=q/nrm
        w[0,3]=w[3,0]=w[1,2]=w[2,1]=r/nrm
        W=diagW(4,w); t=theta(W,4)
        if t>best[0]: best=(t,(p/nrm,q/nrm,r/nrm))
print('  max theta over the coordinate-diagonal <=2-negative family in dim 4: %.9f'%best[0],
      ' (p,q,r)=',np.round(best[1],5),'   sqrt(3/2)=%.9f'%np.sqrt(1.5))
