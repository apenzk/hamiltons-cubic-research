"""Does the 'edge subspace' law generalise? Equal-block points with graph K_k."""
import sys; sys.path.insert(0,'scripts/reviewers/r300')
import numpy as np, core300 as C

def blocks_W(k,s):
    n=k*s; prs,idx=C.pairs_of(n)
    lab=np.array(sum([[b]*s for b in range(k)],[]))
    d = (k-1)*s; c = -(s-1)          # (s-1)d + (k-1)s c = 0
    W=np.zeros((len(prs),len(prs)))
    for a,(i,j) in enumerate(prs): W[a,a]= d if lab[i]==lab[j] else c
    return W/np.linalg.norm(W), n, lab

for k,s in [(3,2),(4,2),(3,3),(5,2),(2,3),(2,4)]:
    W,n,lab=blocks_W(k,s)
    if s==1: continue
    QW=C.Q(n,W); th=float(np.tensordot(W,QW)); res=float(np.linalg.norm(QW-th*W))
    ric=np.abs(C.ricci(n,W)).max()
    if res>1e-9 or abs(th)<1e-9:
        print(f"K_{k} blow-up s={s} n={n}: res={res:.1e} Ric={ric:.1e} theta={th:.4f}  -> skip"); continue
    e=W/th; B=C.weyl_basis(n); D=len(B); M,_=C.Le_matrix(n,e)
    w=C.to_coords(n,W); w/=np.linalg.norm(w)
    ev=np.linalg.eigvalsh((np.eye(D)-np.outer(w,w))@M@(np.eye(D)-np.outer(w,w)))
    dpos,_=C.delta_defect(n,W)
    S0=C.sym0_basis(n)
    def sub(pred):
        As=[A for A in S0 if all(abs(A[i,j])<1e-12 for i in range(n) for j in range(n) if not pred(i,j))]
        if not As: return None
        HA=np.array([C.D_A(n,A)@W+W@C.D_A(n,A) for A in As])
        co=np.einsum('kij,mij->km',HA,B); co=co-np.outer(co@w,w); Ub,_=C.orth_rows(co)
        if len(Ub)==0: return None
        Mv=Ub@M@Ub.T; Mv=0.5*(Mv+Mv.T); e2=np.linalg.eigvalsh(Mv)
        O=C.orbit_tangent(n,W); Oc=np.einsum('kij,mij->km',O,B); Uo,_=C.orth_rows(Oc)
        return len(Ub), float(np.trace(Mv))/len(Ub), e2[0], e2[-1], np.linalg.svd(Ub@Uo.T,compute_uv=False).max()
    t=sub(lambda i,j: lab[i]!=lab[j])
    g="--" if t is None else f"dim={t[0]:3d} tr/dim={t[1]:.6f} spec=[{t[2]:.6f},{t[3]:.6f}] maxcos_orbit={t[4]:.3f}"
    print(f"K_{k} blow-up s={s} n={n:2d}: theta={th:.6f} Delta={dpos:8.4f} lam_max={ev[-1]:.6f} | EDGE subspace {g}")
