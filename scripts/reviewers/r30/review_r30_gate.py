import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r30_core import *

print("=== gatekeeper 1: dim Weyl_n ===")
for n in range(4,13):
    B = weyl_basis(n)
    print(n, B.shape[0], dim_weyl_formula(n), "OK" if B.shape[0]==dim_weyl_formula(n) else "MISMATCH")

print("=== gatekeeper 2: full symmetry of trilinear form T(X,Y,Z)=<XoY,Z> ===")
n=6; B=weyl_basis(n); rng=np.random.default_rng(0)
N=B.shape[1]
X,Y,Z = [ (lambda M: 0.5*(M+M.T))(rng.standard_normal((N,N))) for _ in range(3)]
t1=np.tensordot(circ(n,X,Y),Z); t2=np.tensordot(circ(n,Y,Z),X); t3=np.tensordot(circ(n,Z,X),Y)
print("T asym:", abs(t1-t2), abs(t2-t3))

print("=== gatekeeper 3: sphere product criticality & theta ===")
for blocks in [(3,3),(2,4),(3,5),(4,4),(3,7),(4,6),(5,5),(2,6)]:
    n=sum(blocks)
    W,_ = sphere_product_W(blocks); W=normalize(W)
    QW = Q(n,W)
    th = float(np.tensordot(W,QW))
    res = np.linalg.norm(QW-th*W)
    th0 = np.sqrt(2*(n-1)*(n-2))/n
    # Nienhaus closed form
    k,l=blocks
    thkl = np.sqrt(2)*np.sqrt((k-1)/k*(l-1)/l*(n-1)/(n-2))
    print(f"{blocks} n={n} theta={th:.12f} resid={res:.2e} theta0={th0:.12f} nienhaus={thkl:.12f}")
