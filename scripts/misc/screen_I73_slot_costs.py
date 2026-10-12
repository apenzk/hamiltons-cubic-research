# For the exact extremal X* (triangle or star) in so(n), compute:
#  A = -ad_{X*}^2, E = top-6 eigenspace, C = sum_a -ad_{e_a}^2 over an orthonormal basis of E,
#  and on E-perp (and X*-perp) the joint spectrum of (A, C): pairs (mu, q).
#  beta_E = sum_{a,b} |[e_a,e_b]|^2.
import numpy as np, itertools
def so_basis(n):
    B=[]
    for i,j in itertools.combinations(range(n),2):
        M=np.zeros((n,n)); M[i,j]=-1; M[j,i]=1; B.append(M)   # |M|^2 = -1/2 tr M^2 = 1
    return B
def ip(X,Y): return -0.5*np.trace(X@Y)
def br(X,Y): return X@Y-Y@X
def run(angles,n):
    B=so_basis(n); N=len(B)
    Xs=np.zeros((n,n))
    for k,a in enumerate(angles): Xs[2*k,2*k+1]=-a; Xs[2*k+1,2*k]=a
    def ad(X): return np.array([[ip(Bi,br(X,Bj)) for Bj in B] for Bi in B])
    adX=ad(Xs); A=-adX@adX
    w,V=np.linalg.eigh(A); order=np.argsort(-w); w=w[order]; V=V[:,order]
    Ecoef=V[:,:6]; E=[sum(c*Bi for c,Bi in zip(Ecoef[:,a],B)) for a in range(6)]
    beta=sum(ip(br(e,f),br(e,f)) for e in E for f in E)
    C=sum(-(ad(e)@ad(e)) for e in E)
    # projector onto complement of E and of X*
    xs=np.array([ip(Bi,Xs) for Bi in B]); xs/=np.linalg.norm(xs)
    P=np.eye(N)-Ecoef@Ecoef.T-np.outer(xs,xs)
    Ap=P@A@P; Cp=P@C@P
    # joint: diagonalise A on range(P), then C within each A-eigenspace
    wa,Va=np.linalg.eigh(Ap); out=[]
    for val in sorted(set(np.round(wa,6)),reverse=True):
        idx=np.where(np.abs(wa-val)<1e-6)[0]; Vs=Va[:,idx]
        if np.linalg.norm(P@Vs)<1e-6: continue
        Cs=Vs.T@Cp@Vs; qs=np.linalg.eigvalsh(Cs)
        out.append((val,len(idx),round(qs.max(),4)))
    print('angles',np.round(angles,4),'n',n,'top6',np.round(w[:7],4),'beta_E',round(beta,4))
    for t in out: print('  mu=%.4f mult=%d  maxQ=%.4f'%t)
run(np.array([1,1,1])/np.sqrt(3),8)
run(np.array([3,1,1,1])/np.sqrt(12),9)
