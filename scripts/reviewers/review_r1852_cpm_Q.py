# r1852: build CP^m Weyl operator on Lambda^2, check Q(W)=W^2+W# is theta*W, theta^2 formula, spectrum, unitary-frame diag mass
import numpy as np, itertools, math
def run(m):
    n=2*m
    pairs=list(itertools.combinations(range(n),2)); N=len(pairs)
    def E(i,j):
        A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; return A
    B=[E(i,j) for i,j in pairs]   # <A,B> = -tr(AB)/2 makes these orthonormal
    ip=lambda A,C: -np.trace(A@C)/2
    vec=lambda A: np.array([ip(A,b) for b in B])
    Jm=np.zeros((n,n))
    for a in range(m): Jm[2*a,2*a+1]=-1; Jm[2*a+1,2*a]=1
    # projection to u(m): (A - J A J)/2
    Pu=np.array([vec((b-Jm@b@Jm)/2) for b in B]).T
    w=vec(Jm); w/=np.linalg.norm(w); Pw=np.outer(w,w)
    R=2*Pu+2*m*Pw
    kappa=np.trace(R)/N
    W=R-kappa*np.eye(N)
    # structure constants
    C=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C[a,b]=vec(B[a]@B[b]-B[b]@B[a])
    def sharp(X,Y):
        # <X#Y (z), w> = 1/2 sum_{ab} <[e_a,e_b],z><[X e_a, Y e_b], w>
        # [X e_a, Y e_b] = sum_{cd} X_ca Y_db [e_c,e_d]
        T=np.einsum('abz,ca,db,cdw->zw',C,X,Y,C,optimize=True)
        return 0.5*T
    s=(N and sharp(np.eye(N),np.eye(N)))
    c0=(n-2)/s[0,0]
    Wn=W/np.linalg.norm(W)
    Q=Wn@Wn+c0*sharp(Wn,Wn)
    th=np.sum(Q*Wn)
    res=np.linalg.norm(Q-th*Wn)
    ev=np.round(np.linalg.eigvalsh(W)*(2*m-1)/2,6)
    vals,cnt=np.unique(ev,return_counts=True)
    diag=np.sum(np.diag(Wn)**2)
    print(m,n,"I# check",np.linalg.norm(c0*s-(n-2)*np.eye(N)),"spec*(2m-1)/2",dict(zip(vals,cnt)),"theta %.6f formula %.6f resid %.2e tr3 %.6f diagmass %.4f"%(th,math.sqrt((m+1)*(2*m-1)/(3*m*(m-1))),res,np.trace(Wn@Wn@Wn),diag))
for m in (3,4,6): run(m)
