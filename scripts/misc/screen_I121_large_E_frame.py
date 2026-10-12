"""Large E and the maximal frame: take the capped four-set maximiser saved by screen_I121_capped_fourset.py (first start, cap c/n, saved as sfmax_n<n>_c<c>.npy in the working directory), build it as an operator, compute E = P - (3/2) tr W^3 with the record's Q, and ascend t^2 over O(n) from four random frames. The t^2 found is exact in an explicit frame, so it is a lower bound on the maximal-frame mass. A screen (reviews/2026-09-28d-I121-smallmass-direct.md). Run: sage -python screen_I121_capped_fourset.py <n> 1 <c> (after adding the save), then sage -python screen_I121_large_E_frame.py <n> <c>"""
import numpy as np, itertools, sys, runpy
import scipy.linalg as sla
n=int(sys.argv[1]); c=sys.argv[2]
sys.argv=['x',str(n)]
g=runpy.run_path(__import__('os').path.join(__import__('os').path.dirname(__import__('os').path.abspath(__file__)),'check_I121_rectangle_cubic.py'))
Qb=g['Qb']; idx=g['idx']; N=g['N']; setent=g['setent']
a=np.load(f"sfmax_n{n}_c{c}.npy")
Qs=list(itertools.combinations(range(n),4))
W=np.zeros((N,N))
for k,Q in enumerate(Qs):
    i,j,kk,l=Q; A2,A3=a[2*k],a[2*k+1]; A1=A2-A3
    setent(W,i,j,kk,l,A1); setent(W,i,kk,j,l,A2); setent(W,i,l,j,kk,A3)
W/=np.linalg.norm(W)
P=np.sum(Qb(W,W)*W); tr=np.trace(W@W@W)
print(f"n={n} c={c}: unit B_f, P={P:.4f}, tr W^3={tr:.4f}, E={P-1.5*tr:.4f}, t^2 in this frame={np.sum(np.diag(W)**2):.4f}",flush=True)
pairs=list(idx.keys())
def rot_op(gm):
    Lg=np.zeros((N,N))
    for (p1,q1),col in idx.items():
        for (p2,q2),row in idx.items():
            Lg[row,col]=gm[p2,p1]*gm[q2,q1]-gm[q2,p1]*gm[p2,q1]
    return Lg
gens=[]
for a_ in range(n):
    for b_ in range(a_+1,n):
        X=np.zeros((n,n)); X[a_,b_]=1; X[b_,a_]=-1; gens.append(X)
def t2(gm): L=rot_op(gm); return np.sum(np.diag(L@W@L.T)**2)
rng=np.random.default_rng(0); best=0
for st in range(4):
    gm,_=np.linalg.qr(rng.standard_normal((n,n)))
    f=t2(gm)
    for it in range(150):
        h=1e-4; grad=np.array([(t2(sla.expm(h*X)@gm)-f)/h for X in gens])
        gm=sla.expm(0.4*sum(cc*X for cc,X in zip(grad,gens)))@gm; f=t2(gm)
    best=max(best,f); print(f"   ascent start {st}: t^2 = {f:.4f}",flush=True)
print(f"n={n} c={c}: t_max^2 >= {best:.4f}",flush=True)
