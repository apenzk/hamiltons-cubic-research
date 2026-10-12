import sys, numpy as np
sys.path.insert(0,'scripts/lib'); sys.path.insert(0,'scripts/reviewers/r291')
from r291_core import *
rng=np.random.default_rng(7)
print("C1 per-pair, aligned by the eigh permutation (only for simple spectra):")
for n in (4,5,6,7):
    B=locus_basis(n)
    for t in range(2):
        M=rand_M(n,rng,B); W=M_to_W(M)
        lamp=np.array([M[i,j] for (i,j) in pairs_of(n)])
        perm=np.argsort(lamp, kind='stable')
        gaps=np.diff(np.sort(lamp))
        D,tot,S,g,lam=defect_mine(n,W/np.linalg.norm(W))
        gf=g_formula(M)/np.sum(W*W)  # g scales as 1/||W||^2 ; W already unit here
        err=np.abs(g-gf[perm]).max()
        print(f"  n={n} simple_spectrum={gaps.min()>1e-9}  max|g_eig - gC1[perm]| = {err:.2e}")
