"""Independent confirmation of N10 that never diagonalises: trace moments and
the predicted minimal polynomial."""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r33_spec import weyl_basis, L_matrix, predicted

for (p,q) in [(3,3),(3,5),(4,4),(4,6),(5,5),(2,6),(5,7),(6,6),(4,8)]:
    n=p+q
    B,_=weyl_basis(n); dim=B.shape[0]
    L=L_matrix(p,q,B); L=(L+L.T)/2
    pred,_=predicted(p,q,dim)
    vals=sorted(pred)
    # minimal polynomial residual
    M=np.eye(dim)
    for v in vals: M=M@(L-v*np.eye(dim))
    minpoly=np.max(np.abs(M))
    # trace moments
    Lk=np.eye(dim); rows=[]
    for k in range(1,8):
        Lk=Lk@L
        got=np.trace(Lk); want=sum(m*(v**k) for v,m in pred.items())
        rows.append(abs(got-want)/max(1.0,abs(want)))
    print(f"({p},{q}) n={n:2d} dim={dim:4d}  |minpoly(L)|_max={minpoly:.2e}  "
          f"max rel. trace-moment error k=1..7: {max(rows):.2e}   spectrum {[(round(v,6),m) for v,m in sorted(pred.items())]}",flush=True)
