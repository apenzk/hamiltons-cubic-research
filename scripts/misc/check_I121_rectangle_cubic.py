"""The rectangle identity for I121: on three disjoint edges, tau = <nu12 o nu13, nu23> = (3/2) J12 J13 J23 + 4 X12 X13 X23 with J the entry between matched bivectors and X = (W_ik,jl + W_il,jk)/2, the six mixed coefficients zero; and P(B_f) = sum over rectangles of 9JJJ + 24XXX on a random four-set tensor. Built on r1816's construction of Q. A check of a derived identity (reviews/2026-09-28d-I121-smallmass-direct.md). Run: sage -python check_I121_rectangle_cubic.py <n>, n = 6 or 8."""
import numpy as np, itertools
import sys
n=int(sys.argv[1])
pairs=list(itertools.combinations(range(n),2)); idx={pr:i for i,pr in enumerate(pairs)}; N=len(pairs)
def mat(a,b):
    M=np.zeros((n,n)); M[a,b]=1; M[b,a]=-1; return M/np.sqrt(2)
basis=[mat(a,b) for (a,b) in pairs]
C=np.zeros((N,N,N))
for i in range(N):
    for j in range(N):
        br=basis[i]@basis[j]-basis[j]@basis[i]
        for k in range(N): C[i,j,k]=np.sum(br*basis[k])
def sharp(X,Y): return 0.5*np.einsum('ack,bdl,cd,kl->ab',C,C,X,Y,optimize=True)
I=np.eye(N); scale=(n-2)/sharp(I,I)[0,0]
def Qb(X,Y): return 0.5*(X@Y+Y@X)+scale*0.5*(sharp(X,Y)+sharp(Y,X))
def setent(W,a,b,c,d,v):
    s=1
    if a>b: a,b=b,a; s=-s
    if c>d: c,d=d,c; s=-s
    W[idx[(a,b)],idx[(c,d)]]+=s*v
    if (a,b)!=(c,d): W[idx[(c,d)],idx[(a,b)]]+=s*v
def block(e,f,J,X):
    # four-set block on e={i,j}, f={k,l}: W_{ij,kl}=J, W_{ik,jl}=X+J/2, W_{il,jk}=X-J/2 (Bianchi A1=A2-A3)
    (i,j),(k,l)=e,f; W=np.zeros((N,N))
    setent(W,i,j,k,l,J); setent(W,i,k,j,l,X+J/2); setent(W,i,l,j,k,X-J/2)
    return W
# sanity: Bianchi and norm
def bianchi(W):
    out=[]
    for a,b,c,d in itertools.combinations(range(n),4):
        v=0
        for (x,y,z,w) in [(a,b,c,d),(b,c,a,d),(c,a,b,d)]:
            s=1; p,q,r,t=x,y,z,w
            if p>q: p,q=q,p; s=-s
            if r>t: r,t=t,r; s=-s
            v+=s*W[idx[(p,q)],idx[(r,t)]]
        out.append(v)
    return max(abs(np.array(out)))

e1,e2,e3=(0,1),(2,3),(4,5)
v=[(1,0),(0,1)]
tJ=np.sum(Qb(block(e1,e2,*v[0]),block(e1,e3,*v[0]))*block(e2,e3,*v[0]))
tX=np.sum(Qb(block(e1,e2,*v[1]),block(e1,e3,*v[1]))*block(e2,e3,*v[1]))
print("n=%d  alpha=%.10f gamma=%.10f"%(n,tJ,tX))
names=['J','X']
for c12,c13,c23 in itertools.product(range(2),repeat=3):
    tau=np.sum(Qb(block(e1,e2,*v[c12]),block(e1,e3,*v[c13]))*block(e2,e3,*v[c23]))
    print("  "+names[c12]+"12 "+names[c13]+"13 "+names[c23]+"23  tau=%.10f"%tau)
# random full four-set tensor: for each 4-set Q pick random (A2,A3), A1=A2-A3
rng=np.random.default_rng(5); W=np.zeros((N,N)); ent={}
for Q in itertools.combinations(range(n),4):
    i,j,k,l=Q; A2,A3=rng.standard_normal(2); A1=A2-A3
    setent(W,i,j,k,l,A1); setent(W,i,k,j,l,A2); setent(W,i,l,j,k,A3)
def g(a,b,c,d):
    s=1
    if a>b: a,b=b,a; s=-s
    if c>d: c,d=d,c; s=-s
    return s*W[idx[(a,b)],idx[(c,d)]]
P=np.sum(Qb(W,W)*W)
def JX(e,f):
    (i,j),(k,l)=e,f
    return g(i,j,k,l), 0.5*(g(i,k,j,l)+g(i,l,j,k))
tot=0; cnt=0
for S in itertools.combinations(range(n),6):
    a=S[0]
    rest=list(S[1:])
    for b in rest:
        r2=[x for x in rest if x!=b]; c=r2[0]
        for d in r2[1:]:
            r3=[x for x in r2 if x not in (c,d)]
            E=[tuple(sorted((a,b))),tuple(sorted((c,d))),tuple(sorted(r3))]
            J12,X12=JX(E[0],E[1]); J13,X13=JX(E[0],E[2]); J23,X23=JX(E[1],E[2])
            tot+=9*J12*J13*J23+24*X12*X13*X23; cnt+=1
print("rectangles",cnt," P(B_f)=%.10f  sum_R(9JJJ+24XXX)=%.10f"%(P,tot))
# the whole of P at pair-free W = A + B_f: P(A) + 3 sum_(e,f) (3/2 J^2 - 2 X^2)(a_e + a_f) + sum_R (9JJJ + 24XXX)
K=rng.standard_normal((n,n)); K=K+K.T; np.fill_diagonal(K,0)
s=K.sum(1); u=(s-s.sum()/(2*(n-1)))/(n-2)   # exact projection to zero row sums on hollow symmetric
K=K-(u[:,None]+u[None,:]); np.fill_diagonal(K,0)
A=np.zeros((N,N))
for (a,b),i in idx.items(): A[i,i]=K[a,b]
PA=np.sum(Qb(A,A)*A)
mid=0
for e in itertools.combinations(range(n),2):
    for f in itertools.combinations(range(n),2):
        if e<f and not set(e)&set(f):
            J,X=JX(e,f); mid+=(1.5*J*J-2*X*X)*(K[e]+K[f])
Wt=A+W
print("row sums of K: %.1e   P(A+B_f)=%.10f  formula=%.10f"%(abs(K.sum(1)).max(),np.sum(Qb(Wt,Wt)*Wt),PA+3*mid+tot))
# E(W) = P(W) - (3/2) tr(W^3) at pair-free W = A + B_f: [P(A) - (3/2) tr A^3] - 6 sum_(e,f)(a_e+a_f) X^2 + 24 sum_R XXX
midX=0
for e in itertools.combinations(range(n),2):
    for f in itertools.combinations(range(n),2):
        if e<f and not set(e)&set(f):
            J,X=JX(e,f); midX+=X*X*(K[e]+K[f])
xs=0
for S in itertools.combinations(range(n),6):
    a=S[0]; rest=list(S[1:])
    for b in rest:
        r2=[x for x in rest if x!=b]; c=r2[0]
        for d in r2[1:]:
            r3=[x for x in r2 if x not in (c,d)]
            E3=[tuple(sorted((a,b))),tuple(sorted((c,d))),tuple(sorted(r3))]
            xs+=JX(E3[0],E3[1])[1]*JX(E3[0],E3[2])[1]*JX(E3[1],E3[2])[1]
EW=np.sum(Qb(Wt,Wt)*Wt)-1.5*np.trace(Wt@Wt@Wt)
print("E(W)=%.10f  formula=%.10f"%(EW,(PA-1.5*np.trace(A@A@A))-6*midX+24*xs))
