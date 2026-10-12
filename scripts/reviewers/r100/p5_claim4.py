import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r100'))
from core import *

rng=np.random.default_rng(505)
print("=== CLAIM 4: rank of moment sets ===")
for n in [5,6,7,8]:
    B=weyl_basis(n); dw=B.shape[1]
    NS=max(400, 3*dw)
    rows=[]; coefs=[]; rows3=[]; rows3b=[]
    for _ in range(NS):
        M,v=random_weyl(n,B,rng); coefs.append(v)
        W=full_tensor(M,n); A=Wring(W,n); Ms=sharp(M,n)
        M2=M@M; A2=A@A
        trM4=float(np.trace(M2@M2)); trA4=float(np.trace(A2@A2))
        shsh=float(np.sum(Ms*Ms)); shM2=float(np.sum(Ms*M2))
        rows.append([trM4,trA4,1.0])
        rows3.append([trM4,trA4,shsh,shM2,1.0])
        p3m=float(np.trace(M@M2)); p3o=float(np.trace(A@A2)); shW=float(np.sum(Ms*M))
        rows3b.append([p3m,p3o,shW,1.0])
    R=np.array(rows); R5=np.array(rows3); R3=np.array(rows3b)
    samp_rank=np.linalg.matrix_rank(np.array(coefs))
    def rk(X):
        s=np.linalg.svd(X,compute_uv=False); return int((s>s[0]*1e-10).sum()), s
    r3,s3=rk(R); r5,s5=rk(R5); rc,sc=rk(R3)
    print(f"n={n}: dim W_n={dw}, sample coeff rank {samp_rank}/{dw} (spanning={samp_rank==dw}), {NS} samples")
    print(f"   rank{{trM^4, trWring^4, 1}} = {r3}/3   sv ratios {np.round(s3/s3[0],3)}")
    print(f"   rank{{trM^4, trWring^4, <W#,W#>, <W#,W^2>, 1}} = {r5}/5  sv ratios {np.round(s5/s5[0],4)}")
    print(f"   rank{{p3(mu), p3(om), <W#,W>, 1}} = {rc}/4  sv ratios {np.round(sc/sc[0],4)}   [expect 3: the theta identity is one relation]")
    if r5<5:
        U,s,Vt=np.linalg.svd(R5); print(f"   NULL VECTOR (rel coeffs) = {np.round(Vt[-1]/np.abs(Vt[-1]).max(),6)}")
    if rc<4:
        U,s,Vt=np.linalg.svd(R3); print(f"   deg-3 null vector = {np.round(Vt[-1]/np.abs(Vt[-1]).max(),6)}  [p3mu, p3om, <W#,W>, 1]")
