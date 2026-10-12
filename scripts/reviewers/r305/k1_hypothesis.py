"""Is 'disconnected' the right hypothesis?  CONNECTED diagonal critical points that
still carry a theta-eigenvector in W-perp."""
import numpy as np, sys, itertools
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
from blowlib import blowup
from k1defs import sphere_M, components

def full(M,label):
    n=M.shape[0]
    idx,pos,N,c,B=weyl_basis(n)
    W=diag_to_operator(M,pos); th=P(c,W)
    co=np.array([inner(b,W) for b in B]); co/=np.linalg.norm(co)
    Lm=L_operator(c,B,W)/th
    lmax,_=lam_max_perp(Lm,co)
    evs=np.sort(np.linalg.eigvalsh(0.5*(Lm+Lm.T)))
    k,_=components(M)
    Lmd,Bd=diag_L_matrix(M)
    cd=np.array([np.sum(Bd[i]*M) for i in range(len(Bd))]); cd/=np.linalg.norm(cd)
    Pd=np.eye(len(Bd))-np.outer(cd,cd)
    evd=np.linalg.eigvalsh(Pd@(0.5*(Lmd+Lmd.T))@Pd-1e6*np.outer(cd,cd))
    print(f"{label:28s} n={n:2d} comps={k} theta={th:.9f} Delta={Delta(c,W):.4f} "
          f"FULL lam_max={lmax:.9f} DIAG(M-perp) lam_max={evd[-1]/th:.9f} dim E(1)={int(np.sum(np.abs(evs-1)<1e-8))} "
          f"min|M_ij|={np.abs(M[np.triu_indices(n,1)]).min():.6f}")

full(sphere_M(2,2),"S^2xS^2 (n=4)")
full(sphere_M(3,3),"S^3xS^3 (n=6)")
K4=set(itertools.combinations(range(4),2))
M,_=blowup(K4,[2]*4); full(M,"K_4 blow-up, blocks 2 (n=8)")
K3=set(itertools.combinations(range(3),2))
M,_=blowup(K3,[2]*3); full(M,"K_3 blow-up, blocks 2 (n=6)")
M,_=blowup(K3,[3]*3); full(M,"K_3 blow-up, blocks 3 (n=9)")
C5=set([(0,1),(1,2),(2,3),(3,4),(0,4)])
M,_=blowup(C5,[2]*5); full(M,"C_5 blow-up (n=10)")
