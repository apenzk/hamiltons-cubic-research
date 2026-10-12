import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
from k1defs import sphere_M, direct_sum, components, solve_crit

print("=== the CORRECTED admissibility condition:  sum_c a_c theta_c^{-2} = 0 ===")
for spec in [[(3,3),(4,4)],[(3,5),(3,3)],[(4,4),(5,5)],[(2,2),(2,3),(3,3)]]:
    Ms=[];ths=[]
    for s in spec:
        Mi=sphere_M(*s); r,t=crit_res(Mi); Ms.append(Mi); ths.append(t)
    M,th=direct_sum(Ms,ths); n=M.shape[0]; k,lab=components(M)
    ths=np.array(ths)
    # block norm shares
    shares=np.array([np.sum(M[np.ix_(np.where(lab==cc)[0],np.where(lab==cc)[0])]**2) for cc in range(k)])
    pred=2*(th/ths)**2
    # choose a with sum a_c * share_c = 0
    vals=np.ones(k); vals[0]= -np.sum(shares[1:])/shares[0]
    a=np.zeros(n)
    for cc in range(k): a[lab==cc]=vals[cc]
    Nm=2*M*(a[:,None]+a[None,:])
    print(f"  {'(+)'.join('S%dxS%d'%s for s in spec):22s} shares={np.round(shares,6)} pred 2(th/th_i)^2={np.round(pred,6)} "
          f"<W,N>={np.sum(M*Nm):+.2e} rowsums={np.abs(Nm.sum(1)).max():.1e} ||LN-thN||={np.abs(Lcal(M,Nm)-th*Nm).max():.1e}")

print("\n=== edge case: a summand with theta_i = 0 ===")
rng=np.random.default_rng(11)
zero_th=[]
for trial in range(600):
    n=int(rng.integers(5,9))
    M,r,t=solve_crit(n,trial,rng)
    if r>1e-12: continue
    if abs(t)<1e-9:
        k,_=components(M)
        zero_th.append((n,M,t,k))
print(f"  diagonal critical points with theta = 0 found: {len(zero_th)}"
      + (f" (first: n={zero_th[0][0]}, comps={zero_th[0][3]}, theta={zero_th[0][2]:.2e})" if zero_th else ""))
if zero_th:
    n0,M0,t0,_=zero_th[0]
    M1=sphere_M(3,3); r1,t1=crit_res(M1)
    n=n0+6; M=np.zeros((n,n)); M[:n0,:n0]=M0; M[n0:,n0:]=M1
    M=M/np.linalg.norm(M)*np.sqrt(2)
    r,th=crit_res(M)
    print(f"  naive equal-scaled sum with a theta=0 block: crit_res={r:.3e} -> the theta law's formula is undefined there")
