"""M4: the SO(10)-conjugate of the C_5 blow-up, and the positivity step."""
import sys, numpy as np, itertools
sys.path.insert(0,'scripts/reviewers/r313')
import r313_lib as R
from r313_grading import lam2_of

def blocks(n, W, tol=1e-9):
    ev,V=np.linalg.eigh(W)
    m=[k for k in range(len(ev)) if ev[k] < -tol]
    h=[k for k in range(len(ev)) if ev[k] >= -tol]
    return V[:,h], V[:,m], ev

def Sblocks(n, H, Mm):
    """S_hhh, S_hhm, S_hmm, S_mmm from the structure tensor in the given ON bases."""
    c=R.struct(n)
    def S(X,Y,Z):
        # sum over a in X, b in Y, cc in Z of <[phi_a,phi_b],phi_cc>^2
        t=np.einsum('abc,bi,cj,ak->ijk', c, X, Y, Z, optimize=True)
        return float(np.sum(t*t))
    return dict(hhh=S(H,H,H), hhm=S(H,H,Mm), hmm=S(H,Mm,Mm), mmm=S(Mm,Mm,Mm))

def has_coord_grading(n,W,tol=1e-8):
    hits=0
    P=R.pairs(n)
    for bits in range(1,2**(n-1)):
        s=np.array([1.0]+[1.0 if (bits>>k)&1 else -1.0 for k in range(n-1)])
        L=np.diag([s[i]*s[j] for (i,j) in P])
        if np.linalg.norm(L@W-W@L)<tol: hits+=1
    return hits

# ---- C_5 blow-up at n = 10
n=10
blk=[i//2 for i in range(n)]
def cls(a,b):
    if a==b: return None
    if blk[a]==blk[b]: return 0
    d=(blk[a]-blk[b])%5
    return 1 if d in (1,4) else 2
x,y,z=0.29814239699997197,-0.14907119849998599,0.07453559924999299
M=np.zeros((n,n))
for a in range(n):
    for b in range(n):
        cc=cls(a,b)
        if cc is not None: M[a,b]=(x,y,z)[cc]
P=R.pairs(n); N=len(P)
W=np.zeros((N,N))
for t,(i,j) in enumerate(P): W[t,t]=M[i,j]
W/=np.sqrt(np.tensordot(W,W,axes=2))
res,th=R.crit_residual(n,W)
print(f"C_5 blow-up n=10: theta={th:.9f} res={res:.1e}  row sums {np.abs(M.sum(1)).max():.1e}")
H,Mm,ev=blocks(n,W)
print(f"  dim h = {H.shape[1]}, dim m = {Mm.shape[1]}, floor(n^2/4) = {n*n//4}")
print("  block masses:", {k:round(v,9) for k,v in Sblocks(n,H,Mm).items()})
print("  coordinate Z2-involutions commuting with W:", has_coord_grading(n,W))

for s in (11,22,33):
    rng=np.random.default_rng(s)
    A=rng.standard_normal((n,n)); Qm,_=np.linalg.qr(A)
    if np.linalg.det(Qm)<0: Qm[:,0]*=-1
    L=lam2_of(n,Qm)
    Wc=L.T@W@L
    res2,th2=R.crit_residual(n,Wc)
    Hc,Mc,evc=blocks(n,Wc)
    sb=Sblocks(n,Hc,Mc)
    # gradedness in the brief's sense is O(n)-invariant: Lambda^2(Qm g Qm^T) works
    print(f"  conjugate seed {s}: theta={th2:.9f} res={res2:.1e} dim m={Mc.shape[1]} "
          f"S_mmm={sb['mmm']:.3e} S_hhm={sb['hhm']:.6f} S_hmm={sb['hmm']:.6f}")

# ---- padded W_CP2, the stronger witness
print("\n--- padded W_CP2 (theta = sqrt(3/2)) ---")
for nn in (8,10,12,14):
    P4=R.pairs(4)
    D4=R.pidx(4)
    def bv(ps):
        v=np.zeros(len(P4))
        for (i,j),sg in ps:
            a,sa=D4[(i,j)]; v[a]+=sg*sa
        return v/np.linalg.norm(v)
    u1=bv([((0,1),1),((2,3),1)]); u2=bv([((0,2),1),((3,1),1)]); u3=bv([((0,3),1),((1,2),1)])
    c=1/np.sqrt(6)
    W4=c*(2*np.outer(u1,u1)-np.outer(u2,u2)-np.outer(u3,u3))
    Pn=R.pairs(nn); Nn=len(Pn); Wp=np.zeros((Nn,Nn))
    for a,(i,j) in enumerate(P4):
        for b,(k,l) in enumerate(P4):
            Wp[Pn.index((i,j)),Pn.index((k,l))]=W4[a,b]
    r2,t2=R.crit_residual(nn,Wp)
    Hh,Mm2,e2=blocks(nn,Wp)
    sb=Sblocks(nn,Hh,Mm2)
    print(f"  n={nn}: theta={t2:.12f} res={r2:.1e} dim m={Mm2.shape[1]} "
          f"S_mmm={sb['mmm']:.3e} S_hhm={sb['hhm']:.6f} (4(n-4)={4*(nn-4)})  in Weyl: {np.linalg.norm(Wp-R.proj_weyl(nn,Wp)):.1e}")
