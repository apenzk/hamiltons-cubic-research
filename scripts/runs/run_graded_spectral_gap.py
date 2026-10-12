"""Does the graded critical set admit a uniform gap min|lambda| >= c > 0?

Trivial obstruction to check first: padding a critical point into a larger R^n adds
zero eigenvalues on Lambda^2, so min|lambda| = 0 at every padded point. If padded
graded points are in the set, the uniform bound is false for a reason that has nothing
to do with the separation question.
"""
import numpy as np, itertools
def pairs(n): return list(itertools.combinations(range(n),2))
def toM(W,n):
    pr=pairs(n); return np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr])
def diag_weyl(Lam):
    n=Lam.shape[0]; I=np.eye(n)
    return np.einsum('ij,ik,jl->ijkl',Lam,I,I)-np.einsum('ij,il,jk->ijkl',Lam,I,I)
def sphere_product(p,q,n):
    Lam=np.zeros((n,n)); b=1.0; a1=-q*b/(p-1); a2=-p*b/(q-1)
    for i in range(n):
        for j in range(n):
            if i!=j: Lam[i,j]=a1 if (i<p and j<p) else a2 if (i>=p and j>=p) else b
    return -diag_weyl(Lam)
def pad(W,n):
    d=W.shape[0]; Wp=np.zeros((n,n,n,n)); Wp[:d,:d,:d,:d]=W; return Wp
print(f"{'point':30s} {'dim ker':>8} {'min|lam|':>10} {'2nd smallest |lam|':>19}")
for (m,n) in [(3,6),(4,8),(5,10),(6,12)]:
    W=sphere_product(m,m,2*m); M=toM(W,2*m); M/=np.linalg.norm(M)
    lam=np.linalg.eigvalsh(M); a=np.sort(np.abs(lam))
    print(f"{'S^%d x S^%d (unpadded)'%(m,m):30s} {int((a<1e-10).sum()):8d} {a[0]:10.6f} {a[a>1e-10][0]:19.6f}")
for (m,N) in [(3,8),(3,12),(4,12)]:
    W=pad(sphere_product(m,m,2*m),N); M=toM(W,N); M/=np.linalg.norm(M)
    lam=np.linalg.eigvalsh(M); a=np.sort(np.abs(lam))
    print(f"{'S^%d x S^%d padded to n=%d'%(m,m,N):30s} {int((a<1e-10).sum()):8d} {a[0]:10.6f} {a[a>1e-10][0]:19.6f}")
print()
print("A padded graded critical point has min|lambda| = 0 exactly.")
print("So a uniform bound over ALL graded critical points is false trivially --")
print("the meaningful statement must be about a LIMIT of graded points, not the set.")
