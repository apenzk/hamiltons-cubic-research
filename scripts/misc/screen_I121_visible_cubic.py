"""The visible cubic under the matching family alone: maximise T(X) = sum_R X12 X13 X23 over four-set parts (per four-set (A2, A3), A1 = A2 - A3, X(pi1) = (A2+A3)/2, X(pi2) = (A1-A3)/2, X(pi3) = (-A1-A2)/2) against max_M E(M)^(3/2), E(M) = sum over the blocks of M of 4X^2; at unit four-set mass report max E(M), the visible cubic 24T and the diagonal square |D(B_f)|, D(B_f)_ij = sum (3/2 J^2 - 2 X^2). A screen (reviews/2026-09-28d-I121-smallmass-direct.md). Run: sage -python screen_I121_visible_cubic.py <n> <starts>"""
import numpy as np, itertools, sys
n=int(sys.argv[1]); starts=int(sys.argv[2]) if len(sys.argv)>2 else 6
Qs=list(itertools.combinations(range(n),4)); qi={Q:k for k,Q in enumerate(Qs)}
nv=2*len(Qs)
# X index for (Q, pairing given as frozenset of two edges)
def xkey(e,f):
    Q=tuple(sorted(e+f)); i,j,k,l=Q
    E={frozenset([(i,j),(k,l)]):0, frozenset([(i,k),(j,l)]):1, frozenset([(i,l),(j,k)]):2}[frozenset([tuple(sorted(e)),tuple(sorted(f))])]
    return 3*qi[Q]+E
nX=3*len(Qs)
L=np.zeros((nX,nv))
for k,Q in enumerate(Qs):
    a2,a3=2*k,2*k+1   # A1=a2-a3
    L[3*k,a2]=.5; L[3*k,a3]=.5            # (A2+A3)/2
    L[3*k+1,a2]=.5; L[3*k+1,a3]=-1.0      # (A1-A3)/2 = (A2-2A3)/2
    L[3*k+2,a2]=-1.0; L[3*k+2,a3]=.5      # (-A1-A2)/2 = (-2A2+A3)/2
rects=[]
for S in itertools.combinations(range(n),6):
    a=S[0]; rest=list(S[1:])
    for b in rest:
        r2=[x for x in rest if x!=b]; c=r2[0]
        for d in r2[1:]:
            r3=tuple(x for x in r2 if x not in (c,d))
            E=[(a,b),(c,d),r3]
            rects.append((xkey(E[0],E[1]),xkey(E[0],E[2]),xkey(E[1],E[2])))
rects=np.array(rects)
def matchings(lst):
    if not lst: yield []; return
    a=lst[0]
    for j in range(1,len(lst)):
        rest=lst[1:j]+lst[j+1:]
        for m in matchings(rest): yield [(a,lst[j])]+m
cl=[]
for M in matchings(list(range(n))):
    cl.append([xkey(M[x],M[y]) for x in range(len(M)) for y in range(x+1,len(M))])
cl=np.array(cl)
print(f"n={n}: {len(Qs)} four-sets, {len(rects)} rectangles, {len(cl)} matchings",flush=True)
def T(X): return np.sum(X[rects[:,0]]*X[rects[:,1]]*X[rects[:,2]])
def gradT(X):
    g=np.zeros_like(X)
    np.add.at(g,rects[:,0],X[rects[:,1]]*X[rects[:,2]])
    np.add.at(g,rects[:,1],X[rects[:,0]]*X[rects[:,2]])
    np.add.at(g,rects[:,2],X[rects[:,0]]*X[rects[:,1]])
    return g
def EM(X): return 4*np.sum(X[cl]**2,axis=1)
rng=np.random.default_rng(1)
best=-1
for st in range(starts):
    a=rng.standard_normal(nv)
    tau=40.0
    for it in range(3000):
        X=L@a; e=EM(X); m=e.max(); w=np.exp(tau*(e-m)); w/=w.sum()
        smax=m+np.log(np.sum(np.exp(tau*(e-m))))/tau
        # objective f = T / smax^{3/2}
        t=T(X); gT=gradT(X)
        gE=np.zeros_like(X); np.add.at(gE,cl.ravel(),(8*X[cl]*w[:,None]).ravel())
        gX=gT/smax**1.5-1.5*t*gE/smax**2.5
        ga=L.T@gX
        a=a+0.05*ga/ (np.linalg.norm(ga)+1e-12)*np.linalg.norm(a)
        a/=np.linalg.norm(a)
    X=L@a; val=T(X)/EM(X).max()**1.5
    best=max(best,val)
    # unit four-set mass: ||B_f||^2 = (2/3) sum_all 4X^2 ; D(B_f)_ij = sum_{kl} (3/2 J^2 - 2 X^2) over pairings (ij|kl)
    sc=1/np.sqrt((2/3)*np.sum(4*X**2)); Xu=X*sc; au=a*sc
    D=np.zeros((n,n))
    for k,Q in enumerate(Qs):
        i,j,kk,l=Q; A2,A3=au[2*k],au[2*k+1]; A1=A2-A3
        Xs=Xu[3*k:3*k+3]; Js=[A1,A2,A3]
        for (e,f),x,J in zip([((i,j),(kk,l)),((i,kk),(j,l)),((i,l),(j,kk))],Xs,Js):
            v=1.5*J*J-2*x*x
            D[e]+=v; D[e[::-1]]+=v; D[f]+=v; D[f[::-1]]+=v
    nD=np.sqrt(np.sum(np.triu(D,1)**2)); tu=np.sqrt(EM(Xu).max())
    print(f"     unit B_f: max_M E(M) = {EM(Xu).max():.4f} (t >= {tu:.3f}), visible cubic 24T = {24*T(Xu):.4f}, |D(B_f)| = {nD:.4f} vs theta*t ~ {1.3*tu:.3f}",flush=True)
    print(f"  start {st}: T/maxE^1.5 = {val:.5f}   (fourset mass sum_pi 4X^2 / maxE = {np.sum(4*X**2)/EM(X).max():.2f})",flush=True)
print(f"n={n}: kappa_n >= {best:.5f}",flush=True)
