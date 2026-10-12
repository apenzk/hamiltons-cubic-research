"""Hunt: diagonal critical points with Delta>0, theta>0 and lam_max(calL) <= theta/2."""
import sys; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C
from r304_solve import find, signature
from r304_weyl import weyl_basis
from r304_j3 import analyse

n=int(sys.argv[1]); tries=int(sys.argv[2]); seed=int(sys.argv[3]) if len(sys.argv)>3 else 7
sols=find(n,tries,seed=seed)
c=C.struct_consts(n); WB=weyl_basis(n)
seen={}
for M,r in sols:
    th=C.theta_of(M)
    key=(round(th,6),signature(M,4))
    if key in seen: continue
    seen[key]=M
print(f"n={n}: {len(sols)}/{tries} converged, {len(seen)} distinct")
hits=[]
for key,M in sorted(seen.items(), key=lambda kv:-kv[0][0]):
    d=analyse(f"pt", M, n, c, WB)
    if d['theta']>1e-8 and d['delta']>1e-7 and d['lam_diag']<=d['theta']/2+1e-9:
        hits.append((M,d)); print("   *** DIAGONAL-HALF V3 VIOLATION CANDIDATE ***")
    ker=int(np.sum(np.abs(np.linalg.eigvalsh(M))<1e-9))
    if ker>=2:
        V=np.linalg.eigh(M)[1][:,np.abs(np.linalg.eigvalsh(M))<1e-9]
        best=0
        for k in range(V.shape[1]):
            a=V[:,k]; N=2*M*(a[:,None]+a[None,:])
            resid=np.linalg.norm(N-np.sum(M*N)/2*M)
            best=max(best,resid)
        print(f"     dimker={ker} max||N - proj_M N||={best:.4e}")
np.save(f"/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/hits_n{n}.npy", np.array([h[0] for h in hits]) if hits else np.zeros((0,n,n)))
