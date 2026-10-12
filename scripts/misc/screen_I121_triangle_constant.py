"""I121 screen: the triangle constant <nu_S o nu_T, nu_U> = 5 sqrt3/24 for unit +c_* modes at n = 6, with a control reproducing theta_0(6) = 1.054093 at S^3 x S^3. Run with sage -python."""
# Screen: the triangle constant <nu_S o nu_T, nu_U> for unit +c_* modes of three 2+2 four-sets
# forming a hyperedge, computed from Q(R) = R^2 + R^# with the record's normalisation I#I = (n-2) I.
import numpy as np, itertools
n=6; P=[0,1,2]; Qp=[3,4,5]
pairs=list(itertools.combinations(range(n),2)); idx={p:i for i,p in enumerate(pairs)}; N=len(pairs)
def e(a,b):
    v=np.zeros(N); 
    if a<b: v[idx[(a,b)]]=1
    else: v[idx[(b,a)]]=-1
    return v
def op(pairsvals):
    R=np.zeros((N,N))
    for (a,b,c,d),val in pairsvals:
        x=e(a,b); y=e(c,d); R+=val*(np.outer(x,y)+np.outer(y,x))/ (2 if (a,b)==(c,d) else 1)
    return R
# structure constants of so(n) on the basis e_ab: [e_ab,e_cd]; R^# via c c R R (record normalisation fixed by I#I=(n-2)I)
def mat(a,b):
    M=np.zeros((n,n)); M[a,b]=1; M[b,a]=-1; return M/np.sqrt(2)
basis=[mat(a,b) for (a,b) in pairs]
C=np.zeros((N,N,N))
for i in range(N):
    for j in range(N):
        br=basis[i]@basis[j]-basis[j]@basis[i]
        for k in range(N): C[i,j,k]=np.sum(br*basis[k])
def sharp(X,Y):
    return 0.5*np.einsum('ack,bdl,cd,kl->ab',C,C,X,Y)
I=np.eye(N); s=sharp(I,I); scale=(n-2)/s[0,0]
def Q(X,Y): return 0.5*(X@Y+Y@X)+scale*0.5*(sharp(X,Y)+sharp(Y,X))
def mode(i,j,k,l):   # +c_* mode (u,v,w)=(2,1,-1), u=W_{ij,kl}, v=W_{ik,jl}, w=W_{il,jk}, {i,j} in P
    R=op([((i,j,k,l),2),((i,k,j,l),1),((i,l,j,k),-1)]); return R/np.linalg.norm(R)
S=mode(0,1,3,4); T=mode(1,2,4,5); U=mode(0,2,3,5)
print('<S o T, U> =', np.sum(Q(S,T)*U))
for perm in itertools.permutations([(3,4),(4,5),(3,5)]):
    S=mode(0,1,*perm[0]); T=mode(1,2,*perm[1]); U=mode(0,2,*perm[2])
    print(perm, round(np.sum(Q(S,T)*U),6))
# control: unit Weyl tensor of S^3 x S^3 must satisfy Q(e) = theta_0(6) e, theta_0(6) = sqrt(40)/6 = 1.054093
p=q=3; Nn=(n-1)*(n-2)
al=q*(q-1)/Nn; be=-(p-1)*(q-1)/Nn; ga=p*(p-1)/Nn
E=np.zeros((N,N))
for (a,b),i in idx.items():
    E[i,i]= al if (a in P and b in P) else (ga if (a in Qp and b in Qp) else be)
eE=E/np.linalg.norm(E); QE=Q(eE,eE)
print('control theta:', np.sum(QE*eE), 'residual:', np.linalg.norm(QE-np.sum(QE*eE)*eE), 'record 1.054093')
