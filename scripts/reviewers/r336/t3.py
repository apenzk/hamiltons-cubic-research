import sys; sys.path.insert(0,'scripts/reviewers/r336')
import numpy as np, w
np.random.seed(1336)
for n in [5,6,7,8]:
    P,idx,ns=w.weyl_basis(n); N=len(P)
    worst73=1e9; worstS=1e9; ratios=[]
    for _ in range(400):
        v=ns@np.random.randn(ns.shape[1]); M=w.coords_to_mat(v,idx,N); M=(M+M.T)/2
        M/=np.sqrt(np.sum(M*M)); lam=np.linalg.eigvalsh(M)
        lmax=lam[-1]; lmin=lam[0]
        r1=(n-2)*abs(lmin)-lmax; r2=(n-2)*lmax-abs(lmin)
        worst73=min(worst73,r1,r2)
        ratios.append(max(lmax/abs(lmin), abs(lmin)/lmax))
        # strengthened: two-largest / two-smallest averages
        s1=(lam[-1]+lam[-2])/2*(n-2)-abs(lmin)   # from row a=argmin
        s2=(abs(lam[0])+abs(lam[1]))/2*(n-2)-lmax # from row a=argmax
        worstS=min(worstS,s1,s2)
    print('n=%d  min slack Lemma73 = %.4f   min slack STRENGTHENED = %.4f   max ratio seen %.3f (bound %d)'%(n,worst73,worstS,max(ratios),n-2))
