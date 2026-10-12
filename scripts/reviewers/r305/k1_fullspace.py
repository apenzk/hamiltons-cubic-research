"""K1's CONSEQUENCE, checked in the FULL Weyl space (not the diagonal locus)."""
import numpy as np, sys, time
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
from k1defs import sphere_M, direct_sum, components

def diag_point(specs):
    Ms=[];ths=[]
    for s in specs:
        M=sphere_M(*s); r,t=crit_res(M); Ms.append(M); ths.append(t)
    return direct_sum(Ms,ths)

for specs in [[(2,2),(2,2)], [(2,2),(2,3)]]:
    t0=time.time()
    M,th=diag_point(specs)
    n=M.shape[0]; k,lab=components(M)
    idx,pos,N,c,B=weyl_basis(n)
    W=diag_to_operator(M,pos)
    coef=np.array([inner(b,W) for b in B])
    print(f"\n### {specs} n={n} comps={k} weyl-dim={len(B)} |W|^2={inner(W,W):.12f}")
    print(f"  in Weyl space: err={np.abs(np.tensordot(coef,B,axes=(0,0))-W).max():.2e}")
    thP=P(c,W); QW=Qmap(c,W)
    print(f"  theta_full={thP:.12f} theta_diag={th:.12f}  ||Q(W)-thW||={np.abs(QW-thP*W).max():.2e}")
    Lm=L_operator(c,B,W)/thP
    lmax,ev=lam_max_perp(Lm,coef)
    evs=np.sort(np.linalg.eigvalsh(0.5*(Lm+Lm.T)))
    print(f"  FULL lambda_max(L_e|W-perp) = {lmax:.12f}   (Lemma 24 needs <= 0.5)")
    print(f"  dim E(1) of L_e = {int(np.sum(np.abs(evs-1)<1e-8))}; top 8 eigs {np.round(evs[-8:],9)}")
    print(f"  mult of 1/2 = {int(np.sum(np.abs(evs-0.5)<1e-8))}")
    print(f"  Delta(W) = {Delta(c,W):.9f}")
    # the block idempotent direction v = |e2|^2 e1 - |e1|^2 e2 lifted to the full space
    o=0; parts=[]
    for cnum in range(k):
        Mi=np.zeros_like(M); sel=np.where(lab==cnum)[0]
        Mi[np.ix_(sel,sel)]=M[np.ix_(sel,sel)]
        parts.append(diag_to_operator(Mi,pos))
    A,Bp=parts[0],parts[1]
    v=inner(Bp,Bp)*A-inner(A,A)*Bp
    vc=np.array([inner(b,v) for b in B]); vc/=np.linalg.norm(vc)
    print(f"  <v,W>={inner(v,W):.2e}  L_e v - v: {np.abs(Lm@vc-vc).max():.2e}  Rayleigh={vc@(0.5*(Lm+Lm.T))@vc:.12f}")
    print(f"  A o B (circ-orthogonality of the two blocks) = {np.abs(circ(c,A,Bp)).max():.2e}")
    print(f"  [{time.time()-t0:.1f}s]")
