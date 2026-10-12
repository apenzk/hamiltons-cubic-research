"""J1 at a diagonal critical point with NO symmetry (trivial automorphism group)."""
import sys, itertools; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C
from r304_solve import find
rng=np.random.default_rng(9)

def autos(M, tol=1e-8):
    n=M.shape[0]; cnt=0
    for p in itertools.permutations(range(n)):
        P=np.eye(n)[list(p)]
        if np.abs(P@M@P.T-M).max()<tol: cnt+=1
    return cnt

n=8
sols=find(n,80,seed=777)
best=None
for M,r in sols:
    th=C.theta_of(M)
    if th<0.05: continue
    a=autos(M)
    if best is None or a<best[0]: best=(a,M,th)
    if a==1: break
a,M,th=best
d,_=C.defect_delta(M)
print(f"asymmetric candidate: |Aut|={a} theta={th:+.6f} Delta={d:.4f} res={np.abs(C.crit_residual(M)).max():.1e}")
np.set_printoptions(precision=5,suppress=True,linewidth=200); print(M)
c=C.struct_consts(n); W=C.diag_op(M); Bs=C.basis_hollow_zero_rowsum(n)
for t in range(4):
    v=rng.normal(size=len(Bs)); N=sum(vi*Bi for vi,Bi in zip(v,Bs)); N/=np.linalg.norm(N)
    LH=C.L_W(c,W,C.diag_op(N)); Mn=C.op_to_M(n,LH)
    print(f" t{t}: offdiag={C.offdiag_mass(n,LH):.2e} |true-hollowclaim|={np.abs(Mn-C.calL(M,N)).max():.2e} "
          f"|true-literalclaim|={np.abs(Mn-C.calL_full(M,N)).max():.3e} "
          f"J2err={abs(float(np.sum(N*C.calL(M,N)))-float(np.sum(M*N*N)+np.trace(M@N@N))):.2e}")
np.save('/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/asym8.npy',M)
