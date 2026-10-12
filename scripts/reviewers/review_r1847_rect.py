"""r1847 screen: independent construction of Q on Weyl tensors (4-index form), checks <R#,R> = I3/2 on a random Weyl tensor,
the rectangle tau on (J,X) coordinates, and P(A+B_f) against the pair-free formula. Run: sage -python review_r1847_rect.py n"""
import numpy as np, itertools, sys
n=int(sys.argv[1]); rng=np.random.default_rng(11)
def KN(h,k):  # Kulkarni-Nomizu
    return (np.einsum('il,jk->ijkl',h,k)+np.einsum('jk,il->ijkl',h,k)-np.einsum('ik,jl->ijkl',h,k)-np.einsum('jl,ik->ijkl',h,k))
def weyl(R):
    g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric)
    P=(Ric-s/(2*(n-1))*g)/(n-2)
    return R+KN(P,g)  # sign fixed by checking Ricci-free below
def rand_acurv():
    R=np.zeros((n,)*4)
    for _ in range(6):
        h=rng.standard_normal((n,n)); h=h+h.T; k=rng.standard_normal((n,n)); k=k+k.T; R+=KN(h,k)
    return R
W=weyl(rand_acurv())
if abs(np.einsum('ikjk->ij',W)).max()>1e-9:
    W=rand_acurv(); g=np.eye(n); Ric=np.einsum('ikjk->ij',W); s=np.trace(Ric); W=W-KN((Ric-s/(2*(n-1))*g)/(n-2),g)
print("Ricci of W",abs(np.einsum('ikjk->ij',W)).max())
pairs=list(itertools.combinations(range(n),2)); N=len(pairs)
def op(R):  # operator on Lambda^2 in e_ab: <e_ab, R e_cd> = R_abcd with R(e_ab,e_cd)=R_abcd (factor conventions: entries W_{ab,cd}=R_abcd)
    return np.array([[R[a,b,c,d] for (c,d) in pairs] for (a,b) in pairs])
def tens(M):
    R=np.zeros((n,)*4)
    for I,(a,b) in enumerate(pairs):
        for J,(c,d) in enumerate(pairs):
            v=M[I,J]; R[a,b,c,d]=v; R[b,a,c,d]=-v; R[a,b,d,c]=-v; R[b,a,d,c]=v
    return R
# Lie algebra sharp, normalised I#=(n-2)I
B=[]
for (a,b) in pairs:
    M=np.zeros((n,n)); M[a,b]=1; M[b,a]=-1; B.append(M/np.sqrt(2))
C=np.array([[[np.sum((B[i]@B[j]-B[j]@B[i])*B[k]) for k in range(N)] for j in range(N)] for i in range(N)])
def sh(X,Y): return 0.5*(np.einsum('ack,bdl,cd,kl->ab',C,C,X,Y)+np.einsum('ack,bdl,cd,kl->ab',C,C,Y,X))
s0=(n-2)/sh(np.eye(N),np.eye(N))[0,0]
def Q(X,Y): return 0.5*(X@Y+Y@X)+s0*sh(X,Y)
Wo=op(W)
shp=np.sum(s0*sh(Wo,Wo)*Wo)
I3=np.einsum('ijkl,ipkq,jplq->',W,W,W); I3b=np.einsum('ijkl,ipkq,jqlp->',W,W,W)
print("<W#,W>=%.8f  I3/2=%.8f  I3alt/2=%.8f"%(shp,I3/2,I3b/2))
# rectangle blocks with (J,X) coordinates relative to (e|f)
def block(e,f,J,X):
    (i,j),(k,l)=e,f; M=np.zeros((n,)*4)
    def put(a,b,c,d,v):
        for (p,q,s1) in [(a,b,1),(b,a,-1)]:
            for (r,t,s2) in [(c,d,1),(d,c,-1)]:
                M[p,q,r,t]+=s1*s2*v; M[r,t,p,q]+=s1*s2*v
    put(i,j,k,l,J); put(i,k,j,l,X+J/2); put(i,l,j,k,X-J/2)
    return op(M)
if n>=6:
    e1,e2,e3=(0,1),(2,3),(4,5)
    for _ in range(2):
        J=rng.standard_normal(3); X=rng.standard_normal(3)
        n12=block(e1,e2,J[0],X[0]); n13=block(e1,e3,J[1],X[1]); n23=block(e2,e3,J[2],X[2])
        tau=np.sum(Q(n12,n13)*n23)
        print("tau=%.8f formula=%.8f  norm12=%.6f vs %.6f"%(tau,1.5*np.prod(J)+4*np.prod(X),np.sum(n12**2),4*X[0]**2+3*J[0]**2))
    # orientation: reverse e1 in coordinates
    Mb=tens(block(e1,e2,0.7,0.3))
    i,j=e1; k,l=e2
    print("reversed e1: J=%.3f X=%.3f (orig J=0.7 X=0.3)"%(Mb[j,i,k,l],0.5*(Mb[j,k,i,l]+Mb[j,l,i,k])))
# whole P at pair-free W = A + B_f, own construction
K=rng.standard_normal((n,n)); K=K+K.T; np.fill_diagonal(K,0)
s_=K.sum(1); u=(s_-s_.sum()/(2*(n-1)))/(n-2); K=K-(u[:,None]+u[None,:]); np.fill_diagonal(K,0)  # exact projection to zero row sums
Kr=K.sum(1); print("row sums",abs(Kr).max())
A=np.diag([K[a,b] for (a,b) in pairs])
Bf=np.zeros((N,N)); coords={}
for Qs in itertools.combinations(range(n),4):
    i,j,k,l=Qs; J,X=rng.standard_normal(2); Bf+=block((i,j),(k,l),J,X)
Bt=tens(Bf)
def JX(e,f):
    (i,j),(k,l)=e,f; return Bt[i,j,k,l],0.5*(Bt[i,k,j,l]+Bt[i,l,j,k])
mid=0; rect=0
edges=pairs
for e,f in itertools.combinations(edges,2):
    if set(e)&set(f): continue
    J,X=JX(e,f); mid+=(1.5*J*J-2*X*X)*(K[e]+K[f])
for e,f,g in itertools.combinations(edges,3):
    if len(set(e)|set(f)|set(g))<6: continue
    J1,X1=JX(e,f); J2,X2=JX(e,g); J3,X3=JX(f,g); rect+=9*J1*J2*J3+24*X1*X2*X3
P=lambda M: np.sum(Q(M,M)*M)
print("P(Bf)=%.8f rect=%.8f   P(A+Bf)=%.8f formula=%.8f"%(P(Bf),rect,P(A+Bf),P(A)+3*mid+rect))
