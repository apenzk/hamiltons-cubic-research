"""Is the padded CP^2 a genuine local max of P on S(V_(6,6)) at n=12 (and on the full sphere)?
Perturb by eps in random tangent directions and in the null directions of the second variation,
then compare P."""
import sys; sys.path.insert(0,'scripts/reviewers/r316')
import numpy as np, core
from padded_cp2 import cp2
from n3_n12 import SliceFree, shifted_power

for n,a in [(8,4),(12,6)]:
    alg=core.Alg(n); pr=core.ProjFast(alg); sg=core.grading_involution(alg,a)
    W=cp2(alg); P0=float(np.sum(W*alg.Q(W)))
    rng=np.random.default_rng(5)
    for tag, proj in (("slice", lambda M: 0.5*(pr.apply(M)+sg*pr.apply(M))), ("full", pr.apply)):
        worst=-1e9; worst_eps=None
        for eps in (1e-1,3e-2,1e-2,3e-3):
            for t in range(400):
                M=rng.normal(size=(alg.N,alg.N)); M=M+M.T
                H=proj(M); H=H-np.sum(H*W)*W
                H/=np.linalg.norm(H)
                Wn=W+eps*H; Wn/=np.linalg.norm(Wn)
                d=float(np.sum(Wn*alg.Q(Wn)))-P0
                if d>worst: worst, worst_eps = d, eps
        print(f"n={n} ({a},{n-a}) padded CP2, {tag} directions: max P increase over 1600 probes = {worst:.3e} (at eps={worst_eps})")
    # re-ascend from perturbed starts inside the slice
    sl=SliceFree(n,a)
    outs=[]
    for t in range(8):
        M=rng.normal(size=(alg.N,alg.N)); M=M+M.T
        H=0.5*(pr.apply(M)+sg*pr.apply(M)); H=H-np.sum(H*W)*W; H/=np.linalg.norm(H)
        Wn=W+0.05*H; Wn/=np.linalg.norm(Wn)
        Wf,Pf,r=shifted_power(sl,Wn)
        outs.append(round(Pf,9))
    print(f"   re-ascent from 8 perturbed starts (eps=0.05) -> theta {sorted(set(outs))}")
