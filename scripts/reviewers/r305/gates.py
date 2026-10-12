import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r305')
from lib305 import *
for n in range(4,11):
    idx,pos,N,c,B=weyl_basis(n)
    print(f"n={n:2d} dim Weyl = {len(B):5d}  formula n(n+1)(n+2)(n-3)/12 = {n*(n+1)*(n+2)*(n-3)//12}")
# Jaeger diagonal formula check
n=6; idx,pos,N,c=struct(n)
rng=np.random.default_rng(1)
M=rng.normal(size=(n,n)); M=M+M.T; np.fill_diagonal(M,0)
M2=rng.normal(size=(n,n)); M2=M2+M2.T; np.fill_diagonal(M2,0)
R=diag_to_operator(M,pos); S=diag_to_operator(M2,pos)
T=0.5*(sharp_bilin(c,R,S)+sharp_bilin(c,S,R))
pred=np.zeros((N,N))
for (i,j),k in pos.items(): pred[k,k]=0.5*sum(M[i,t]*M2[j,t]+M[j,t]*M2[i,t] for t in range(n))
print("Jaeger (R#S)_ij = 1/2 sum_k (r_ik s_jk + r_jk s_ik):",np.abs(T-pred).max())
