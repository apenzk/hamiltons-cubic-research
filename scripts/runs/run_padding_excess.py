import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r30_core import (weyl_basis, Q, circ, normalize, sphere_product_W,
                             orbit_tangent, orthonormalize, pair_index)
from b_cp2_nondegenerate import padded_cp2

def LW_fast(n,W,B):
    """L_W in the orthonormal basis B, one matmul instead of D^2 tensordots."""
    D=len(B); Bf=np.array([b.ravel() for b in B])
    C=np.array([circ(n,W,X).ravel() for X in B])
    M=Bf@C.T
    return 0.5*(M+M.T)

def prof(name,Wl2,n):
    B=weyl_basis(n); D=len(B)
    W=sum(float(np.tensordot(b,Wl2))*b for b in B); W=normalize(W)
    QW=Q(n,W); th=float(np.tensordot(W,QW))
    if th<0: W=-W; QW=Q(n,W); th=-th
    res=float(np.linalg.norm(QW-th*W))
    LW=LW_fast(n,W,B)
    wv=np.array([float(np.tensordot(Y,W)) for Y in B])
    ev,U=np.linalg.eigh(LW)
    perp=[k for k in range(D) if abs(wv@U[:,k])<1e-6]
    lmax=max(ev[k] for k in perp)
    d=sum(1 for k in perp if abs(ev[k]-th/2)<1e-7)
    orb=orbit_tangent(n,W)
    ov=orthonormalize(np.array([[float(np.tensordot(Y,X)) for Y in B] for X in orb]))
    print(f"{name:<24} n={n:<3} theta={th:.6f} resid={res:.1e} "
          f"lam_max/theta={lmax/th:.6f} dimA={d:<4} orbit={len(ov):<4} EXCESS={d-len(ov):<4} "
          f"{'LOCAL MAX' if lmax<=th/2+1e-9 else 'not a max'}")

def pad(Wsmall, n0, n):
    """embed a Lambda^2(R^n0) operator into Lambda^2(R^n)."""
    p0,i0=pair_index(n0); p,i=pair_index(n); N=len(p)
    out=np.zeros((N,N))
    for a,(x,y) in enumerate(p0):
        for b,(u,v) in enumerate(p0):
            out[i[(x,y)],i[(u,v)]]=Wsmall[a,b]
    return out

print("--- S^2 x S^k : native, then padded (the record says padding creates degeneracy) ---")
for k in (4,6):
    n0=2+k
    W0,_=sphere_product_W([2,k])
    prof(f"S^2xS^{k} native", W0, n0)
    for n in (n0+2, n0+4):
        prof(f"S^2xS^{k} padded to {n}", pad(W0,n0,n), n)
print()
print("--- padded W_CP2, for contrast ---")
for n in (8,10):
    W,_=padded_cp2(n); prof(f"padded W_CP2", W, n)
