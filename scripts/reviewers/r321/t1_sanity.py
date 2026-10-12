import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r321')
from core import *

for n in [5,6,7,8]:
    WB,N = weyl_basis(n)
    expect = n*(n+1)*(n+2)*(n-3)//12
    print(f"n={n} dim Weyl = {WB.shape[0]} expected {expect}")

n=6
WB,N = weyl_basis(n)
C,P = struct(n); AD = ad_mats(C)
# total antisymmetry check
print("C antisym abc<->bac:", np.abs(C+np.transpose(C,(1,0,2))).max(),
      " abc<->acb:", np.abs(C+np.transpose(C,(0,2,1))).max())
# Jacobi / ad rep check: ad([x,y]) = [ad x, ad y]
a,b=0,4
lhs = np.einsum('c,cij->ij', C[a,b,:], AD)
rhs = AD[a]@AD[b]-AD[b]@AD[a]
print("ad rep:", np.abs(lhs-rhs).max())

W = sphere_product(n,3,WB)
QW = Q(W,AD)
th = P_func(W,AD)
print("S3xS3: theta =",th, " theta0 =", np.sqrt(2*(n-1)*(n-2))/n)
print("  crit residual ||Q-theta W|| =", np.linalg.norm(QW-th*W))
print("  eigs:", np.round(np.linalg.eigvalsh(W),6))
print("  tr W =", np.trace(W), " tr(W#) =", np.trace(sharp(W,AD)))
