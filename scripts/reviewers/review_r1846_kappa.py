"""r1846 screen: <R#,R> = (1/2) I_3 on a generic algebraic curvature tensor (step 3's unproved proportionality),
and the rectangle tau from index contractions alone (tr R^3 + I_3/2), independent of the check script's rectangle sums."""
import numpy as np, itertools, sys
n=int(sys.argv[1]) if len(sys.argv)>1 else 6
pairs=list(itertools.combinations(range(n),2)); idx={p:i for i,p in enumerate(pairs)}; N=len(pairs)
def mat(a,b):
    M=np.zeros((n,n)); M[a,b]=1; M[b,a]=-1; return M/np.sqrt(2)
B=[mat(*p) for p in pairs]
C=np.array([[[np.sum((B[i]@B[j]-B[j]@B[i])*B[k]) for k in range(N)] for j in range(N)] for i in range(N)])
def sharp(X,Y): return 0.5*np.einsum('ack,bdl,cd,kl->ab',C,C,X,Y,optimize=True)
scale=(n-2)/sharp(np.eye(N),np.eye(N))[0,0]
def S(W): return scale*sharp(W,W)
def op2R(W):
    R=np.zeros((n,n,n,n))
    for (i,j),a in idx.items():
        for (k,l),b in idx.items():
            v=W[a,b]; R[i,j,k,l]=v; R[j,i,k,l]=-v; R[i,j,l,k]=-v; R[j,i,l,k]=v
    return R
def I3(R): return np.einsum('ijkl,ipkq,jplq->',R,R,R,optimize=True)
rng=np.random.default_rng(11)
# generic algebraic curvature tensor: sum of Kulkarni-Nomizu squares h o h
R=np.zeros((n,n,n,n))
for _ in range(4):
    h=rng.standard_normal((n,n)); h=h+h.T; g=rng.standard_normal()
    R+=g*(np.einsum('ik,jl->ijkl',h,h)+np.einsum('jl,ik->ijkl',h,h)-np.einsum('il,jk->ijkl',h,h)-np.einsum('jk,il->ijkl',h,h))
W=np.zeros((N,N))
for (i,j),a in idx.items():
    for (k,l),b in idx.items(): W[a,b]=R[i,j,k,l]
print("generic ACT: <W#,W>=%.10f  I3/2=%.10f"%(np.sum(S(W)*W),I3(op2R(W))/2))
# rectangle blocks with independent entry placement
def block(e,f,J,X):
    (i,j),(k,l)=e,f; R=np.zeros((n,n,n,n))
    for (p,q,r,s,v) in [(i,j,k,l,J),(i,k,j,l,X+J/2),(i,l,j,k,X-J/2)]:
        for (a,b,c,d,sg) in [(p,q,r,s,1),(q,p,r,s,-1),(p,q,s,r,-1),(q,p,s,r,1)]:
            R[a,b,c,d]=sg*v; R[c,d,a,b]=sg*v
    return R
def R2op(R):
    W=np.zeros((N,N))
    for (i,j),a in idx.items():
        for (k,l),b in idx.items(): W[a,b]=R[i,j,k,l]
    return W
e1,e2,e3=(0,1),(2,3),(4,5)
def tau(v12,v13,v23):
    Rs=[block(e1,e2,*v12),block(e1,e3,*v13),block(e2,e3,*v23)]
    Ws=[R2op(r) for r in Rs]
    # fully mixed part of the cubic f(R)=tr W^3 + I3/2 via polarisation: coefficient of s1 s2 s3
    tot=0
    for sg in itertools.product([0,1],repeat=3):
        Rsum=sum(Rs[m] for m in range(3) if sg[m]); 
        if isinstance(Rsum,int): continue
        Wsum=R2op(Rsum); f=np.trace(Wsum@Wsum@Wsum)+I3(Rsum)/2
        tot+=(-1)**(3-sum(sg))*f
    return tot/6
for v in itertools.product([(1,0),(0,1)],repeat=3):
    print(v, "%.10f"%tau(*v))
# a random (J,X) triple vs formula
J=rng.standard_normal(3); X=rng.standard_normal(3)
t=tau((J[0],X[0]),(J[1],X[1]),(J[2],X[2]))
print("random: tau=%.10f formula=%.10f"%(t,1.5*J.prod()+4*X.prod()))
