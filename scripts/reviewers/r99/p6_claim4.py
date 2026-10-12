import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r99'))
from wlib import *
rng=np.random.default_rng(6404)
J=tensor_of_M
def iota_star(X,n):
    B=s20_basis(n); Y=np.einsum('cb,cij,bkl->ijkl',X,B,B,optimize=True); return Y.transpose(0,2,3,1)

def feats(W,n):
    M=M_of(W); rw=ringW(W); Ms=sharp(M,n); M2=M@M
    return np.array([np.trace(M2@M2), np.trace(rw@rw@rw@rw), 1.0,
                     np.sum(Ms*Ms), np.sum(Ms*M2)])

print("rank of moment feature matrices  [trM^4, tr rW^4, 1 | <W#,W#>, <W#,W^2>]")
for n in [5,6,7,8]:
    rows=[]
    for t in range(60):
        W=rand_weyl(n,rng); W/=np.linalg.norm(M_of(W))
        rows.append(feats(W,n))
    Fm=np.array(rows)
    r3=np.linalg.matrix_rank(Fm[:,:3],tol=1e-9)
    s3=np.linalg.svd(Fm[:,:3],compute_uv=False)
    r5=np.linalg.matrix_rank(Fm,tol=1e-9)
    s5=np.linalg.svd(Fm,compute_uv=False)
    print(f"  n={n}: rank3={r3} sv={np.array2string(s3,precision=3)}   rank5={r5} sv={np.array2string(s5,precision=3)}")
    if r5<5:
        U,s,Vt=np.linalg.svd(Fm,full_matrices=True)
        v=Vt[-1]
        print(f"      null vector (normalised, largest comp = 1): {np.array2string(v/np.abs(v).max(),precision=6)}")
        print(f"      residual ||F v|| = {np.linalg.norm(Fm@v):.2e}, ||F||={np.linalg.norm(Fm):.2e}")

print("\ntrace conditions and second moments")
for n in [6,8,12]:
    W=rand_weyl(n,rng); W/=np.linalg.norm(M_of(W)); M=M_of(W); rw=ringW(W)
    print(f"  n={n}: tr M={np.trace(M):.2e}  tr ringW={np.trace(rw):.2e}  sum mu^2={np.sum(M*M):.6f} sum om^2={np.trace(rw@rw):.6f}")

print("\nmoments-only relaxation = sum of the two separate Okumura caps")
def ok(N):  # max sum x^3 with sum x = 0, sum x^2 = 1
    return (N-2)/np.sqrt(N*(N-1))
for n in [6,8,10,12]:
    N=n*(n-1)//2; D=(n-1)*(n+2)//2
    cap_mu=ok(N); cap_om=-(3**1.5)*ok(D)
    val=1.5*cap_mu-0.5*cap_om
    print(f"  n={n}: N={N} D={D}  max p3(mu)={cap_mu:.6f}  min p3(om)={cap_om:.6f}  "
          f"relaxation={val:.6f}  theta0={theta0(n):.6f}  CP2={np.sqrt(1.5):.4f}")

print("\nis the box attained? (are the two extremes simultaneously realisable?)")
for n in [6,8]:
    N=n*(n-1)//2; D=(n-1)*(n+2)//2
    best=None
    for t in range(400):
        W=rand_weyl(n,rng); W/=np.linalg.norm(M_of(W))
        M=M_of(W); rw=ringW(W)
        a,b=p3(M),p3(rw)
        if best is None or a>best[0]: best=(a,b)
    print(f"  n={n}: random-sample max p3(mu)={best[0]:.4f} (cap {ok(N):.4f}) with p3(om)={best[1]:.4f} (floor {-(3**1.5)*ok(D):.4f})")
