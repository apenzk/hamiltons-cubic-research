"""Maximise theta over BOTH the spectrum and T -- and the sharpness does not survive it.

WHAT THIS DECIDES.  The diagonal criticality relaxation returns theta_0(n) exactly at the
BALANCED spectrum ([run_diag_criticality_lp.py](run_diag_criticality_lp.py)), which the
record read as sharpness on the equality family.  That reading is only worth something if
the relaxation stays tight when the spectrum is a variable, since the conjecture quantifies
over all spectra.  Here the spectrum is free: outer Nelder-Mead over lambda (trace-free,
unit norm), inner exact LP over T >= 0.

THE ANSWER IS NO.  At n=6 the relaxation reaches 1.590427 against a true maximum of
sqrt(3/2) = 1.224745 and theta_0(6) = 1.054093 -- and post 10's marginal LP, which the
record calls lossy, returns 1.6059.  So freeing the spectrum costs almost the whole
advantage: the N diagonal criticality relations buy about 0.016 over the marginals.
The search was still climbing at the last trial (1.466 -> 1.489 -> 1.542 -> 1.590), so
1.590427 is a LOWER bound on the relaxation's true maximum, and the gap to post 10 may be
smaller still.
"""
import sys, os, time, numpy as np
from itertools import combinations
from scipy.optimize import linprog, minimize
from scipy.sparse import coo_matrix
sys.path.insert(0,'scripts/reviewers/r319'); import build
n=6; A=build.Arena(n); N=A.N
th0=np.sqrt(2*(n-1)*(n-2))/n; TRUE=np.sqrt(1.5)
tri=list(combinations(range(N),3)); pos={t:i for i,t in enumerate(tri)}; nv=len(tri)
byk=[[] for _ in range(N)]
for t in tri:
    for k in t: byk[k].append(t)
print(f"PID {os.getpid()} | n={n} N={N} vars={nv} | theta_0={th0:.9f}  true max (padded CP^2)={TRUE:.9f}",flush=True)
def inner(ev):
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
    o=np.zeros(nv+1); o[nv]=-1.0
    res=linprog(o,A_eq=Aeq,b_eq=np.array(beq),bounds=[(0,None)]*nv+[(None,None)],method='highs')
    return -res.fun if res.status==0 else -1e3
def norm(x):
    x=x-x.mean(); nx=np.linalg.norm(x)
    return np.sort(x/nx) if nx>1e-12 else np.sort(np.linspace(-1,1,N))
best=(-1,None); rng=np.random.default_rng(0); t0=time.time()
for trial in range(40):
    x0=rng.standard_normal(N)
    r=minimize(lambda x:-inner(norm(x)),x0,method='Nelder-Mead',
               options=dict(maxfev=900,xatol=1e-6,fatol=1e-9))
    val=-r.fun
    if val>best[0]: best=(val,norm(r.x))
    if trial%8==7:
        print(f"  trial {trial+1:3d}: best so far {best[0]:.9f}   (vs true {TRUE:.9f})  [{time.time()-t0:.0f}s]",flush=True)
print(f"RESULT n={n}: relaxation max theta = {best[0]:.9f}  |  true max = {TRUE:.9f}  |  "
      f"{'EXACT' if abs(best[0]-TRUE)<1e-6 else 'overshoots by %.6f'%(best[0]-TRUE)}",flush=True)
print("  spectrum:",np.array2string(best[1],precision=6),flush=True)
print("DONE",flush=True)
