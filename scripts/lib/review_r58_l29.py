"""Claim 1: verify Lemma 29's proof steps and the exact value on the stratum."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r58_core import *

def weyl4_12(q,r):
    """Weyl_4 element with W^+ = diag(q+r,-q,-r) on the self-dual part."""
    n=4; P=phis(4); pr=pairs(4)
    e=lambda i,j: P[pr.index((i,j))]
    SD=[(e(0,1)+e(2,3))/np.sqrt(2),(e(0,2)-e(1,3))/np.sqrt(2),(e(0,3)+e(1,2))/np.sqrt(2)]
    V=np.array([[0.5*np.trace(s.T@P[a]) for a in range(6)] for s in SD])
    W=(q+r)*np.outer(V[0],V[0]) - q*np.outer(V[1],V[1]) - r*np.outer(V[2],V[2])
    return W/fro(W)

if __name__=='__main__':
    pass
