import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
n=5
idx,pos,N,c = struct(n)
rng=np.random.default_rng(0)
M=rng.normal(size=(n,n)); M=M+M.T; np.fill_diagonal(M,0)
W=diag_to_operator(M,pos)
S=sharp_bilin(c,W,W)
pred=np.zeros((N,N))
for (i,j),k in pos.items():
    pred[k,k]=sum(M[i,t]*M[j,t] for t in range(n))
print("offdiag mass of sharp", np.abs(S-np.diag(np.diag(S))).max())
print("diag ratio", (np.diag(S)/np.diag(pred))[:8])
