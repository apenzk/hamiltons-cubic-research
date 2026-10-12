"""r1833 screen: at the pi/4 matching-rotated balanced product (n=2m), is the standard frame first- and second-order stationary for t^2, and what does a single-plane finite rotation do? Seconds. sage -python r1833_frame_screen.py 4 6"""
import numpy as np, itertools, sys
from scipy.linalg import expm
def build(m):
    n=2*m; N=(n-1)*(n-2); al=m*(m-1)/N; be=-(m-1)**2/N
    U=np.zeros((n,m)); V=np.zeros((n,m))
    for k in range(m):
        U[k,k]=U[m+k,k]=1/np.sqrt(2); V[k,k]=-1/np.sqrt(2); V[m+k,k]=1/np.sqrt(2)
    def K(G): return np.einsum('ac,bd->abcd',G,G)-np.einsum('ad,bc->abcd',G,G)
    R=be*K(np.eye(n))+(al-be)*(K(U@U.T)+K(V@V.T))
    return n,R/np.sqrt(np.sum(R**2)/4)
def t2(R,O):
    T=np.einsum('abcd,ai,bj,ck,dl->ijkl',R,O,O,O,O,optimize=True)
    n=O.shape[0]; return sum(T[i,j,i,j]**2 for i in range(n) for j in range(i+1,n))
def pairmass(R,O):
    T=np.einsum('abcd,ai,bj,ck,dl->ijkl',R,O,O,O,O,optimize=True); n=O.shape[0]; s=0
    for i,j,k in itertools.permutations(range(n),3):
        if i<j: s+=T[i,k,j,k]**2
    return s  # each unordered {i,j} once per c, times symmetric counterpart counted in HS
for m in map(int,sys.argv[1:]):
    n,R=build(m); gens=[]
    for i,j in itertools.combinations(range(n),2):
        X=np.zeros((n,n)); X[i,j]=1; X[j,i]=-1; gens.append(X)
    f0=t2(R,np.eye(n)); h=1e-4
    f=lambda x: t2(R,expm(sum(c*X for c,X in zip(x,gens))))
    d=len(gens); grad=np.zeros(d); H=np.zeros((d,d)); E=np.eye(d)
    for a in range(d): grad[a]=(f(h*E[a])-f(-h*E[a]))/(2*h)
    for a in range(d):
        for b in range(a,d):
            H[a,b]=H[b,a]=(f(h*(E[a]+E[b]))-f(h*(E[a]-E[b]))-f(h*(-E[a]+E[b]))+f(-h*(E[a]+E[b])))/(4*h*h)
    ev=np.linalg.eigvalsh(H)
    print(f"m={m} n={n}: t^2={f0:.6f} (1/n={1/n:.6f}) pair={pairmass(R,np.eye(n)):.2e} |grad|={np.linalg.norm(grad):.2e} Hess eig max={ev[-1]:.4f} min={ev[0]:.4f} #pos={np.sum(ev>1e-5)}")
    for name,(i,j) in [("matching (p1,q1)",(0,m)),("within P (p1,p2)",(0,1)),("cross (p1,q2)",(0,m+1))]:
        X=np.zeros((n,n)); X[i,j]=1; X[j,i]=-1
        vals=[t2(R,expm(th*X)) for th in np.linspace(-np.pi/2,np.pi/2,181)]
        print(f"   single plane {name}: max t^2 over angle = {max(vals):.6f}")
    Xall=np.zeros((n,n))
    for k in range(m): Xall[k,m+k]=1; Xall[m+k,k]=-1
    print(f"   all-matching inverse rotation -pi/4: t^2={t2(R,expm(np.pi/4*Xall)):.6f}, +pi/4: {t2(R,expm(-np.pi/4*Xall)):.6f}")
