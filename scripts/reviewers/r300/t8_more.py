"""More Delta>0 critical points, and the across-block instrument on them."""
import sys, time; sys.path.insert(0,'scripts/reviewers/r300')
import numpy as np, core300 as C

def ck_unit(k, adjv=-1.0, nonadj=1.0):
    n=k; prs,idx=C.pairs_of(n); N=len(prs)
    G=[[0]*k for _ in range(k)]
    for a in range(k): G[a][(a+1)%k]=G[(a+1)%k][a]=1
    W=np.zeros((N,N))
    for a,(i,j) in enumerate(prs): W[a,a]= adjv if G[i][j] else nonadj
    return W/np.linalg.norm(W), n

def full(name,W,n,lab):
    W=W/np.linalg.norm(W); QW=C.Q(n,W); th=float(np.tensordot(W,QW)); res=float(np.linalg.norm(QW-th*W))
    ric=np.abs(C.ricci(n,W)).max(); alt=np.abs(C.alt_defect(n,W)).max() if C.alt_defect(n,W).size else 0
    if res>1e-8 or ric>1e-8 or alt>1e-8:
        print(f"{name:14s} n={n}: NOT a Weyl critical point (res={res:.1e} Ric={ric:.1e} Alt={alt:.1e})"); return
    e=W/th; B=C.weyl_basis(n); D=len(B); M,_=C.Le_matrix(n,e)
    w=C.to_coords(n,W); w/=np.linalg.norm(w); Pp=np.eye(D)-np.outer(w,w)
    ev=np.linalg.eigvalsh(Pp@M@Pp); lam=ev[-1]; dpos,_=C.delta_defect(n,W)
    lab=np.array(lab); S0=C.sym0_basis(n)
    def sub(pred):
        As=[A for A in S0 if all(abs(A[i,j])<1e-12 for i in range(n) for j in range(n) if not pred(i,j))]
        HA=np.array([C.D_A(n,A)@W+W@C.D_A(n,A) for A in As]) if As else np.zeros((0,B.shape[1],B.shape[1]))
        if len(HA)==0: return None
        co=np.einsum('kij,mij->km',HA,B); co=co-np.outer(co@w,w)
        Ub,_=C.orth_rows(co)
        if len(Ub)==0: return None
        Mv=Ub@M@Ub.T; return len(Ub), float(np.trace(Mv))/len(Ub)
    a=sub(lambda i,j: True); x=sub(lambda i,j: lab[i]!=lab[j])
    g=lambda t: "--" if t is None else f"d={t[0]:3d} tr/dim={t[1]:+.6f}"
    print(f"{name:14s} n={n:2d} th={th:.6f} Delta={dpos:8.4f} lam_max={lam:.6f} | allSym0 {g(a)} | ACROSS {g(x)}")

full("C5 blowup(2^5)", *C.c5_blowup(), sum([[b]*2 for b in range(5)],[]))
W,n=ck_unit(5); full("C5 unit(1^5)", W,n, list(range(5)))
W,n=ck_unit(7); full("C7 unit(1^7)", W,n, list(range(7)))
W,n=C.c5_blowup((1,1,1,1,2)); full("C5 (1,1,1,1,2)", W,n, [0,1,2,3,4,4])
W,n=C.c5_blowup((2,2,2,2,1)); full("C5 (2,2,2,2,1)", W,n, [0,0,1,1,2,2,3,3,4])
t=time.time(); C.Le_matrix(8, C.cpm(4)[0]); print(f"[timing] Le_matrix n=8: {time.time()-t:.2f}s")
