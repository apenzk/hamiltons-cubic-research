"""The Schur-Horn lead is conditional on knowing d at the maximiser. What would discharge it
is a lower bound on d's SPREAD forced by theta being large.  Is there one?

sum_phi d^2 = ||K||_F^2 / 1 with K_ab = W_abab, and ||K||_F^2 <= 2||W||^2 = 2 with equality
iff W is coordinate-diagonal.  So sum d^2 is a diagonality meter -- and the record already
says diagonality is the load-bearing hypothesis.  Test: does large theta force large sum d^2?
"""
import numpy as np, itertools
rng=np.random.default_rng(71)
def proj_weyl(A,n):
    R=A-A.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
    KN=lambda A,B:(np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                   -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    return R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
def npw(n):
    B=[]
    for i in range(n):
        for j in range(i+1,n):
            h=np.zeros((n,n)); h[i,j]=h[j,i]=1/np.sqrt(2); B.append(('phi',h))
    for k in range(n-1):
        h=np.zeros((n,n)); c=1/np.sqrt((n-k)*(n-k-1)); h[k,k]=-(n-k-1)*c
        for l in range(k+1,n): h[l,l]=c
        B.append(('psi',h))
    return B
def data(W,n):
    B=npw(n); m=len(B); Op=np.zeros((m,m))
    for a,(_,h) in enumerate(B):
        Wh=np.einsum('iklj,kl->ij',W,h)
        for b,(_,hb) in enumerate(B): Op[a,b]=np.sum(Wh*hb)
    d=np.diag(Op); om=np.linalg.eigvalsh(Op)
    dphi=np.array([d[a] for a,(t,_) in enumerate(B) if t=='phi'])
    pr=list(itertools.combinations(range(n),2))
    M=np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr])
    sh=None
    return np.sum(d**2), np.sum(dphi**2), -np.sum(om**3), M
def sharp(M,pr,n):
    N=len(pr)
    def E(i,j):
        A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; return A
    B=[E(i,j) for (i,j) in pr]; c=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C=B[a]@B[b]-B[b]@B[a]
            for g,(k,l) in enumerate(pr): c[a,b,g]=C[k,l]
    return 0.5*np.einsum('agd,bez,ge,dz->ab',c,c,M,M,optimize=True)
def theta_of(M,n):
    pr=list(itertools.combinations(range(n),2))
    return np.trace(M@M@M)+np.sum(sharp(M,pr,n)*M)
def unit(W,n):
    pr=list(itertools.combinations(range(n),2))
    M=np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr]); return W/np.linalg.norm(M)
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
print(f"{'point':26s} {'theta':>9} {'sum d^2':>9} {'sum dphi^2':>11} {'-p3(om)':>9}")
pts=[]
for m in [3,4,5,6]:
    n=2*m; W=unit(sphere_product(m,m,n),n); s2,sp2,p3,M=data(W,n); th=theta_of(M,n)
    print(f"{'S^%d x S^%d'%(m,m):26s} {th:9.5f} {s2:9.4f} {sp2:11.4f} {p3:9.4f}"); pts.append((th,s2))
for n in [6,8,12]:
    W=unit(cp2(n),n); s2,sp2,p3,M=data(W,n); th=theta_of(M,n)
    print(f"{'CP^2 padded to n=%d'%n:26s} {th:9.5f} {s2:9.4f} {sp2:11.4f} {p3:9.4f}"); pts.append((th,s2))
for n in [8,12]:
    for t in range(3):
        W=unit(proj_weyl(rng.standard_normal((n,n,n,n)),n),n); s2,sp2,p3,M=data(W,n); th=theta_of(M,n)
        print(f"{'random n=%d #%d'%(n,t):26s} {th:9.5f} {s2:9.4f} {sp2:11.4f} {p3:9.4f}"); pts.append((th,s2))
print()
print("Is large |theta| forcing large sum d^2?")
a=np.array(pts); hi=a[np.abs(a[:,0])>1.0]; lo=a[np.abs(a[:,0])<0.3]
print(f"  |theta| > 1.0 : sum d^2 in [{hi[:,1].min():.4f}, {hi[:,1].max():.4f}]   ({len(hi)} points)")
print(f"  |theta| < 0.3 : sum d^2 in [{lo[:,1].min():.4f}, {lo[:,1].max():.4f}]   ({len(lo)} points)")
