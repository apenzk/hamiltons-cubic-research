"""Item 1(a): does theta large force ||K||_F large?  Candidate: theta <= sqrt(3/2) ||K||_F,
sharp at CP^2 (theta=sqrt(3/2), ||K||_F=1).  K_ab = W_abab, ||K||_F^2 <= 2 with equality
iff W is coordinate-diagonal.

Tested by evaluation AND by adversarial ascent on theta - c||K||_F, which is the only
direction that can falsify.
"""
import numpy as np, itertools
rng=np.random.default_rng(83)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def pairs(n): return list(itertools.combinations(range(n),2))
def toM(W,n):
    pr=pairs(n); return np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr])
def fromM(M,n):
    pr=pairs(n); W=np.zeros((n,n,n,n))
    for a,(i,j) in enumerate(pr):
        for b,(k,l) in enumerate(pr):
            v=M[a,b]
            for (p,q,sp) in ((i,j,1),(j,i,-1)):
                for (r,s_,sq) in ((k,l,1),(l,k,-1)): W[p,q,r,s_]=sp*sq*v
    return W
def csts(n):
    pr=pairs(n); N=len(pr)
    def E(i,j):
        A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; return A
    B=[E(i,j) for (i,j) in pr]; c=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C=B[a]@B[b]-B[b]@B[a]
            for g,(k,l) in enumerate(pr): c[a,b,g]=C[k,l]
    return c
def theta_K(M,n,c):
    sh=0.5*np.einsum('agd,bez,ge,dz->ab',c,c,M,M,optimize=True)
    th=np.trace(M@M@M)+np.sum(sh*M)
    pr=pairs(n); K=np.zeros((n,n))
    for a,(i,j) in enumerate(pr): K[i,j]=K[j,i]=M[a,a]
    return th, np.linalg.norm(K)
def basis(n,c):
    dW=n*(n+1)*(n+2)*(n-3)//12
    V=np.array([toM(proj_weyl(rng.standard_normal((n,n,n,n)),n),n).ravel() for _ in range(4*dW+40)])
    U,sv,_=np.linalg.svd(V.T,full_matrices=False)
    N=len(pairs(n))
    return [U[:,k].reshape(N,N) for k in range(dW)], sv, dW
C=np.sqrt(1.5)
print(f"candidate:  theta <= {C:.6f} * ||K||_F      (sharp at CP^2)")
print(f"{'point':24s} {'theta':>9} {'||K||_F':>9} {'C*||K||':>9} {'slack':>9}")
def sphere_product(p,q,n):
    Lam=np.zeros((n,n)); b=1.0; a1=-q*b/(p-1); a2=-p*b/(q-1)
    for i in range(n):
        for j in range(n):
            if i!=j: Lam[i,j]=a1 if (i<p and j<p) else a2 if (i>=p and j>=p) else b
    I=np.eye(n)
    return -(np.einsum('ij,ik,jl->ijkl',Lam,I,I)-np.einsum('ij,il,jk->ijkl',Lam,I,I))
def cp2(n):
    d=4; J=np.zeros((d,d)); J[0,1]=1;J[1,0]=-1;J[2,3]=1;J[3,2]=-1; g=np.eye(d)
    R=(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)
       +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)+2*np.einsum('ij,kl->ijkl',J,J))
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/d*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)-np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    W=R-KN(E,g)/(d-2)-s/(2*d*(d-1))*KN(g,g)
    if n>d:
        Wp=np.zeros((n,n,n,n)); Wp[:d,:d,:d,:d]=W; W=Wp
    return W
worst=None
for n in [6,8,10,12]:
    c=csts(n)
    for lbl,W in [(f"S^{n//2}xS^{n//2}",sphere_product(n//2,n//2,n)),("CP^2 padded",cp2(n))]:
        M=toM(W,n); M/=np.linalg.norm(M); th,K=theta_K(M,n,c)
        sl=C*K-abs(th)
        print(f"{lbl+f' n={n}':24s} {th:9.5f} {K:9.5f} {C*K:9.5f} {sl:9.5f}")
        if worst is None or sl<worst[0]: worst=(sl,lbl,n)
    for t in range(2):
        M=toM(proj_weyl(rng.standard_normal((n,n,n,n)),n),n); M/=np.linalg.norm(M); th,K=theta_K(M,n,c)
        sl=C*K-abs(th)
        print(f"{f'random n={n} #{t}':24s} {th:9.5f} {K:9.5f} {C*K:9.5f} {sl:9.5f}")
        if sl<worst[0]: worst=(sl,f"random n={n}",n)
print(f"\nsmallest slack over the catalogue: {worst[0]:.6f} at {worst[1]}")
print("\n=== adversarial ascent: maximise |theta| - C||K||_F (a positive value refutes) ===")
for n in [6,8]:
    c=csts(n); B,sv,dW=basis(n,c)
    best=-9
    for s0 in range(8):
        M=sum(rng.standard_normal()*b for b in B); M/=np.linalg.norm(M)
        step=0.3
        for it in range(300):
            g=np.zeros_like(M); f0=abs(theta_K(M,n,c)[0])-C*theta_K(M,n,c)[1]
            for b in B:
                Mp=M+1e-6*b; Mp/=np.linalg.norm(Mp)
                th,K=theta_K(Mp,n,c); g=g+((abs(th)-C*K)-f0)/1e-6*b
            g=g-np.sum(g*M)*M; ng=np.linalg.norm(g)
            if ng<1e-11: break
            Mn=M+step*g/ng; Mn/=np.linalg.norm(Mn)
            th,K=theta_K(Mn,n,c)
            if abs(th)-C*K>f0: M=Mn
            else: step*=0.6
            if step<1e-9: break
        th,K=theta_K(M,n,c); best=max(best,abs(th)-C*K)
    print(f"  n={n}: max over 8 starts of |theta| - C||K||_F = {best:+.6f}   {'*** REFUTED ***' if best>1e-7 else 'no violation found'}")
