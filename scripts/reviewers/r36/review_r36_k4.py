"""K4: is V -> sharp_bilin(I_p,V) an equivariant endomorphism OF Weyl_n?"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r36_core import *
from scipy.stats import ortho_group

rng = np.random.default_rng(11)

def proj_weyl(B, M):
    D=B.shape[0]; N=M.shape[0]
    Bf=B.reshape(D,N*N)
    return (Bf.T@(Bf@M.reshape(N*N))).reshape(N,N)

def run(p,q):
    n=p+q; A=struct(n); B=weyl_basis(n); D=len(B); N=A.shape[0]
    Ip=I_block(n,0,p); Iq=I_block(n,p,n); In=np.eye(N)
    print(f"\n--- (p,q)=({p},{q})  n={n}  N={N}  dim Weyl={D} ---",flush=True)
    # 1. does sharp_bilin(I_p, .) preserve Weyl_n?
    worst_out=0.0; worst_bianchi=0.0; worst_ric=0.0
    Bfull = weyl_basis(n, ric_free=False)   # Bianchi-only (algebraic curvature ops)
    Df=len(Bfull); Bff=Bfull.reshape(Df,N*N)
    for t in range(6):
        c=rng.normal(size=D); V=np.tensordot(c,B,axes=1); V/=np.linalg.norm(V)
        Y=sharp_bilin(A,Ip,V)
        res=np.linalg.norm(Y-proj_weyl(B,Y))/max(np.linalg.norm(Y),1e-30)
        worst_out=max(worst_out,res)
        # split: Bianchi failure vs Ricci failure
        Yb = (Bff.T@(Bff@Y.reshape(N*N))).reshape(N,N)
        worst_bianchi=max(worst_bianchi, np.linalg.norm(Y-Yb)/max(np.linalg.norm(Y),1e-30))
        worst_ric=max(worst_ric, np.linalg.norm(Yb-proj_weyl(B,Y))/max(np.linalg.norm(Y),1e-30))
    print(f"  sharp_bilin(I_p,V) leaves Weyl_n: rel component outside = {worst_out:.3e}"
          f"   (outside Bianchi {worst_bianchi:.2e}, Bianchi-but-not-Ricci-flat {worst_ric:.2e})")
    for nm,X0 in [("I_p",Ip),("I_q",Iq),("I_n",In)]:
        w=0.0
        for t in range(4):
            c=rng.normal(size=D); V=np.tensordot(c,B,axes=1); V/=np.linalg.norm(V)
            Y=sharp_bilin(A,X0,V); w=max(w,np.linalg.norm(Y-proj_weyl(B,Y))/max(np.linalg.norm(Y),1e-30))
        print(f"    with X0={nm}: outside-Weyl rel = {w:.3e}")
    # I_n identity: sharp_bilin(I_n,V) = -V ?
    c=rng.normal(size=D); V=np.tensordot(c,B,axes=1); V/=np.linalg.norm(V)
    print(f"    check sharp_bilin(I_n,V)+V  -> {np.linalg.norm(sharp_bilin(A,In,V)+V):.2e}  (L_In=0 on Weyl_n)")
    print(f"    check sharp_bilin(I_p,V)+sharp_bilin(I_q,V)+sharp_bilin(I_mix,V) - sharp_bilin(I_n,V)"
          f" -> bilinearity {np.linalg.norm(sharp_bilin(A,Ip+Iq+(In-Ip-Iq),V)-sharp_bilin(A,In,V)):.1e}")

    # 2. equivariance under O(p)xO(q), including reflections
    Phi = op_matrix(A,B,Ip)          # projected-to-Weyl operator matrix
    print(f"    Phi_p symmetric?  |Phi-Phi^T| = {np.abs(Phi-Phi.T).max():.2e}")
    worst_eq=0.0; worst_eqW=0.0
    for t in range(6):
        gp = ortho_group.rvs(p, random_state=int(rng.integers(1e9)))
        gq = ortho_group.rvs(q, random_state=int(rng.integers(1e9)))
        if t%2: gp = gp@np.diag([-1.0]+[1.0]*(p-1))   # force det -1 sometimes
        g = np.block([[gp,np.zeros((p,q))],[np.zeros((q,p)),gq]])
        R = rho2(n,g)
        assert np.abs(R@Ip@R.T-Ip).max()<1e-10, "I_p not invariant!"
        c=rng.normal(size=D); V=np.tensordot(c,B,axes=1); V/=np.linalg.norm(V)
        gV = R@V@R.T
        lhs = sharp_bilin(A,Ip,gV); rhs = R@sharp_bilin(A,Ip,V)@R.T
        worst_eq=max(worst_eq,np.linalg.norm(lhs-rhs))
        # and does the Weyl-projected version commute too
        lhs2 = proj_weyl(B,lhs); rhs2 = R@proj_weyl(B,sharp_bilin(A,Ip,V))@R.T
        worst_eqW=max(worst_eqW,np.linalg.norm(lhs2-rhs2))
        # also gV stays in Weyl
        assert np.linalg.norm(gV-proj_weyl(B,gV))<1e-9
    print(f"    equivariance under O(p)xO(q) (det=-1 included): raw {worst_eq:.2e}, Weyl-projected {worst_eqW:.2e}")

    # 3. full O(n) equivariance of sharp_bilin as a bilinear map
    w=0.0
    for t in range(4):
        g=ortho_group.rvs(n,random_state=int(rng.integers(1e9)))
        if t%2: g=g@np.diag([-1.0]+[1.0]*(n-1))
        R=rho2(n,g)
        X=np.tensordot(rng.normal(size=D),B,axes=1); Y=np.tensordot(rng.normal(size=D),B,axes=1)
        X/=np.linalg.norm(X); Y/=np.linalg.norm(Y)
        w=max(w,np.linalg.norm(sharp_bilin(A,R@X@R.T,R@Y@R.T)-R@sharp_bilin(A,X,Y)@R.T))
    print(f"    sharp_bilin is O(n)-equivariant as a bilinear map: {w:.2e}")
    return Phi,B,A,n,p,q

if __name__=="__main__":
    for pq in [(3,3),(3,4),(4,4),(3,5),(4,5),(5,5)]:
        run(*pq)
