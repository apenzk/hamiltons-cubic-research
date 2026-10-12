# I73, symmetric family: the reduction theta <= M(V)/(2 d^{3/2}), V = E0 + E2, d = 2p, turns the family into one cap:
# is M(V) = sum_{u,v,w in ONB(V)} <[u,v],w>^2 < 2 theta0(n) d^{3/2} for every d-dim subspace V of so(n)?
# Screen (refutation instrument, local maxima = lower bounds): projected gradient ascent of M/d^{3/2} over the Grassmannian.
# Record normalisation, e_i^e_j unit. /usr/bin/python3 <log> n d1 d2 ...
import sys, time, itertools, numpy as np
log=open(sys.argv[1],'w'); n=int(sys.argv[2]); ds=[int(x) for x in sys.argv[3:]]
def L(*a): print(time.strftime('%H:%M:%S'),*a,file=log,flush=True)
prs=list(itertools.combinations(range(n),2)); N=len(prs)
E=np.zeros((N,n,n))
for k,(i,j) in enumerate(prs): E[k,i,j]=1; E[k,j,i]=-1
f=(np.einsum('aij,bjk,cik->abc',E,E,E)-np.einsum('bij,ajk,cik->abc',E,E,E))/2
th0=np.sqrt(2*(n-1)*(n-2))/n; rng=np.random.default_rng(1)
def Mval(X):
    FX=np.einsum('ijk,jb->ikb',f,X); T=np.einsum('ikb,ia,kc->abc',FX,X,X); return np.sum(T**2),T,FX
L('START pid',__import__('os').getpid(),f'plan: n={n}, d in {ds}, 3 restarts x 600 iters, theta0={th0:.6f}')
for d in ds:
    best=0
    for r in range(3):
        X,_=np.linalg.qr(rng.normal(size=(N,d))); lr=0.05
        for it in range(600):
            M,T,FX=Mval(X); G=6*np.einsum('abc,ikb,kc->ia',T,FX,X)
            while lr>1e-9:
                Xn,_=np.linalg.qr(X+lr*G)
                if Mval(Xn)[0]>=M: X=Xn; lr*=1.3; break
                lr*=0.5
        M=Mval(X)[0]; best=max(best,M)
        L(f'd={d} restart {r}: M={M:.4f} ratio M/(2d^1.5)={M/(2*d**1.5):.4f}')
    L(f'RESULT n={n} d={d} bestM={best:.4f} ratio={best/(2*d**1.5):.4f} theta0={th0:.4f} {"BELOW" if best/(2*d**1.5)<th0 else "ABOVE"}')
L('DONE')
