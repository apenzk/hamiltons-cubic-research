"""At FIXED n, what is the nonzero spectral gap across the known graded critical points?
A family approaching zero would be the falsifier; a floor bounded away is evidence for
the per-n bound.  Checking, not establishing."""
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
def multi_block(parts,n):
    Lam=np.zeros((n,n)); idx=[]; o=0
    for p in parts: idx.append(list(range(o,o+p))); o+=p
    blk=np.zeros(n,dtype=int)
    for k,I in enumerate(idx):
        for i in I: blk[i]=k
    for i in range(n):
        for j in range(n):
            if i==j: continue
            Lam[i,j]= 1.0 if blk[i]!=blk[j] else 0.0
    for _ in range(500):
        r=Lam.sum(1)/(n-2); Lam=Lam-np.add.outer(r,r)+(Lam.sum()/((n-1)*(n-2)))
        np.fill_diagonal(Lam,0); Lam=(Lam+Lam.T)/2
    return diag_weyl(Lam)
def gap(W,n):
    M=toM(W,n); nm=np.linalg.norm(M)
    if nm<1e-12: return None
    M/=nm; a=np.sort(np.abs(np.linalg.eigvalsh(M))); nz=a[a>1e-9]
    return nz[0] if len(nz) else None
for n in [10,12]:
    print(f"\n=== n={n} ===")
    rows=[]
    for p in range(3,n//2+1):
        q=n-p
        if q<3: continue
        g=gap(sphere_product(p,q,n),n)
        if g: rows.append((f"S^{p} x S^{q}",g))
    for parts in ([4,3,3],[4,4,4],[3,3,3,3],[5,5],[3,3,4]):
        if sum(parts)!=n: continue
        g=gap(multi_block(parts,n),n)
        if g: rows.append(("x".join(f"S^{p}" for p in parts),g))
    for lbl,g in sorted(rows,key=lambda r:r[1]):
        print(f"   {lbl:22s} nonzero gap {g:.6f}")
    if rows: print(f"   -> smallest gap at n={n}: {min(r[1] for r in rows):.6f}")
