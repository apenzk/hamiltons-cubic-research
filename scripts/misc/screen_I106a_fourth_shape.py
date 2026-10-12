"""Validate r970's FOURTH SHAPE, and test it for vacuity.

Claim: at a tangent Z = (X,Y) where batch 21 holds with EQUALITY, a local maximum forces

    P_3(Z) + (T(Z)/T) * ell(Z) = 0,     ell(Z) = <X,A> + <Y,C>.

A refutation that reopens a closed route carries the heaviest burden, so the control is
VACUITY: if that expression vanishes automatically at tight directions it is no lever.
Here I build tight directions explicitly and ask whether the expression is generically
nonzero there.
"""
import numpy as np
rng=np.random.default_rng(4242)
AF,BF=15/4,9/4
def sym():
    M=rng.normal(size=(3,3)); M=(M+M.T)/2; return M-np.trace(M)/3*np.eye(3)

def basis():
    """an orthonormal basis of traceless symmetric 3x3 (dimension 5)"""
    B=[]
    for _ in range(200):
        M=sym()
        for E in B: M=M-np.trace(M@E)*E
        n=np.sqrt(np.trace(M@M))
        if n>1e-8:
            B.append(M/n)
        if len(B)==5: break
    return B

vals=[]
for _ in range(400):
    U=sym(); V=sym()
    B=basis()
    # the second-variation quadratic form on pairs (X,Y), and the norm form
    def Q(X,Y):
        return 6*AF*np.trace(U@X@X)+4*BF*np.trace(X@V@Y)+2*BF*np.trace(U@Y@Y)
    def N(X,Y):
        return 3*np.trace(X@X)+np.trace(Y@Y)
    # build the pair-space basis (X in B, Y=0) and (X=0, Y in B): 10 dimensional
    pairs=[(E,np.zeros((3,3))) for E in B]+[(np.zeros((3,3)),E) for E in B]
    n=len(pairs)
    Qm=np.zeros((n,n)); Nm=np.zeros((n,n))
    for i,(Xi,Yi) in enumerate(pairs):
        for j,(Xj,Yj) in enumerate(pairs):
            Qm[i,j]=0.5*(Q(Xi+Xj,Yi+Yj)-Q(Xi,Yi)-Q(Xj,Yj))
            Nm[i,j]=0.5*(N(Xi+Xj,Yi+Yj)-N(Xi,Yi)-N(Xj,Yj))
    # mu at which batch 21 is TIGHT: the top generalised eigenvalue
    import scipy.linalg as sla
    w,vec=sla.eigh((Qm+Qm.T)/2,(Nm+Nm.T)/2)
    mu=w[-1]; z=vec[:,-1]
    X=sum(z[i]*pairs[i][0] for i in range(n)); Y=sum(z[i]*pairs[i][1] for i in range(n))
    tight=Q(X,Y)-mu*N(X,Y)
    A=(3*mu)*U-(3*AF)*(U@U)-BF*(V@V)
    C=mu*V-BF*(U@V+V@U)
    T=1.5*np.trace(U@U)+0.5*np.trace(V@V)
    TZ=1.5*np.trace(X@X)+0.5*np.trace(Y@Y)
    P3Z=AF*np.trace(X@X@X)+BF*(np.trace(X@Y@Y))
    ell=np.trace(X@A)+np.trace(Y@C)
    vals.append((abs(tight),abs(P3Z+(TZ/T)*ell)))

tight_res=max(v[0] for v in vals)
expr=[v[1] for v in vals]
print(f"400 constructed TIGHT directions (mu = top generalised eigenvalue):")
print(f"  max |batch 21 residual| at Z*        : {tight_res:.3e}   (0 means genuinely tight)")
print(f"  the cubic expression |P_3 + (T_Z/T) ell| :")
print(f"     min {min(expr):.4e}   median {np.median(expr):.4e}   max {max(expr):.4e}")
print(f"  fraction below 1e-8 (i.e. vanishing)  : {sum(1 for e in expr if e<1e-8)/len(expr):.3f}")
print()
print("If the expression were automatically zero at tight directions the lever would be")
print("vacuous. A generically NONZERO value means it is a real condition, which is what")
print("makes it a fourth shape rather than a restatement of batch 21.")
