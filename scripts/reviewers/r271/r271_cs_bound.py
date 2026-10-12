"""r271: (1) is b(X#)=-b(X^2) only on ker b or everywhere?  (2) the file's Cauchy-Schwarz bound
evaluated at n=12 and at the conjectured maximiser S^6xS^6."""
import numpy as np, sys
from itertools import combinations
sys.path.insert(0, "scripts/lib")
from weyl import build_structure_constants, R_val
from rsharp_basis_free import Rsharp_full

def bmap(M,pos,n):
    return np.array([R_val(M,pos,n,i,j,k,l)+R_val(M,pos,n,i,k,l,j)+R_val(M,pos,n,i,l,j,k)
                     for (i,j,k,l) in combinations(range(n),4)])

print("== is b(X^2)+b(X#)=0 for GENERAL symmetric X, or only for Bianchi X? ==")
for n in (5,6):
    idx,pos,N,c = build_structure_constants(n)
    rng=np.random.default_rng(5)
    X=rng.standard_normal((N,N)); X=(X+X.T)/2; X/=np.linalg.norm(X)
    b2=bmap(X@X,pos,n); bs=bmap(Rsharp_full(X,c),pos,n)
    print(f"  n={n} general X: ||b(X^2)||={np.linalg.norm(b2):.4f} ||b(X#)||={np.linalg.norm(bs):.4f} "
          f"||b(X^2)+b(X#)||={np.linalg.norm(b2+bs):.4f}")

print("\n== S^6 x S^6 maximiser at n=12: what the file's Cauchy-Schwarz bound gives ==")
n=12; p=q=6
idx,pos,N,c = build_structure_constants(n)
x=1.0/(p*(p-1)); y=1.0/(q*(q-1)); z=-1.0/(p*q)
lam=np.zeros(N)
for a,(i,j) in enumerate(idx):
    lam[a]= x if (i<p and j<p) else (y if (i>=p and j>=p) else z)
M=np.diag(lam); M/=np.linalg.norm(M)
Sh=Rsharp_full(M,c); theta=float(np.tensordot(M,M@M+Sh))
ad=np.transpose(c,(0,2,1))
opn=np.array([np.linalg.norm(ad[a],2) for a in range(N)])
maxab=np.abs(M).max(); rho=np.abs(np.linalg.eigvalsh(M)).max()
th0=np.sqrt(2*(n-1)*(n-2))/n
print(f"  theta(S6xS6)={theta:.6f}  theta_0(12)={th0:.6f}  <M#,M>={np.tensordot(Sh,M):+.6f}  tr(M^3)={np.trace(M@M@M):+.6f}")
print(f"  max|M_ab| (eigenbasis = coord basis here) = {maxab:.6f}   spectral radius = {rho:.6f}")
print(f"  sum||ad||_op = {opn.sum():.1f}")
print(f"  file bound  1/2 (sum||ad||)^2 ||M||_F^2 max|M_ab| = {0.5*opn.sum()**2*maxab:.3f}")
print(f"     ratio to theta_0(12) = {0.5*opn.sum()**2*maxab/th0:.1f}x        (Okumura separate caps: 4.0129 -> 3.25x)")
print(f"  best-case over unit M (max|M_ab|>=1/sqrt(N)) : {0.5*opn.sum()**2/np.sqrt(N):.1f}  ratio {0.5*opn.sum()**2/np.sqrt(N)/th0:.1f}x")
print(f"  sharper CS variant 1/2*sum||ad||_op^2*||M||_F^3 = {0.5*(opn**2).sum():.2f}  ratio {0.5*(opn**2).sum()/th0:.1f}x")
