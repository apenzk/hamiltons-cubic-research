"""R30: n=8 triality residue for N5, plus u(m) critical points and their Hessians."""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r30_core import *
from review_r30_spec import le_matrix, cluster
from review_r30_inv import invariant_weyl, gradedness, subalg_u, subalg_so_pq, spin7_so8

def quat_mul(a,b):
    aw,ax,ay,az=a; bw,bx,by,bz=b
    return np.array([aw*bw-ax*bx-ay*by-az*bz,
                     aw*bx+ax*bw+ay*bz-az*by,
                     aw*by-ax*bz+ay*bw+az*bx,
                     aw*bz+ax*by-ay*bx+az*bw])

def sp1_sp2_so8():
    """sp(1)+sp(2) < so(8) acting on H^2 = R^8.
    sp(2): quaternionic 2x2 anti-hermitian matrices acting on the LEFT.
    sp(1): right multiplication by an imaginary quaternion."""
    n=8
    # R^8 coordinates: (q1, q2) with q = w + xi + yj + zk -> (w,x,y,z)
    def Lmat(i,j,q):
        """left mult of entry: contributes q to slot (i,j) of the 2x2 quaternionic matrix"""
        M=np.zeros((8,8))
        for c in range(4):
            e=np.zeros(4); e[c]=1
            v=quat_mul(q,e)          # q * e_c
            M[4*i:4*i+4, 4*j+c] = v
        return M
    gens=[]
    im=[np.array([0.,1,0,0]),np.array([0.,0,1,0]),np.array([0.,0,0,1])]
    # diagonal: q_ii imaginary
    for i in range(2):
        for q in im:
            gens.append(Lmat(i,i,q))
    # off-diagonal: A_12 = q, A_21 = -conj(q), q in H (4 real params)
    for c in range(4):
        q=np.zeros(4); q[c]=1
        qc=q.copy(); qc[1:]*=-1
        gens.append(Lmat(0,1,q)+Lmat(1,0,-qc))
    # sp(1) acting by RIGHT multiplication by imaginary quaternion (commutes with left action)
    def Rmat(q):
        M=np.zeros((8,8))
        for i in range(2):
            for c in range(4):
                e=np.zeros(4); e[c]=1
                v=quat_mul(e,q)
                M[4*i:4*i+4, 4*i+c] = v
        return M
    for q in im: gens.append(Rmat(q))
    G=np.array(gens)
    # check antisymmetry
    asym=max(np.abs(g+g.T).max() for g in G)
    # convert to phi-basis coefficient vectors and orthonormalize
    pairs,idx=pair_index(8)
    V=np.array([[g[i,j] for (i,j) in pairs] for g in G])
    u,s,vt=np.linalg.svd(V, full_matrices=False)
    r=int((s>1e-10*s[0]).sum())
    return vt[:r], asym, r

def closure_check(n, hb):
    """is h a subalgebra? measure ||Pi_m [h,h]||."""
    c=structure_constants(n)
    Ph=hb.T@hb; Pm=np.eye(hb.shape[1])-Ph
    br=np.einsum('xa,yb,abg->xyg',hb,hb,c)
    return float(np.linalg.norm(np.einsum('xyg,gh->xyh',br,Pm)))

def analyze_point(n, W, name):
    W=normalize(W)
    th=float(np.tensordot(W,Q(n,W)))
    if th<0: W=-W; th=-th
    res=np.linalg.norm(Q(n,W)-th*W)
    e=W/th
    B=weyl_basis(n); d=B.shape[0]
    L,_=le_matrix(n,e,B,want_leak=False); L=0.5*(L+L.T)
    w,V=np.linalg.eigh(L)
    sel=np.abs(w-0.5)<1e-8
    Bf=B.reshape(d,-1)
    Emat=(V[:,sel].T@Bf)
    T=orbit_tangent(n,W); U=orthonormalize(T)
    cos=principal_cosines(Emat,U)
    others=w[~sel]; below=others[others<0.5]
    print(f"--- {name} n={n} theta={th:.9f} resid={res:.1e}")
    print(f"    dim E(1/2)={int(sel.sum())}  dim orbit={U.shape[0]}  ||Pi_E-Pi_T||={np.linalg.norm(Emat.T@Emat-U.T@U,2):.2e}"
          f"  cos_min={cos.min() if cos.size else float('nan'):.10f}")
    print(f"    spectrum: "+"  ".join(f"{v:.8f}^{m}" for v,m in cluster(w)))
    print(f"    nearest below 1/2 = {below.max():.10f}  gap={0.5-below.max():.4e}   above 1/2: {sorted(set(np.round(others[others>0.5],9)))}")
    print(f"    eigenvalues of W: "+"  ".join(f"{v:.8f}^{m}" for v,m in cluster(np.linalg.eigvalsh(W))))
    return th

if __name__=="__main__":
    print("### u(m) invariant points (= CP^m Weyl operators) ###")
    for m in (3,4,5,6):
        n,hb=subalg_u(m)
        dim,bas,ev=invariant_weyl(n,hb)
        print(f"[u({m})] dim Weyl_{n}^h = {dim}")
        if dim==1: analyze_point(n,bas[0],f"CP^{m} (u({m}))")
    print()
    print("### n=8 triality residue ###")
    hb,asym,r=sp1_sp2_so8()
    print(f"sp(1)+sp(2)<so(8): antisym check {asym:.1e}, dim h = {r} (expect 13)")
    print(f"   subalgebra closure residual = {closure_check(8,hb):.2e}")
    sl,tot,dh=gradedness(8,hb)
    print(f"   slack [m,m]->m = {sl:.2e}  (||[m,m]||^2={tot:.3f})  symmetric pair = {sl<1e-18}")
    dim,bas,ev=invariant_weyl(8,hb)
    print(f"   dim Weyl_8^(sp(1)+sp(2)) = {dim}")
    if dim>=1: analyze_point(8,bas[0],"sp(1)+sp(2) invariant")
    print()
    print("### is W_{u(4)} the same SO(8)-orbit as W_{S^2 x S^6}? ###")
    n,hb=subalg_u(4); dim,bas,ev=invariant_weyl(8,hb)
    Wu=normalize(bas[0]); 
    if float(np.tensordot(Wu,Q(8,Wu)))<0: Wu=-Wu
    Ws,_=sphere_product_W((2,6)); Ws=normalize(Ws)
    print("   eig(W_u4):", "  ".join(f"{v:.8f}^{m}" for v,m in cluster(np.linalg.eigvalsh(Wu))))
    print("   eig(W_S2S6):","  ".join(f"{v:.8f}^{m}" for v,m in cluster(np.linalg.eigvalsh(Ws))))
