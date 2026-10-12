"""T4 second half + T5: continuity of S as a FUNCTION, openness of {S=0},
and whether S is locally constant on Crit(P)."""
import numpy as np, time
from review_r47_core import *
from review_r47_t3 import cp_m, support_rank
from review_r47_t3b import block_sum, embed

rng = np.random.default_rng(11)
g4,Wcp2 = cp_m(2); g6=Geom(6); W33=sphere_product(g6,3,3)

print("### T4b: is S continuous as a FUNCTION at the padded W_CP2?")
for n in (8,10):
    g=Geom(n); Bas=g.weyl_basis(); Bm=Bas.reshape(Bas.shape[0],-1)
    W=pad(g4,g,Wcp2)
    st0=struct_sums(g,W)
    print(f" n={n}: at the point itself  S={st0['S']:.3e} dim m={st0['dim_m']}")
    for eps in (1e-2,1e-4,1e-6,1e-8):
        vals=[]; dims=[]
        for _ in range(8):
            c=rng.normal(size=Bas.shape[0]); H=(c@Bm).reshape(g.N,g.N); H/=np.linalg.norm(H)
            Wp=W+eps*H; Wp/=np.linalg.norm(Wp)
            st=struct_sums(g,Wp); vals.append(st['S']); dims.append(st['dim_m'])
        print(f"   eps={eps:.0e}: S in [{min(vals):.4f},{max(vals):.4f}]  dim m in [{min(dims)},{max(dims)}]")
    # contrast: a point with no kernel
    Ws=sphere_product(g,n//2,n//2)
    for eps in (1e-2,1e-4):
        vals=[]
        for _ in range(8):
            c=rng.normal(size=Bas.shape[0]); H=(c@Bm).reshape(g.N,g.N); H/=np.linalg.norm(H)
            Wp=Ws+eps*H; Wp/=np.linalg.norm(Wp); vals.append(struct_sums(g,Wp)['S'])
        print(f"   [contrast S^{n//2}xS^{n//2}, no kernel] eps={eps:.0e}: S in [{min(vals):.3e},{max(vals):.3e}]")

print("\n### T4b: lower semicontinuity of S (m can only grow in the limit)")
print(" S(W) = sum over an ONB of m(W); if W_k -> W then dim m(W_k) >= dim m(W) eventually and")
print(" m(W_k) -> a subspace containing lim m(W); S is monotone in m, so liminf S(W_k) >= S(W).")
n=8; g=Geom(8); W=pad(g4,g,Wcp2)
Bas=g.weyl_basis(); Bm=Bas.reshape(Bas.shape[0],-1)
mins=[]
for _ in range(200):
    c=rng.normal(size=Bas.shape[0]); H=(c@Bm).reshape(g.N,g.N); H/=np.linalg.norm(H)
    Wp=W+1e-6*H; Wp/=np.linalg.norm(Wp); mins.append(struct_sums(g,Wp)['S'])
print(f" 200 random 1e-6 perturbations of padded W_CP2: min S = {min(mins):.6f}  (S at the point = 0)")

print("\n### T5: is S locally constant on Crit? -- nondegeneracy of the new S=0 ungraded points")
cases=[("CP2 (+) CP2, n=8", 8, [(list(range(4)),g4,Wcp2),(list(range(4,8)),g4,Wcp2)]),
       ("S3xS3 padded, n=8", None, None)]
for tag,n,pieces in cases:
    if pieces is None:
        g=Geom(8); W=pad(g6,g,W33)
    else:
        g,W,_,_=block_sum(n,pieces)
    th,res=crit_residual(g,W); e=W/th
    Bas=g.weyl_basis(); L=Le_matrix(g,e,Bas); L=(L+L.T)/2
    ev=np.linalg.eigvalsh(L)
    nh=int(np.sum(np.abs(ev-0.5)<1e-8)); od=orbit_dim(g,W)
    print(f" {tag:24s} theta={th:.9f} dim E(1/2)={nh} orbit={od} excess={nh-od}"
          f" {'NONDEGENERATE' if nh==od else 'DEGENERATE'}")
    if nh>od:
        # corrector: push along excess directions and re-solve for a critical point
        from scipy.optimize import least_squares
        dW=Bas.shape[0]; Bm=Bas.reshape(dW,-1)
        idx=np.where(np.abs(ev-0.5)<1e-8)[0]
        V=np.linalg.eigh(L)[1][:,idx]           # excess + orbit directions, in Weyl coords
        # remove orbit tangent
        Orows=[]
        for X in g.so_basis():
            adX=g.ad(X); Orows.append(Bm@ (adX@W-W@adX).ravel())
        O=np.array(Orows)
        Op = O - O@np.zeros((O.shape[1],O.shape[1]))
        # orthonormal basis of the orbit tangent inside Weyl coords
        qo,ro = np.linalg.qr(O.T)
        rk = int((np.abs(np.diag(ro))>1e-9*max(1.0,np.abs(ro).max())).sum())
        qo = qo[:,:rk]
        Vp = V - qo@(qo.T@V)
        qe,re = np.linalg.qr(Vp)
        keep = np.abs(np.diag(re))>1e-8*max(1.0,np.abs(re).max())
        exc = qe[:, keep]
        print(f"   orbit rank={rk}, excess directions after removing orbit = {exc.shape[1]}")
        def W_of(c):
            M=(c@Bm).reshape(g.N,g.N); return M/np.linalg.norm(M)
        def resid(c):
            M=W_of(c); QM=g.Q(M); t=float((QM*M).sum()); return Bm@(QM-t*M).ravel()
        c0 = Bm@W.ravel()
        news=0; back=0
        for k in range(min(24,exc.shape[1])):
            for t in (0.15,0.3):
                sol=least_squares(resid, c0+t*exc[:,k], method='lm', xtol=1e-14, ftol=1e-14, max_nfev=3000)
                M=W_of(sol.x); th2,r2=crit_residual(g,M)
                if r2>1e-10: continue
                st=struct_sums(g,M)
                d=np.linalg.norm(M-W)
                if st['S']>1e-10:
                    news+=1
                    print(f"   !! corrector reached an S>0 critical point: theta={th2:.9f} S={st['S']:.4f} dist={d:.4f}")
                else: back+=1
        print(f"   correctors: {back} returned to S=0, {news} reached S>0")
