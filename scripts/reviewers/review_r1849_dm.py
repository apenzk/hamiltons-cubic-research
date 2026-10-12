"""r1849 value check: at n=8, a random four-set tensor B_f and the matching M0={01,23,45,67}.
Rotate by pi/4 in each plane of M0, read the diagonal of the rotated B_f, compare with the +-X pattern,
and compare P(D_M) with 24 sum_{R in M} XXX and |D_M|^2 with E(M). Reuses the record's Q construction.
Also checks the per-edge bound S_e <= (n-3)/4 * max_M E(M) is the averaging identity sum_{M ni e} 4 sum_f X_ef^2 = (n-5)!! 4 S_e."""
import numpy as np, itertools
n=8
pairs=list(itertools.combinations(range(n),2)); idx={pr:i for i,pr in enumerate(pairs)}; N=len(pairs)
def mat(a,b):
    M=np.zeros((n,n)); M[a,b]=1; M[b,a]=-1; return M/np.sqrt(2)
basis=[mat(a,b) for (a,b) in pairs]
C=np.einsum('iab,jbc,kac->ijk',basis,basis,basis)-np.einsum('jab,ibc,kac->ijk',basis,basis,basis)
def sharp(X,Y): return 0.5*np.einsum('ack,bdl,cd,kl->ab',C,C,X,Y,optimize=True)
I=np.eye(N); scale=(n-2)/sharp(I,I)[0,0]
def P(W): return np.sum((W@W+scale*sharp(W,W))*W)
def setent(W,a,b,c,d,v):
    s=1
    if a>b: a,b=b,a; s=-s
    if c>d: c,d=d,c; s=-s
    W[idx[(a,b)],idx[(c,d)]]+=s*v
    if (a,b)!=(c,d): W[idx[(c,d)],idx[(a,b)]]+=s*v
rng=np.random.default_rng(11); W=np.zeros((N,N))
for Q in itertools.combinations(range(n),4):
    i,j,k,l=Q; A2,A3=rng.standard_normal(2)
    setent(W,i,j,k,l,A2-A3); setent(W,i,k,j,l,A2); setent(W,i,l,j,k,A3)
def g(a,b,c,d):
    s=1
    if a>b: a,b=b,a; s=-s
    if c>d: c,d=d,c; s=-s
    return s*W[idx[(a,b)],idx[(c,d)]]
def X(e,f):
    (i,j),(k,l)=e,f; return 0.5*(g(i,k,j,l)+g(i,l,j,k))
M=[(0,1),(2,3),(4,5),(6,7)]
# rotation by pi/4 in each plane of M: new basis u_a=(x_i+x_j)/sqrt2, v_a=(x_i-x_j)/sqrt2
O=np.zeros((n,n))
for a,(i,j) in enumerate(M):
    O[:,2*a]=0; O[i,2*a]=O[j,2*a]=1/np.sqrt(2); O[i,2*a+1]=1/np.sqrt(2); O[j,2*a+1]=-1/np.sqrt(2)
# induced action on Lambda^2: (Lam)_{pq,(ab)} = <e_pq, O e_a ^ O e_b>
L=np.zeros((N,N))
for c,(a,b) in enumerate(pairs):
    B=np.outer(O[:,a],O[:,b])-np.outer(O[:,b],O[:,a])
    for r,(p,q) in enumerate(pairs): L[r,c]=B[p,q]
Wr=L.T@W@L
D=np.diag(np.diag(Wr))
print("P invariance under the frame change: %.3e"%(P(Wr)-P(W)))
# the predicted pattern: pair {u_a or v_a, u_b or v_b} gets +-X_ab, in-block 0
pat=np.zeros(N)
for c,(p,q) in enumerate(pairs):
    a,b=p//2,q//2
    if a!=b: pat[c]=(1 if p%2==q%2 else -1)*X(M[a],M[b])
print("diag of rotated B_f vs +-X pattern: max diff %.3e"%np.abs(np.diag(Wr)-pat).max())
K=np.zeros((n,n))
for c,(p,q) in enumerate(pairs): K[p,q]=K[q,p]=D[c,c]
print("row sums of D_M: %.3e"%np.abs(K.sum(1)).max())
xs=sum(X(M[a],M[b])*X(M[a],M[c])*X(M[b],M[c]) for a,b,c in itertools.combinations(range(4),3))
EM=sum(4*X(M[a],M[b])**2 for a,b in itertools.combinations(range(4),2))
print("P(D_M)=%.10f  24 sum XXX=%.10f   |D_M|^2=%.10f  E(M)=%.10f"%(P(D),24*xs,np.sum(D*D),EM))
