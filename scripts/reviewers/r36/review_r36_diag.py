import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r36_core import *
from review_r36_summands import summands, casimir_block

p,q=3,4; n=7
B,ops,groups,D=summands(p,q)
N=B.shape[1]; A=struct(n); Bf=B.reshape(D,N*N)
Ip=I_block(n,0,p)
Phi=op_matrix(A,B,Ip)      # D x D matrix of P_Weyl o sharp_bilin(I_p,.)
print("Phi symmetric:",np.abs(Phi-Phi.T).max())
for nm,O in ops:
    print(f"  ||[Phi,{nm}]|| = {np.abs(Phi@O-O@Phi).max():.2e}")
groups=sorted(groups,key=lambda g:-g[1].shape[1])
lab=[f"d{g[1].shape[1]}" for g in groups]
print("\nblock matrix ||P_i Phi P_j||:")
print("        "+" ".join(f"{l:>9}" for l in lab))
for i,(vi,Ui) in enumerate(groups):
    row=[]
    for j,(vj,Uj) in enumerate(groups):
        row.append(np.linalg.norm(Ui.T@Phi@Uj))
    print(f"{lab[i]:>7} "+" ".join(f"{x:9.4f}" for x in row))
print("\neigenvalues of Phi (rounded), with multiplicity:")
w=np.linalg.eigvalsh(Phi)
import collections
print(collections.Counter(np.round(w,6)))
