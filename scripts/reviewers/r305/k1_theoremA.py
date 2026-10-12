"""Is K1's consequence ATTEMPTS.md Theorem A?  Hess = 6 theta (L_e - 1/2) on the tangent
space; at H = ||W2||^2 W1 - ||W1||^2 W2 the record claims Hess = +3 theta ||H||^2 exactly."""
import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
from k1defs import sphere_M, direct_sum, components

for specs in [[(2,2),(2,2)],[(2,2),(2,3)]]:
    Ms=[];ths=[]
    for s in specs:
        Mi=sphere_M(*s); r,t=crit_res(Mi); Ms.append(Mi); ths.append(t)
    M,th=direct_sum(Ms,ths); n=M.shape[0]; k,lab=components(M)
    idx,pos,N,c,B=weyl_basis(n)
    W=diag_to_operator(M,pos); thF=P(c,W)
    parts=[]
    for cc in range(k):
        Mi=np.zeros_like(M); sel=np.where(lab==cc)[0]
        Mi[np.ix_(sel,sel)]=M[np.ix_(sel,sel)]; parts.append(diag_to_operator(Mi,pos))
    W1,W2=parts
    H=inner(W2,W2)*W1-inner(W1,W1)*W2
    LH=circ(c,W,H)
    hess=6*thF*(inner(H,LH)/thF-0.5*inner(H,H))     # 6 theta (<H,L_e H> - 1/2 |H|^2)
    print(f"{specs} n={n}: <H,W>={inner(H,W):.2e}  Hess={hess:.12f}  3 theta |H|^2={3*thF*inner(H,H):.12f} "
          f" rel.err={abs(hess-3*thF*inner(H,H))/abs(hess):.2e}")
