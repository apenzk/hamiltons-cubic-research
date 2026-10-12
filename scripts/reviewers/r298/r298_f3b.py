"""F3, the sharp form: the orbit component of ANY test direction contributes exactly zero
to the second-order quadratic form <v,(L_e - 1/2)v>.  So no choice of test direction can
convert orbit motion into a violation."""
import sys, numpy as np
sys.path.insert(0,'scripts/reviewers/r298')
import r298_core as C

def c5(sizes=(2,)*5):
    k=len(sizes); n=sum(sizes); P=C.pairs(n)
    G=[[1 if (abs(a-b)%k in (1,k-1)) else 0 for b in range(k)] for a in range(k)]
    lab=[]
    for bi,b in enumerate(sizes): lab+=[bi]*b
    W=np.zeros((len(P),len(P)))
    for a,(i,j) in enumerate(P):
        W[a,a]=4.0 if lab[i]==lab[j] else (-2.0 if G[lab[i]][lab[j]] else 1.0)
    return W/np.linalg.norm(W), n

def test(n, W, lbl):
    W=W/np.linalg.norm(W); th=float(np.sum(W*C.Qf(n,W)))
    B=C.weyl_basis(n)
    OT=C.orbit_tangent(n,W).reshape(-1,W.shape[0]**2)
    u,s,vt=np.linalg.svd(OT,full_matrices=False); r=int((s>1e-9*s[0]).sum())
    Ob=vt[:r]
    rng=np.random.default_rng(9); worst=0.0; worst_cross=0.0
    for t in range(40):
        v=np.einsum('k,kij->ij',rng.normal(size=B.shape[0]),B); v-= np.sum(v*W)*W
        v/=np.linalg.norm(v)
        o=np.einsum('k,kij->ij',Ob@v.ravel(),Ob.reshape(r,*W.shape))
        x=v-o
        f=lambda a,b: float(np.sum(a*C.circ_f(n,W,b)))/th-0.5*float(np.sum(a*b))
        worst=max(worst,abs(f(v,v)-f(x,x)))
        worst_cross=max(worst_cross,abs(f(o,x)))
    print(f"  {lbl:22s} dim orbit {r:3d}  max |<v,(L_e-1/2)v> - <x,(L_e-1/2)x>| = {worst:.2e}"
          f"   max |cross term| = {worst_cross:.2e}")

for blocks in ([3,3],[3,5]):
    n=sum(blocks); test(n,C.sphere_product(blocks),"S^"+"xS^".join(map(str,blocks)))
test(6,C.cpm(3),"CP^3")
Wc,nc=c5(); test(nc,Wc,"C_5 blow-up (Delta=12)")
