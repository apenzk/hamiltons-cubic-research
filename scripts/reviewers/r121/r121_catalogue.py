import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, itertools
SP=_os.path.join(_ROOT, 'scripts/reviewers/r121/')
exec(open(SP+'r121_loss_identity.py').read().split('print("=== identity')[0])

def from_op(M,B,n):
    return 2*np.einsum('ab,aij,bkl->ijkl',M,B,B)

def pad(W,n):
    m=W.shape[0]; P=np.zeros((n,n,n,n)); P[:m,:m,:m,:m]=W; return P

# --- CP^2 : W_+ = diag(2,-1,-1)*c , W_- = 0 ---
def cp2():
    n=4; B=so_basis(4)
    # self-dual / anti-self-dual basis
    def bv(i,j):
        A=np.zeros((4,4)); A[i,j]=1; A[j,i]=-1; return A/np.sqrt(2)
    sd=[(bv(0,1)+bv(2,3))/np.sqrt(2),(bv(0,2)+bv(3,1))/np.sqrt(2),(bv(0,3)+bv(1,2))/np.sqrt(2)]
    asd=[(bv(0,1)-bv(2,3))/np.sqrt(2),(bv(0,2)-bv(3,1))/np.sqrt(2),(bv(0,3)-bv(1,2))/np.sqrt(2)]
    basis=np.array(sd+asd)
    d=np.array([2,-1,-1,0,0,0])/np.sqrt(6.0)
    M=np.diag(d)
    return from_op(M,basis,4)

# --- product of two round spheres, curvatures k1,k2 ---
def sphere_prod(p,q,k1,k2,n=None):
    m=p+q; n = n or m
    R=np.zeros((m,m,m,m))
    for i in range(p):
        for j in range(p):
            for k in range(p):
                for l in range(p):
                    R[i,j,k,l]+=k1*( (i==k)*(j==l)-(i==l)*(j==k) )
    for i in range(p,m):
        for j in range(p,m):
            for k in range(p,m):
                for l in range(p,m):
                    R[i,j,k,l]+=k2*( (i==k)*(j==l)-(i==l)*(j==k) )
    W=weyl_project(R)
    return pad(W,n) if n>m else W

print("=== padded CP^2 ===")
Wc=cp2()
for n in [4,5,6,7,8]:
    report(f"CP2 padded to R^{n}",pad(Wc,n))

print()
print("=== S^p x S^q  (unit curvature both factors), then padded ===")
for (p,q) in [(2,2),(2,3),(3,3),(2,4),(3,4),(4,4),(2,5),(5,2)]:
    m=p+q
    if p<2 or q<2: continue
    W=sphere_prod(p,q,1.0,1.0)
    if np.einsum('ijkl,ijkl->',W,W)<1e-18: print(f"S^{p}xS^{q}: Weyl part vanishes"); continue
    d=report(f"S^{p}xS^{q} (k=1,1)",W)

print()
print("=== S^p x S^q unbalanced curvatures, n=p+q ===")
for (p,q) in [(2,3),(3,4)]:
    for r in [0.3,1.0,2.5,7.0]:
        W=sphere_prod(p,q,1.0,r)
        report(f"S^{p}xS^{q} k2/k1={r}",W)

print()
print("=== S^p x S^q padded into higher n ===")
for (p,q,n) in [(2,2,6),(2,3,7),(3,3,8)]:
    W=sphere_prod(p,q,1.0,1.0,n=n)
    report(f"S^{p}xS^{q} padded n={n}",W)
