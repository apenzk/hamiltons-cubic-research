"""Is the diagonal criticality relaxation lossy at the extremum?  It is not, at n=6..12.

THE DERIVATION THIS TESTS.  Criticality written in bracket coordinates ([bounds.md](../../findings/bounds.md))
is  M_kl = 2 lambda_k (lambda_k - theta) delta_kl  for M_kl = tr(ad(phi_k) W ad(phi_l) W).
Its DIAGONAL half is N constraints on T_{k al be} = c_{k al be}^2,

    sum_{al<be} T_{k al be} = n-2                          (row mass, every k)
    sum_{al<be} lam_al lam_be T_{k al be} = lam_k(theta - lam_k)   (every k)

where every earlier relaxation on this record used only the k = lambda_min row.  T vanishes
whenever two indices coincide, by antisymmetry of the bracket.  Maximising theta over
T >= 0 at a FIXED spectrum is then an exact LP.

WHAT IT DECIDES.  Post 34 closes any route whose bound is lossy at the equality family.
Every relaxation the record has tried IS lossy there -- post 10's marginal LP returns
1.6059 against theta_0(6) = 1.0541, and the pairing-kept LP returns 1.2026.  If this one
returns theta_0(n) exactly at the balanced spectrum, it is the first that is not.

WHAT IT DOES NOT DECIDE, AND THE DISTINCTION IS THE WHOLE POINT.  The spectrum is held
FIXED at the balanced product's.  The conjecture is a statement over ALL spectra, and this
LP says nothing about the others: at the padded W_CP2 spectrum at n=6 the same LP returns
1.224745, correctly, that point being a genuine critical point above theta_0(6).  So a
tight column here is evidence that the constraint set is not lossy at the extremum, and is
not a bound on theta.
"""
import sys, os, time, numpy as np
from itertools import combinations
from scipy.optimize import linprog
from scipy.sparse import coo_matrix
sys.path.insert(0,'scripts/reviewers/r319'); import build
print(f"PID {os.getpid()} | LP over the N diagonal criticality relations, at the balanced spectrum",flush=True)
def rng_theta(ev,n):
    N=len(ev); tri=list(combinations(range(N),3)); pos={t:i for i,t in enumerate(tri)}; nv=len(tri)
    byk=[[] for _ in range(N)]
    for t in tri:
        for k in t: byk[k].append(t)
    r=[];c=[];d=[];beq=[]
    for k in range(N):
        for t in byk[k]: r.append(k); c.append(pos[t]); d.append(1.0)
        beq.append(n-2.0)
    for k in range(N):
        for t in byk[k]:
            a,b=[x for x in t if x!=k]
            r.append(N+k); c.append(pos[t]); d.append(ev[a]*ev[b])
        r.append(N+k); c.append(nv); d.append(-ev[k]); beq.append(-ev[k]**2)
    Aeq=coo_matrix((d,(r,c)),shape=(2*N,nv+1)).tocsr()
    out=[]
    for sgn in (-1.0,1.0):
        o=np.zeros(nv+1); o[nv]=sgn
        res=linprog(o,A_eq=Aeq,b_eq=np.array(beq),bounds=[(0,None)]*nv+[(None,None)],method='highs')
        out.append((-res.fun if sgn<0 else res.fun) if res.status==0 else None)
    return out,nv
for n in (6,8,10,12):
    t0=time.time(); A=build.Arena(n)
    W=build.unit(build.subalg_casimir(n,build.so_pq_basis(n,n//2)))
    th=A.P3(W); ev=np.linalg.eigvalsh(W); th0=np.sqrt(2*(n-1)*(n-2))/n
    (hi,lo),nv=rng_theta(ev,n)          # rng_theta returns (max, min), in that order
    print(f"n={n:3d}  vars={nv:6d}  theta_0={th0:.9f}  true={th:.9f}  LP range=[{lo:.9f}, {hi:.9f}]  "
          f"{'TIGHT at theta_0' if abs(hi-th0)<1e-7 else 'overshoots by %.6f'%(hi-th0)}  ({time.time()-t0:.0f}s)",flush=True)
print("DONE",flush=True)
