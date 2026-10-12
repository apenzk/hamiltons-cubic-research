"""Excess at the three survivors, with two bugs from the first attempt fixed.

(a) The pair space is 10-dimensional and tangency removes ONE, so the tangent space is
    9-dimensional.  The first run projected all 10 basis pairs and kept them, so the
    matrix had a null direction BY CONSTRUCTION and reported excess 1 everywhere.
(b) The record's orbit-vacuity rests on P being O(n)-INVARIANT.  Here the fields A, C
    are FIXED, so conjugating (U,V) alone is not a symmetry and the orbit tangent need
    not lie in the kernel.  Checked directly rather than transferred.
"""
import sys, numpy as np
sys.path.insert(0,'scripts/misc')
from screen_I106_value_survivors import critical_point, AF, BF
tr=np.trace

def pair_ip(a,b): return 3*tr(a[0]@b[0])+tr(a[1]@b[1])

def sym_basis():
    E=[]
    E.append(np.diag([1,-1,0.0])/np.sqrt(2))
    E.append(np.diag([1,1,-2.0])/np.sqrt(6))
    for i,j in [(0,1),(0,2),(1,2)]:
        M=np.zeros((3,3)); M[i,j]=M[j,i]=1/np.sqrt(2); E.append(M)
    return E

SURV=[(1,-3,11.60060,"(1,-3,2)"),(-1,-3,24.43870,"(-1,-3,4)"),(19,-20,762.38453,"(19,-20,1)")]
print(f"{'spectrum':<12} {'tan dim':>8} {'dim ker H':>10} {'orbit in ker H':>15} {'max |H(orbit)|':>16}")
for u1,u2,mu,tag in SURV:
    U,V=critical_point(u1,u2,mu)[:2]
    E=sym_basis()
    pairs=[(M,np.zeros((3,3))) for M in E]+[(np.zeros((3,3)),M) for M in E]
    g=(3*U,V); gn=pair_ip(g,g)
    proj=[(P[0]-pair_ip(P,g)/gn*g[0], P[1]-pair_ip(P,g)/gn*g[1]) for P in pairs]
    # Gram-Schmidt to a genuine orthonormal basis of the 9-dim tangent space
    basis=[]
    for P in proj:
        Q=(P[0].copy(),P[1].copy())
        for Bv in basis:
            co=pair_ip(Q,Bv); Q=(Q[0]-co*Bv[0], Q[1]-co*Bv[1])
        nn=np.sqrt(pair_ip(Q,Q))
        if nn>1e-7: basis.append((Q[0]/nn, Q[1]/nn))
    def H(X,Y): return (6*AF*tr(U@X@X)+4*BF*tr(X@V@Y)+2*BF*tr(U@Y@Y)
                        -mu*(3*tr(X@X)+tr(Y@Y)))
    n=len(basis); M=np.zeros((n,n))
    for i in range(n):
        for j in range(n):
            Xi,Yi=basis[i]; Xj,Yj=basis[j]
            M[i,j]=0.5*(H(Xi+Xj,Yi+Yj)-H(Xi,Yi)-H(Xj,Yj))
    w=np.linalg.eigvalsh((M+M.T)/2); scale=max(1.0,np.abs(w).max())
    kerdim=int((np.abs(w)<1e-8*scale).sum())
    orb=[]
    for i,j in [(0,1),(0,2),(1,2)]:
        Om=np.zeros((3,3)); Om[i,j]=1; Om[j,i]=-1
        orb.append((Om@U-U@Om, Om@V-V@Om))
    hv=[abs(H(o[0],o[1])) for o in orb if np.sqrt(pair_ip(o,o))>1e-9]
    inker=sum(1 for h in hv if h<1e-8*scale)
    print(f"{tag:<12} {n:>8} {kerdim:>10} {inker:>15} {max(hv):>16.4e}")
print()
print("tan dim 9 confirms the basis is right. If dim ker H is 0 the second variation is")
print("NONDEGENERATE at these points, so no null direction exists and the theta^3 lever")
print("has no hypothesis to act on THERE, whatever it does elsewhere.")
