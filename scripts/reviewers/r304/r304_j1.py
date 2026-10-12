import sys; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C
from r304_selfcheck import sphere_product
rng=np.random.default_rng(304)

def report(tag,M,n,c,trials=3):
    W=C.diag_op(M)
    Bs=C.basis_hollow_zero_rowsum(n)
    for t in range(trials):
        v=rng.normal(size=len(Bs)); N=sum(vi*Bi for vi,Bi in zip(v,Bs)); N/=np.linalg.norm(N)
        H=C.diag_op(N)
        LH=C.L_W(c,W,H)
        off=C.offdiag_mass(n,LH)
        Mn=C.op_to_M(n,LH)                       # true pair weights of L_W H
        claim_h=C.calL(M,N)                      # hollow(M o N + (MN+NM)/2)
        claim_f=C.calL_full(M,N)                 # as literally written
        rowsum=np.abs(Mn.sum(1)).max()
        print(f"{tag} t{t}: offdiag(L_W H)={off:.2e}  ||true-hollowclaim||={np.abs(Mn-claim_h).max():.2e}"
              f"  ||true-fullclaim||={np.abs(Mn-claim_f).max():.2e}"
              f"  diag(fullclaim)_max={np.abs(np.diag(claim_f)).max():.4f}  rowsum(L_W H)={rowsum:.2e}")

# 1. symmetric critical points
for (p,q) in [(3,5),(6,6)]:
    M=sphere_product(p,q); n=p+q; report(f"S{p}xS{q}",M,n,C.struct_consts(n))

# 2. NON-critical diagonal W
for n in [6,7]:
    Bs=C.basis_hollow_zero_rowsum(n)
    v=rng.normal(size=len(Bs)); M=sum(vi*Bi for vi,Bi in zip(v,Bs)); M*=np.sqrt(2/np.sum(M*M))
    print(f"noncritical n={n}: crit_res={np.abs(C.crit_residual(M)).max():.3e} theta={C.theta_of(M):.4f}")
    report(f"noncrit{n}",M,n,C.struct_consts(n))

# 3. a diagonal W that is NOT even Ricci-flat (row sums nonzero) - is diagonality still preserved?
n=6; M=np.zeros((n,n))
for i in range(n):
    for j in range(i+1,n): M[i,j]=M[j,i]=rng.normal()
c=C.struct_consts(n); W=C.diag_op(M)
N=np.zeros((n,n))
for i in range(n):
    for j in range(i+1,n): N[i,j]=N[j,i]=rng.normal()
H=C.diag_op(N); LH=C.L_W(c,W,H)
print("non-Weyl diagonal: offdiag=",f"{C.offdiag_mass(n,LH):.2e}",
      " ||true-hollowclaim||=",f"{np.abs(C.op_to_M(n,LH)-C.calL(M,N)).max():.2e}",
      " rowsum=",f"{np.abs(C.op_to_M(n,LH).sum(1)).max():.3e}")
