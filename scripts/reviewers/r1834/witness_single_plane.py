"""r1834 screen: from the pi/4 matching-rotated balanced product at n=2m, the diagonal mass t^2 along every single coordinate-plane rotation (grid of 361 angles), and the gradient and Hessian of t^2 over so(n) at the witness frame. Decides whether one-plane rotations can raise t from 1/n and whether the frame is a local maximum of t. Run: sage -python witness_single_plane.py 4. Seconds."""
import numpy as np, itertools, sys
from scipy.linalg import expm
m=int(sys.argv[1]); n=2*m
pairs=list(itertools.combinations(range(n),2)); N=len(pairs)
NN=(n-1)*(n-2); al=m*(m-1)/NN; be=-(m-1)**2/NN
E=np.diag([al if (a<m)==(b<m) else be for (a,b) in pairs]); E/=np.linalg.norm(E)
def L(g): return np.array([[g[p,a]*g[q,b]-g[q,a]*g[p,b] for (a,b) in pairs] for (p,q) in pairs])
g0=np.eye(n)
for k in range(m):
    R=np.eye(n); c=s=np.sqrt(.5); R[k,k]=R[m+k,m+k]=c; R[k,m+k]=-s; R[m+k,k]=s; g0=R@g0
W0=L(g0)@E@L(g0).T
def t2(h): Lh=L(h); W=Lh@W0@Lh.T; return np.sum(np.diag(W)**2)
print("t^2 at witness",t2(np.eye(n)))
best=[]
for (i,j) in pairs:
    vals=[]
    for ph in np.linspace(0,np.pi,361):
        R=np.eye(n); R[i,i]=R[j,j]=np.cos(ph); R[i,j]=-np.sin(ph); R[j,i]=np.sin(ph); vals.append(t2(R))
    best.append((max(vals),(i,j)))
best.sort(reverse=True); print("best single-plane t^2:",best[:3],"worst plane max:",best[-1])
gens=[]
for (i,j) in pairs:
    X=np.zeros((n,n)); X[i,j]=1; X[j,i]=-1; gens.append(X)
h=1e-4; f0=t2(np.eye(n))
grad=np.array([(t2(expm(h*X))-t2(expm(-h*X)))/(2*h) for X in gens])
H=np.zeros((N,N))
for a in range(N):
    for b in range(a,N):
        X=gens[a]+gens[b] if a!=b else gens[a]
        d=(t2(expm(h*X))-2*f0+t2(expm(-h*X)))/h**2
        H[a,b]=d
for a in range(N):
    for b in range(a+1,N): H[a,b]=(H[a,b]-H[a,a]-H[b,b])/2; H[b,a]=H[a,b]
ev=np.linalg.eigvalsh(H)
print("max|grad|",np.abs(grad).max(),"Hessian eigenvalues min,max",ev.min(),ev.max(),"#positive>1e-6",(ev>1e-6).sum(),"#|ev|<1e-5",(abs(ev)<1e-5).sum())
