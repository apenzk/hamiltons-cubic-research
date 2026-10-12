"""The four-set sup under a matching cap: maximise P(B_f) = 9 sum_R JJJ + 24 sum_R XXX over unit four-set parts with max_M E(M) <= c/n, by penalised ascent on the unit sphere of the B_f norm. Lower bounds only (local ascent). A screen (reviews/2026-09-28d-I121-smallmass-direct.md). Run: sage -python screen_I121_capped_fourset.py <n> <starts> <c1,c2,...>"""
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
LJ=np.zeros((nX,nv))
for k in range(len(Qs)):
    LJ[3*k,2*k]=1; LJ[3*k,2*k+1]=-1; LJ[3*k+1,2*k]=1; LJ[3*k+2,2*k+1]=1
def T(X): return np.sum(X[rects[:,0]]*X[rects[:,1]]*X[rects[:,2]])
def gradT(X):
    g=np.zeros_like(X)
    np.add.at(g,rects[:,0],X[rects[:,1]]*X[rects[:,2]])
    np.add.at(g,rects[:,1],X[rects[:,0]]*X[rects[:,2]])
    np.add.at(g,rects[:,2],X[rects[:,0]]*X[rects[:,1]])
    return g
def EM(X): return 4*np.sum(X[cl]**2,axis=1)

def PB(a):
    X=L@a; J=LJ@a
    return 9*np.sum(J[rects[:,0]]*J[rects[:,1]]*J[rects[:,2]])+24*np.sum(X[rects[:,0]]*X[rects[:,1]]*X[rects[:,2]])
def gradPB(a):
    X=L@a; J=LJ@a
    gX=np.zeros_like(X); gJ=np.zeros_like(J)
    for (u,v,w) in [(0,1,2),(1,0,2),(2,0,1)]:
        np.add.at(gX,rects[:,u],24*X[rects[:,v]]*X[rects[:,w]])
        np.add.at(gJ,rects[:,u],9*J[rects[:,v]]*J[rects[:,w]])
    return L.T@gX+LJ.T@gJ
Mnorm=(2/3)*4*(L.T@L)   # ||B_f||^2 = a^T Mnorm a
def unit(a): return a/np.sqrt(a@Mnorm@a)
rng=np.random.default_rng(3)
for c in [float(x) for x in sys.argv[3].split(',')]:
    tau=c/n; best=-9
    for st in range(starts):
        a=unit(rng.standard_normal(nv)); lam=200.0; tt=60.0
        for it in range(4000):
            X=L@a; e=EM(X); m=e.max(); w=np.exp(tt*(e-m)); w/=w.sum()
            smax=m+np.log(np.sum(np.exp(tt*(e-m))))/tt
            gE=np.zeros_like(X); np.add.at(gE,cl.ravel(),(8*X[cl]*w[:,None]).ravel())
            g=gradPB(a)-2*lam*max(0.0,smax-tau)*(L.T@gE)
            g=g-(g@Mnorm@a)*a     # tangent to the unit sphere in the B_f norm
            a=unit(a+0.02*g/(np.sqrt(g@Mnorm@g)+1e-12))
        e=EM(L@a).max(); val=PB(a)
        if e<=tau*1.02: best=max(best,val)
        print(f"  n={n} tau={c}/n={tau:.4f} start {st}: P(B_f)={val:.4f} max_M E(M)={e:.4f}",flush=True)
        if st==0: np.save(f"sfmax_n{n}_c{c}.npy",a)
    print(f"n={n} tau={c}/n: S_F(tau) >= {best:.4f}  (theta_0(n)={np.sqrt(2*(n-1)*(n-2))/n:.4f})",flush=True)
