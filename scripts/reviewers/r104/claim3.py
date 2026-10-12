import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r104'))
import numpy as np, relax104 as R

def okumura_vec(N,S,positive=True):
    v=np.concatenate([[N-1.0],-np.ones(N-1)]) if positive else np.concatenate([np.ones(N-1),[-(N-1.0)]])
    v=np.sort(v)[::-1]
    return v*np.sqrt(S/np.sum(v**2))

def slack(N,S,d,positive=True):
    """min_j (cumsum okumura - cumsum d): >=0 means Okumura extremiser is feasible."""
    v=okumura_vec(N,S,positive); ds=np.sort(np.asarray(d))[::-1]
    return float(np.min(np.cumsum(v)[:-1]-np.cumsum(ds)[:-1]))

print("=== Claim 3: Okumura extremiser feasibility over vertex matrices ===")
print("analytic threshold: mu-side infeasible whenever t > 4/(n+1)\n")
rng=np.random.default_rng(31337)
rows=[]
for n in (6,8,12):
    N=n*(n-1)//2; D=n*(n+1)//2-1
    print(f"n={n}  (N={N}, D={D}, 4/(n+1)={4/(n+1):.4f})")
    for t in (0.05,0.1,0.2,0.3,0.5,1.0,1.5,1.95,2.0):
        smu=[];som=[]
        for _ in range(60):
            K=R.random_vertex_matrix(n,t,rng)
            dphi,d=R.d_from_K(K)
            smu.append(slack(N,1.0,dphi,True)); som.append(slack(D,3.0,d,False))
        # extremal K: try to MAKE it feasible -- one row concentrated / near-flat K
        Kf=np.ones((n,n))-np.eye(n); Kf=Kf*0.0
        # "flattest" vertex matrix: K = a(J-I) has row sums a(n-1) != 0, so use
        # K = a(J-I) - a*n/(n-1)*... instead sample many & keep best slack
        best_mu=max(smu); best_om=max(som)
        print(f"  t={t:<5} mu-side: feasible {sum(1 for s in smu if s>=0)}/60, best slack {best_mu:+.4f} | "
              f"om-side: feasible {sum(1 for s in som if s>=0)}/60, best slack {best_om:+.4f}")
