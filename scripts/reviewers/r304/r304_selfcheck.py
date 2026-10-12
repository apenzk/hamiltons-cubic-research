import sys, itertools; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C

def sphere_product(p,q):
    n=p+q; M=np.zeros((n,n))
    a=q/(p-1) if p>1 else 0.0; b=p/(q-1) if q>1 else 0.0; g=-1.0
    for i in range(n):
        for j in range(n):
            if i==j: continue
            if i<p and j<p: M[i,j]=a
            elif i>=p and j>=p: M[i,j]=b
            else: M[i,j]=g
    M*= np.sqrt(2/np.sum(M*M))
    return M

def C5blowup(k=2):
    """C_5 blow-up: 5 blocks of size k, block-constant, cyclic adjacency."""
    n=5*k; M=np.zeros((n,n))
    # unknown weights: inside block x, adjacent blocks y, non-adjacent z
    # solve row sums 0 and criticality by root find below
    return n

for (p,q) in [(3,3),(3,5),(6,6),(4,8)]:
    M=sphere_product(p,q); n=p+q
    c=C.struct_consts(n); W=C.diag_op(M)
    th_alg=C.P_cubic(c,W)/np.sum(W*W)
    th_gr=C.theta_of(M)
    # graph formula
    E=sum(M[i,j]**3 for i in range(n) for j in range(i+1,n))
    T=sum(M[i,j]*M[j,k]*M[i,k] for i in range(n) for j in range(i+1,n) for k in range(j+1,n))
    QW=C.Q(c,W)
    print(f"S^{p}xS^{q} n={n}: theta_alg={th_alg:.12f} theta_M={th_gr:.12f} graph={E+3*T:.12f} "
          f"crit_res={np.abs(C.crit_residual(M)).max():.2e} Q_offdiag={C.offdiag_mass(n,QW):.2e} "
          f"Qcrit={np.abs(QW-th_alg*W).max():.2e} norm={np.sum(W*W):.6f}")
