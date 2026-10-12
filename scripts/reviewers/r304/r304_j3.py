"""J2 + J3: Rayleigh form, dimension count, and the diagonal block against the full operator."""
import sys; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C
from r304_weyl import weyl_basis
rng=np.random.default_rng(3040)

def diag_weyl_in_weyl(n, WB):
    """check every diagonal hollow zero-row-sum operator lies in Weyl_n; return dims."""
    Bs=C.basis_hollow_zero_rowsum(n)
    G=np.array([X.ravel() for X in WB])          # rows: onb of Weyl
    worst=0.0
    for N in Bs:
        v=C.diag_op(N).ravel()
        proj=G.T@(G@v)
        worst=max(worst, np.linalg.norm(v-proj)/np.linalg.norm(v))
    return len(Bs), n*(n-3)//2, worst

def full_L_matrix(n, c, W, WB):
    k=len(WB); A=np.zeros((k,k)); leak=0.0
    G=np.array([X.ravel() for X in WB])
    for b in range(k):
        img=C.L_W(c,W,WB[b]).ravel()
        proj=G@img
        leak=max(leak, np.linalg.norm(img-G.T@proj)/max(np.linalg.norm(img),1e-30))
        A[:,b]=proj
    return (A+A.T)/2, leak

def analyse(tag, M, n, c=None, WB=None, verbose=True):
    if c is None: c=C.struct_consts(n)
    if WB is None: WB=weyl_basis(n)
    W=C.diag_op(M); th=C.theta_of(M)
    res=np.abs(C.crit_residual(M)).max()
    d,_=C.defect_delta(M)
    Bs=C.basis_hollow_zero_rowsum(n)
    Vperp=C.orth_complement_of(Bs,M)                      # diagonal block, e-perp
    Ldiag=C.op_matrix(Vperp, lambda N: C.calL(M,N))
    lam_diag=np.linalg.eigvalsh(Ldiag).max()
    A,leak=full_L_matrix(n,c,W,WB)
    # restrict to W-perp inside Weyl_n
    G=np.array([X.ravel() for X in WB]); wv=W.ravel()/np.linalg.norm(W)
    coord=G@wv; coord/=np.linalg.norm(coord)
    Pm=np.eye(len(WB))-np.outer(coord,coord)
    Ar=Pm@A@Pm
    ev=np.linalg.eigvalsh(Ar)
    lam_full=ev.max()
    # J2 Rayleigh check on random admissible N
    err=0.0
    for _ in range(5):
        v=rng.normal(size=len(Vperp)); N=sum(vi*Bi for vi,Bi in zip(v,Vperp)); N/=np.linalg.norm(N)
        lhs=float(np.sum(N*C.calL(M,N)))
        rhs=float(np.sum(M*(N*N))+np.trace(M@N@N))
        err=max(err,abs(lhs-rhs))
    if verbose:
        print(f"{tag}: n={n} theta={th:+.6f} Delta={d:.4f} res={res:.1e} | lam_diag={lam_diag:+.6f} "
              f"theta/2={th/2:+.6f} diagOK={lam_diag<=th/2+1e-9} | lam_full={lam_full:+.6f} "
              f"fullOK={lam_full<=th/2+1e-9} | leak={leak:.1e} J2err={err:.2e}")
    return dict(theta=th,delta=d,lam_diag=lam_diag,lam_full=lam_full,res=res,leak=leak,j2=err)

if __name__=='__main__':
    from r304_selfcheck import sphere_product
    for n in [6,7,8]:
        WB=weyl_basis(n); print("dims", diag_weyl_in_weyl(n,WB))
    for (p,q) in [(3,3),(3,5),(3,4)]:
        n=p+q; analyse(f"S{p}xS{q}", sphere_product(p,q), n)
