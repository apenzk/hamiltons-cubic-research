"""Reviewer 37 gate checks: trilinear symmetry, L_e W = W, tr(L_x)=0, Q(W)=theta W."""
import sys; sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r37_core import *

rng = np.random.default_rng(37)
print("gate: trilinear <X o Y, Z> fully symmetric (random symmetric X,Y,Z on Lambda^2)")
for n in (5,6,7,8):
    A = struct_A(n); N = A.shape[0]
    X,Y,Z = [ (lambda M: M+M.T)(rng.normal(size=(N,N))) for _ in range(3)]
    vals = {}
    import itertools
    for perm in itertools.permutations((X,Y,Z)):
        vals[tuple(id(t) for t in perm)] = ip(circ(perm[0],perm[1],A), perm[2])
    v = np.array(list(vals.values()))
    print(f"   n={n}: spread {v.max()-v.min():.2e}  scale {np.abs(v).max():.2e}  rel {(v.max()-v.min())/np.abs(v).max():.2e}")

print()
print("gate: Q(W_pq) = theta W_pq, L_e W = W, tr(L_x) = 0 for x in Weyl_n")
for (p,q) in [(3,3),(3,4),(4,4),(3,5),(4,5),(5,5),(3,6),(4,6)]:
    n=p+q
    if n>10: continue
    A = struct_A(n); B = weyl_basis(n); N=A.shape[0]
    W = W_pq(p,q)
    # W in Weyl_n?
    inW = np.linalg.norm(W - expand(B, coords(B,W)))/np.linalg.norm(W)
    QW = Qop(W,A)
    theta = ip(QW,W)/ip(W,W)
    prop = np.linalg.norm(QW - theta*W)/np.linalg.norm(QW)
    e = W/theta
    LeW = circ(e,W,A)
    r1 = np.linalg.norm(LeW - W)/np.linalg.norm(W)
    # tr(L_x) on Weyl_n for random x in Weyl_n
    x = expand(B, rng.normal(size=B.shape[0]))
    Mx = operator_matrix(B, lambda V: circ(x,V,A))
    tr = np.trace(Mx)
    # also check L_x maps Weyl -> Weyl
    resid = max(np.linalg.norm(circ(x,B[j],A) - expand(B,coords(B,circ(x,B[j],A)))) for j in range(0,B.shape[0],max(1,B.shape[0]//20)))
    print(f"   (p,q)=({p},{q}) n={n}: W in Weyl {inW:.1e}  theta={theta:.6f}  Q prop {prop:.1e}  |L_eW-W|/|W| {r1:.1e}  tr(L_x)={tr:+.3e} (|x|={np.linalg.norm(x):.2f})  L_x leaves Weyl by {resid:.1e}", flush=True)
