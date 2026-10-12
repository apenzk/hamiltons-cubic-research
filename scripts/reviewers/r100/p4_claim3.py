import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r100'))
from core import *

def sphere_prod_weyl(m):
    n=2*m; B=weyl_basis(n)
    R=np.zeros((n,n,n,n))
    for off in (0,m):
        g=np.zeros((n,n))
        for a in range(off,off+m): g[a,a]=1.0
        R+=np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)
    MW,_=project_weyl(M_from_tensor(R,n),B,n)
    return MW/np.linalg.norm(MW), n, B

print("=== CLAIM 3: phi-diagonal of Wring vs vertex matrix K_ab = W_abab ===")
rng=np.random.default_rng(303)
for n in [5,6,7,8]:
    B=weyl_basis(n)
    M,_=random_weyl(n,B,rng); W=full_tensor(M,n); A=Wring(W,n)
    _,labels=s20_basis(n)
    err=0.0
    for t,lab in enumerate(labels):
        if lab[0]=='phi':
            i,j=lab[1],lab[2]
            err=max(err,abs(A[t,t]-W[i,j,i,j]))
    print(f"n={n}: max |Wring_diag(phi) - W_ijij| = {err:.3e}  (random Weyl tensor)")

print()
print("=== CLAIM 3 numeric: sum d^3 / p3(omega) at S^m x S^m ===")
for m in [3,4,5,6]:
    MW,n,B=sphere_prod_weyl(m)
    W=full_tensor(MW,n); A=Wring(W,n)
    _,labels=s20_basis(n)
    dall=np.diag(A)
    isphi=np.array([lab[0]=='phi' for lab in labels])
    om=np.linalg.eigvalsh(A); P3=p3(om)
    sphi=float(np.sum(dall[isphi]**3)); sall=float(np.sum(dall**3))
    print(f"m={m} n={n}: p3(omega)={P3:.6f}")
    print(f"    sum over phi-diagonal d^3 = {sphi:.6f}  ratio {sphi/P3:+.4f}")
    print(f"    sum over ALL diagonal  d^3 = {sall:.6f}  ratio {sall/P3:+.4f}")
    print(f"    psi-diagonal entries: {np.round(dall[~isphi],6)}")
    # Schur-Horn sanity: sum d = trace, sum d^2 <= sum om^2
    print(f"    sum d = {dall.sum():.2e} (trace)   sum d^2 = {np.sum(dall**2):.6f} vs sum om^2 = {np.sum(om**2):.6f}")
