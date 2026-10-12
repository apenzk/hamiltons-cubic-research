# r1819 screen for I122: T(G)=<G#,G> normalisation, and kappa values on su(2)<so(4), su(3)<so(6), sp(2)<so(8).
import numpy as np, itertools
def so_basis(m):
    B=[]
    for i,j in itertools.combinations(range(m),2):
        E=np.zeros((m,m)); E[i,j]=1; E[j,i]=-1; B.append(E/np.sqrt(2))
    return B
def ip(X,Y): return np.trace(X.T@Y)
def T_of(s,A):
    return sum(s[i]*s[j]*s[k]*ip(A[i]@A[j]-A[j]@A[i],A[k])**2 for i in range(len(A)) for j in range(len(A)) for k in range(len(A)))
def sharp(G,B,scale):
    N=len(B); c=np.zeros((N,N,N))
    for a in range(N):
        for g in range(N):
            for d in range(N): c[a,g,d]=scale*ip(B[g]@B[d]-B[d]@B[g],B[a])
    return 0.5*np.einsum('agd,bez,ge,dz->ab',c,c,G,G)
m=5; B=so_basis(m); N=len(B); rng=np.random.default_rng(1)
X=rng.standard_normal((N,N)); G=X@X.T; G/=np.linalg.norm(G)
w,V=np.linalg.eigh(G); A=[sum(V[a,i]*B[a] for a in range(N)) for i in range(N)]
Gs=sharp(G,B,np.sqrt(2))
print('I#I/(m-2) diag', np.diag(sharp(np.eye(N),B,np.sqrt(2)))[:3]/(m-2))
print('T', T_of(w,A), '<G#,G>', np.sum(Gs*G))
def orth(L):
    M=np.array([x.ravel() for x in L]); U,S,Vt=np.linalg.svd(M,full_matrices=False); m=L[0].shape[0]
    return [Vt[i].reshape(m,m) for i in range(len(S)) if S[i]>1e-9*S[0]]
def kappa(L):
    L=orth(L); d=len(L); return T_of(np.ones(d)/np.sqrt(d),L)
def realify(Z):  # complex n x n -> real 2n x 2n
    return np.block([[Z.real,-Z.imag],[Z.imag,Z.real]])
def su_basis(k):
    L=[]
    for i,j in itertools.combinations(range(k),2):
        E=np.zeros((k,k),complex); E[i,j]=1; E[j,i]=-1; L.append(E)
        F=np.zeros((k,k),complex); F[i,j]=1j; F[j,i]=1j; L.append(F)
    for i in range(k-1):
        D=np.zeros((k,k),complex); D[i,i]=1j; D[i+1,i+1]=-1j; L.append(D)
    return L
print('su2 on R4', kappa([realify(z) for z in su_basis(2)]), 2/np.sqrt(3))
print('su3 on R6', kappa([realify(z) for z in su_basis(3)]), 3/np.sqrt(8))
# sp(2) = {X in u(4): X^T J + J X = 0}
k=2; J=np.block([[np.zeros((k,k)),np.eye(k)],[-np.eye(k),np.zeros((k,k))]])
U=su_basis(4)+[np.diag([1j,0,0,0])]
P=[0.5*(Z+J.T@Z.conj()@J) for Z in U]  # projection onto sp(2) inside u(4)
P=[p for p in P if np.linalg.norm(p)>1e-9]
Ms=np.array([np.concatenate([p.real.ravel(),p.imag.ravel()]) for p in P]); r=np.linalg.matrix_rank(Ms)
print('sp2 dim', r, 'on R8', kappa([realify(p) for p in P]), 3/np.sqrt(10))
print('so(m) scalar', [ (mm,kappa(so_basis(mm)),(mm-2)/np.sqrt(mm*(mm-1)/2)) for mm in (3,4,5)])
