import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r36_core import *

print("=== validation ===", flush=True)
for n in range(4, 10):
    t0=time.time()
    print(f"n={n}: gram(phi) err {gram_check(n):.2e}", end="", flush=True)
    A = struct(n)
    # antisymmetry of c in all indices
    asym = max(np.abs(A + A.transpose(0,2,1)).max(),
               np.abs(A + A.transpose(1,0,2)).max())
    B = weyl_basis(n)
    D = len(B)
    print(f" | c totally antisym {asym:.1e} | dim Weyl {D} vs {dim_weyl(n)}", end="", flush=True)
    N = A.shape[0]
    # orthonormality
    Bf = B.reshape(D, N*N); G = Bf@Bf.T
    print(f" | ortho {np.abs(G-np.eye(D)).max():.1e}", end="", flush=True)
    # W_pq critical
    msg=[]
    for p in range(2, n-1):
        q = n-p
        if q < 2: continue
        W = W_pq(p,q); QW = Qop(A,W)
        th = QW[0,0]/W[0,0]
        rel = np.linalg.norm(QW - th*W)/np.linalg.norm(W)
        pred = (n-1)/(p*q)
        e = W/th
        LeW = circ(A,e,W)
        msg.append(f"({p},{q}) th={th:.6f} pred={pred:.6f} rel={rel:.1e} LeW-W={np.linalg.norm(LeW-W):.1e}")
        # W in Weyl?
        cw = np.abs(Bf.T@(Bf@W.reshape(N*N)) - W.reshape(N*N)).max()
        msg[-1]+=f" W in Weyl {cw:.1e}"
    print()
    for m in msg: print("   ", m)
    # trilinear symmetry and tr(L_x)=0 on random Weyl elements
    rng = np.random.default_rng(7)
    cx, cy, cz = rng.normal(size=(3,D))
    X = np.tensordot(cx,B,axes=1); Y=np.tensordot(cy,B,axes=1); Z=np.tensordot(cz,B,axes=1)
    v1 = np.tensordot(circ(A,X,Y), Z); v2 = np.tensordot(circ(A,Y,Z), X); v3 = np.tensordot(circ(A,Z,X), Y)
    v4 = np.tensordot(circ(A,Y,X), Z)
    print(f"    trilinear <XoY,Z> {v1:.10f} {v2:.10f} {v3:.10f} {v4:.10f}  spread {max(abs(v1-v2),abs(v2-v3),abs(v1-v4)):.2e}")
    LX = L_matrix(A,B,X)
    print(f"    tr(L_X) = {np.trace(LX):.3e}  |L_X sym| {np.abs(LX-LX.T).max():.1e}  ({time.time()-t0:.1f}s)")
