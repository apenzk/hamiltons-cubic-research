import sys; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C
from r304_solve import find, signature
np.set_printoptions(precision=4, suppress=True, linewidth=200)
n=int(sys.argv[1]); tries=int(sys.argv[2])
sols=find(n,tries,seed=1304+n)
seen={}
for M,r in sols:
    th=C.theta_of(M); key=(round(th,7),signature(M,5))
    seen.setdefault(key,(M,r))
for (th,sig),(M,r) in sorted(seen.items(), key=lambda kv:-kv[0][0]):
    ev=np.linalg.eigvalsh(M); ker=np.abs(ev)<1e-9
    d,_=C.defect_delta(M)
    print(f"=== theta={th:+.6f} Delta={d:.4f} dimker={ker.sum()} res={r:.1e}")
    print(M)
    if ker.sum()>=2:
        V=np.linalg.eigh(M)[1][:,ker]
        print("  kernel basis (cols):"); print(V)
        # is every kernel vector a in span{1} plus 'padding'?
        for k in range(V.shape[1]):
            a=V[:,k]; N=2*M*(a[:,None]+a[None,:])
            print(f"   a{k}: ||N||={np.linalg.norm(N):.4f} rowsum={np.abs(N.sum(1)).max():.1e} "
                  f"<M,N>={np.sum(M*N):+.4f} propto_M={np.linalg.norm(N-np.sum(M*N)/2*M):.4f}")
