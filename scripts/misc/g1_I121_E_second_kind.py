"""Gate 1 for the second-kind bound on E (I121 small-mass node).

Checks, on random Weyl tensors at n = 6, 8, 10 and at S^3 x S^3:
  E = P - (3/2) tr M^3 equals -(1/2) p3(omega), omega = spec of the second-kind operator (Li's iklj order);
  sum omega^2 = 3 at unit norm;
  mu = -min omega equals d^T K d in the eigenframe of the bottom eigenvector h;
  mu <= sqrt(2(n-1)/n) t_F in that frame, t_F^2 = sum_{a<b} K_ab^2.
Run: sage -python scripts/misc/g1_I121_E_second_kind.py   (seconds)
"""
import numpy as np, itertools
rng=np.random.default_rng(7)
def bianchi_weyl(T):
    n=T.shape[0]
    # algebraic curvature symmetrisation
    T=(T-T.transpose(1,0,2,3))/2; T=(T-T.transpose(0,1,3,2))/2; T=(T+T.transpose(2,3,0,1))/2
    B=(T+T.transpose(0,2,3,1)+T.transpose(0,3,1,2))/3; T=T-B
    Ric=np.einsum('ikjk->ij',T); s=np.trace(Ric); g=np.eye(n)
    A=(Ric-s/(2*(n-1))*g)/(n-2)
    KN=lambda h,k: np.einsum('ik,jl->ijkl',h,k)+np.einsum('jl,ik->ijkl',h,k)-np.einsum('il,jk->ijkl',h,k)-np.einsum('jk,il->ijkl',h,k)
    return T-KN(A,g)
def lam2(W):
    n=W.shape[0]; P=list(itertools.combinations(range(n),2))
    return np.array([[W[i,j,k,l] for (k,l) in P] for (i,j) in P])
def normalise(W): M=lam2(W); return W/np.sqrt((M**2).sum())
def sharp_pair(W):  # <W#,W> = I3/2
    return 0.5*np.einsum('ijkl,ipkq,jplq->',W,W,W)
def ring_spec(W, vecs=False):  # Li order (W h)_ij = W_iklj h_kl on S^2
    n=W.shape[0]; S=[]
    for a in range(n):
        for b in range(a,n):
            h=np.zeros((n,n)); 
            if a==b: h[a,a]=1
            else: h[a,b]=h[b,a]=1/np.sqrt(2)
            S.append(h)
    Mat=np.array([[np.einsum('iklj,kl,ij->',W,h1,h2) for h1 in S] for h2 in S])
    w,v=np.linalg.eigh(Mat)
    if not vecs: return w
    h=sum(v[k,0]*S[k] for k in range(len(S))); return w,h
def K_of(W,U):
    Wr=np.einsum('ai,bj,ck,dl,ijkl->abcd',U,U,U,U,W); n=W.shape[0]
    return np.array([[Wr[a,b,a,b] if a!=b else 0 for b in range(n)] for a in range(n)])
def report(W,name):
    W=normalise(W); M=lam2(W); lam=np.linalg.eigvalsh(M)
    P=(lam**3).sum()+sharp_pair(W); E=P-1.5*(lam**3).sum()
    om,h=ring_spec(W,True); mu=-om.min()
    # mu via bottom eigvec frame
    n=W.shape[0]
    print(f"{name}: E={E:.6f}  -p3(om)/2={-0.5*(om**3).sum():.6f}  sum om^2={ (om**2).sum():.4f}  (3/2)mu={1.5*mu:.4f}", end='')
    d,U=np.linalg.eigh(h); K=K_of(W,U.T); dK=d@K@d; t2=(K**2).sum()/2
    print(f"  | eigenframe of h: d^T K d={dK:.6f} (mu={mu:.6f})  t^2={t2:.4f}  sqrt(2(n-1)/n)*t={np.sqrt(2*(n-1)/n*t2):.4f}")
for n in (6,8,10):
    for r in range(2):
        W=bianchi_weyl(rng.normal(size=(n,n,n,n))); report(W,f"random n={n}")
# balanced product S^3xS^3 Weyl
n=6; p=3
R=np.zeros((n,n,n,n))
for blk in (range(0,p),range(p,n)):
    for i in blk:
        for j in blk:
            if i!=j: R[i,j,i,j]=1; R[i,j,j,i]=-1
report(bianchi_weyl(R),"S3xS3")
