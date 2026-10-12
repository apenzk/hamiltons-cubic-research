"""F4: the dimension screen.  (i) is dim O <= dim m + dim ker right, (ii) is the
CONTRAPOSITIVE as stated right, (iii) is the genericity consequence supported at the
exact parameters the record names (n = 12, dim m = 20)?"""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r298')
import r298_core as C

def ortho_rank(V, tol=1e-9):
    F=V.reshape(V.shape[0],-1); s=np.linalg.svd(F,compute_uv=False)
    return int((s>tol*max(1.0,s[0])).sum())

def row(n, W, lbl):
    W=W/np.linalg.norm(W)
    lam=np.linalg.eigvalsh(W)
    N=n*(n-1)//2
    dm=int((lam<-1e-9).sum()); dk=int((abs(lam)<=1e-9).sum()); dp=N-dm-dk
    D,tot,_=C.Delta(n,W)
    dimO=ortho_rank(C.orbit_tangent(n,W)); dimk=N-dimO
    th=float(np.sum(W*C.Qf(n,W)))
    res=np.linalg.norm(C.project_weyl(n,C.Qf(n,W))-th*W)
    ok1 = dp<=dimk; ok2 = dimO<=dm+dk; ok3 = dimO<=dm
    print(f"  {lbl:22s} n={n:2d} th={th:+.6f} res={res:.1e} dim p={dp:3d} m={dm:3d} ker={dk:3d} "
          f"| dim O={dimO:3d} dim k={dimk:3d} | Delta={D:8.4f} | p<=k {str(ok1):5s} "
          f"O<=m+ker {str(ok2):5s} O<=m {str(ok3):5s}")
    return dict(dp=dp,dm=dm,dk=dk,dimO=dimO,dimk=dimk,D=D)

print("=== the screen at the catalogued points ===")
for blocks in ([3,3],[3,5],[5,5],[2,4],[2,6]):
    n=sum(blocks); row(n,C.sphere_product(blocks),"S^"+"xS^".join(map(str,blocks)))
for m in (2,3,4): row(2*m,C.cpm(m),f"CP^{m}")
r=row(8,C.pad(4,8,C.cpm(2)),"CP^2 padded n=8")
print("\n  ^^ padded CP^2: dim O = %d > dim m = %d and Delta = 0."
      "  The contrapositive AS STATED -- 'orbit larger than the negative eigenspace"
      " => Delta > 0' -- is FALSE here; the kernel term is load-bearing." % (r['dimO'],r['dm']))
row(10,C.pad(6,10,C.sphere_product([3,3])),"S^3xS^3 padded n=10")

print("\n=== the exact parameters the record names: n = 12, dim m = 20 ===")
W=C.sphere_product([2,10]); r=row(12,W,"S^2 x S^10")
print(f"  S^2 x S^10 has dim m = {r['dm']} (in the band 3 <= dim m < {12*12//4}),"
      f" trivial kernel, Delta = {r['D']:.3e},")
print(f"  and its isotropy is dim k = {r['dimk']} = dim(so(10)+so(2)) = {45+1}.")
print("  So the 'severe demand' of a 46-dimensional isotropy at (n,dim m) = (12,20)")
print("  is met exactly, by a catalogued two-block sphere product.")
