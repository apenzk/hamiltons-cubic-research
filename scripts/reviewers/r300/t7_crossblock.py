"""Does the ACROSS-BLOCK averaging instrument separate maximizers from the C_5 blow-up?"""
import sys; sys.path.insert(0,'scripts/reviewers/r300')
import numpy as np, core300 as C

def run(name, W, n, lab):
    W=W/np.linalg.norm(W); th=float(np.tensordot(W,C.Q(n,W))); e=W/th
    res=float(np.linalg.norm(C.Q(n,W)-th*W))
    B=C.weyl_basis(n); D=len(B); M,_=C.Le_matrix(n,e)
    w=C.to_coords(n,W); w/=np.linalg.norm(w)
    Pp=np.eye(D)-np.outer(w,w); ev=np.linalg.eigvalsh(Pp@M@Pp); lam=ev[-1]
    dpos,_=C.delta_defect(n,W)
    lab=np.array(lab)
    S0=C.sym0_basis(n)
    def sub(pred):
        As=[A for A in S0 if all(abs(A[i,j])<1e-12 for i in range(n) for j in range(n) if not pred(i,j))]
        if not As: return None
        HA=np.array([C.D_A(n,A)@W+W@C.D_A(n,A) for A in As])
        co=np.einsum('kij,mij->km',HA,B); co=co-np.outer(co@w,w)
        Ub,_=C.orth_rows(co)
        if len(Ub)==0: return None
        Mv=Ub@M@Ub.T; Mv=0.5*(Mv+Mv.T); evv=np.linalg.eigvalsh(Mv)
        return len(Ub), float(np.trace(Mv))/len(Ub), evv[-1], evv[0]
    allv=sub(lambda i,j: True); xb=sub(lambda i,j: lab[i]!=lab[j]); ib=sub(lambda i,j: lab[i]==lab[j])
    f=lambda t: "  --" if t is None else f"d={t[0]:3d} tr/dim={t[1]:+.6f} max={t[2]:.4f}"
    print(f"{name:16s} n={n:2d} th={th:.5f} res={res:.0e} Delta={dpos:7.4f} lam_max={lam:.6f}")
    print(f"     all Sym_0 : {f(allv)}")
    print(f"     ACROSS-blk: {f(xb)}   <-- instrument")
    print(f"     within-blk: {f(ib)}")

for p,q in [(3,3),(3,5),(4,4),(2,6),(5,5),(3,7),(2,4)]:
    W,n=C.sphere_pair(p,q); run(f"S^{p}xS^{q}", W, n, [0]*p+[1]*q)
W,n=C.c5_blowup(); run("C5 blowup", W, n, sum([[b]*2 for b in range(5)],[]))
