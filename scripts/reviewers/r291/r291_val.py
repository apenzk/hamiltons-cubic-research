import sys, numpy as np
sys.path.insert(0,'scripts/lib'); sys.path.insert(0,'scripts/reviewers/r291')
from r291_core import *
from b_symmetry_defect import defect as record_defect
rng=np.random.default_rng(3)
print("validate the fast diagonal path against the record's defect() and my slow path:")
for n in (4,5,6,7,8):
    B=locus_basis(n)
    for t in range(2):
        M=rand_M(n,rng,B); W=M_to_W(M)
        D1,t1,S1,_,_=defect_diag(n,M)
        D2,t2,S2,_,_=defect_mine(n,W)
        th,isw,d,Dr,tr,Sr,Sp,z=record_defect(n,W)
        print(f"  n={n}: fast({D1:.10f},{S1:.1f}) slow({D2:.10f},{S2:.1f}) record({Dr:.10f},{Sr:.1f})"
              f"  theta mine={theta_diag(M):+.8f} record={th:+.8f}")
