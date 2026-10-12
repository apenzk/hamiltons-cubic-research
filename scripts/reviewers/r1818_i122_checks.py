# r1818 screen for I122: (a) the factor in T(G)=<G#,G>, (b) G# off-diagonal blocks for non-block G on so(4)=su(2)+su(2).
import numpy as np, itertools
m=4
pairs=list(itertools.combinations(range(m),2))
def E(i,j):
    X=np.zeros((m,m)); X[i,j]=1; X[j,i]=-1; return X
def basis(t):  # orthonormal for <X,Y>_t = t tr(X^T Y)
    return [E(i,j)/np.sqrt(2*t) for i,j in pairs]
def c(B,t):
    n=len(B); C=np.zeros((n,n,n))
    for a in range(n):
        for b in range(n):
            Z=B[a]@B[b]-B[b]@B[a]
            for g in range(n): C[g,a,b]=t*np.trace(B[g].T@Z)
    return C  # C[alpha,gamma,delta]
def sharp(A,Bm,C): return 0.5*np.einsum('agd,bez,ge,dz->ab',C,C,A,Bm)
def T(G,C):  # sum_{ijk} s_i s_j s_k <[A_i,A_j],A_k>^2, basis-free form
    return np.einsum('kij,lab,ia,jb,kl->',C,C,G,G,G)
N=len(pairs); I=np.eye(N)
C1=c(basis(1.0),1.0); Ch=c(basis(0.5),0.5)
print('I#I diag, Frobenius basis:',np.diag(sharp(I,I,C1))[0],' half-trace basis:',np.diag(sharp(I,I,Ch))[0])
rng=np.random.default_rng(0); M=rng.standard_normal((N,N)); G=M@M.T; G/=np.linalg.norm(G)
for name,C in [('Frob',C1),('half',Ch)]:
    print(name,'T=',T(G,C),'<G#,G>=',np.sum(sharp(G,G,C)*G))
print('T(I/|I|) Frob',T(I/np.sqrt(N),C1),'(m-2)/sqrt(N)=',(m-2)/np.sqrt(N))
# self-dual / anti-self-dual basis in Frobenius
B=basis(1.0); idx={p:k for k,p in enumerate(pairs)}
def v(p,q,s):
    x=np.zeros(N); x[idx[p]]=1; x[idx[q]]=s; return x/np.sqrt(2)
P=np.array([v((0,1),(2,3),1),v((0,2),(1,3),-1),v((0,3),(1,2),1)])
Q=np.array([v((0,1),(2,3),-1),v((0,2),(1,3),1),v((0,3),(1,2),-1)])
Gp=P.T@P/np.sqrt(3); print('T(P+/sqrt3) Frob',T(Gp,C1),' 2/sqrt3=',2/np.sqrt(3))
# check the ideals: brackets between P and Q rows vanish
print('max |c| between ideals', max(abs(np.einsum('kij,i,j->k',C1,P[a],Q[b])).max() for a in range(3) for b in range(3)))
a=P[0]+Q[0]; b=P[1]+Q[1]; G2=np.outer(a,a)+np.outer(b,b)
S=sharp(G2,G2,C1); print('|P S Q^T| (off-diagonal block of G#):',np.linalg.norm(P@S@Q.T))
