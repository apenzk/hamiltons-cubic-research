"""DERIVE-j5 batch 4 screen: J_5 = <R̊|W| h,h> + 6<A,h> - theta|h|^2 - 2<Ric(W_-^2),h>, each term signed.

Checks the identity 4 Ric(C) = R̊|W|(h) + 6 A by fitting the coefficient, the four-term sum against J_5,
that the h-eigenvalues are the row sums of |W|'s sectional matrix in h's frame, and the margin of the
defect-free reduced condition. Objects come from the record's own constructors.
"""
import numpy as np, sys, glob
sys.path.insert(0,'scripts/lib')
from run_defect_penalty_test import setup as ctxsetup, qk_weyl, sphere_weyl
from run_bianchi_defect_highp_seed import build_su3_n8
from weyl_decomposition import ricci_from_mop, get_entry
from curvature_operator import Lambda2
exec(open('screen_j5.py').read().split('for (p,q) in')[0])
def sh(A,B,C): return 2*sharp2(A,B,C)
def four(M,L2):
    n=L2.n; idx=L2.idx; T=np.zeros((n,n,n,n))
    for i in range(n):
        for j in range(n):
            for k in range(n):
                for l in range(n): T[i,j,k,l]=get_entry(M,idx,i,j,k,l)
    return T
def ring(T,s):  # (R̊ s)_{ik} = sum_{jl} R_{ijkl} s_{jl}
    return np.einsum('ijkl,jl->ik',T,s)
def altT(T): return (T+np.einsum('iklj->ijkl',T)+np.einsum('iljk->ijkl',T))/3
def run(label,W,n):
    L2=Lambda2(n); pairs,idx,N,Bb,C=setup(n); I=np.eye(N); W=(W+W.T)/2; W/=np.linalg.norm(W)
    ev,U=np.linalg.eigh(W); Wp=U@np.diag(np.maximum(ev,0))@U.T; Wm=U@np.diag(np.maximum(-ev,0))@U.T; absW=Wp+Wm
    Wsh=sh(W,W,C); theta=np.sum(W*(W@W+Wsh)); X=sh(absW,absW,C)+(W-theta*I)@absW
    h=ricci_from_mop(L2,absW); RX=ricci_from_mop(L2,X); J5=np.sum(RX*h)
    Cm=sh(Wp,Wm,C); RC=ricci_from_mop(L2,Cm)
    TA=four(absW,L2); TM=four(Wm,L2); A4=altT(TM); Amat=np.einsum('iklm,jklm->ij',A4,A4)
    resid=4*RC-ring(TA,h)
    coef=np.sum(resid*Amat)/max(np.sum(Amat*Amat),1e-300)
    print(f"{label:11s} n={n}  identity 4Ric(C)=R̊|W|(h)+c*A: fitted c={coef:.4f}, residual after={np.linalg.norm(resid-coef*Amat):.1e}, ||A||={np.linalg.norm(Amat):.3f}")
    t1=np.sum(ring(TA,h)*h); t2=6*np.sum(Amat*h); t3=theta*np.sum(h*h); t4=2*np.sum(ricci_from_mop(L2,Wm@Wm)*h)
    print(f"            J5={J5:+.5f}  <R̊|W|h,h>={t1:+.5f}  6<A,h>={t2:+.5f}  -theta|h|^2={-t3:+.5f}  -2<Ric(W-^2),h>={-t4:+.5f}  sum={t1+t2-t3-t4:+.5f}")
    eta,V=np.linalg.eigh(h); lam_m=np.max(np.linalg.eigvalsh(Wm))
    # sectional matrix of |W| in h-frame
    Tf=np.einsum('ijkl,ia,jb,kc,ld->abcd',TA,V,V,V,V); w=np.einsum('abab->ab',Tf)
    rowsum=w.sum(1); quad=eta@w@eta
    print(f"            eta=h-eigs (min {eta.min():.4f} max {eta.max():.4f})  ||eta-rowsum(w)||={np.linalg.norm(eta-rowsum):.1e}  eta^T w eta={quad:.5f}  (theta+lam_max(W-))|eta|^2={(theta+lam_m)*eta@eta:.5f}  margin={quad-(theta+lam_m)*eta@eta:+.5f}")
c8=ctxsetup(8,verbose=False); c6=ctxsetup(6,verbose=False)
run("n5 crit",np.load('agent_logs/j5cross_n5_newcrit_th0.882.npy'),5)
run("S^2xS^4",sphere_weyl(c6,2),6); run("S^3xS^3",sphere_weyl(c6,3),6)
_,Wsu3=build_su3_n8(); run("SU(3)",np.asarray(Wsu3),8); run("HP^2",qk_weyl(c8,2),8)
