import sys, os, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib310 as L

def cp2(n):
    """padded self-dual Weyl operator of CP^2 inside Lambda^2(R^n), unit norm."""
    idx = L.pair_index(n); D = n*(n-1)//2
    def bv(pairs_coeffs):
        v=np.zeros(D)
        for (i,j,c) in pairs_coeffs:
            if i<j: v[idx[(i,j)]]+=c
            else:   v[idx[(j,i)]]-=c
        return v
    s=1/np.sqrt(2)
    w1=bv([(0,1,s),(2,3,s)]); w2=bv([(0,2,s),(3,1,s)]); w3=bv([(0,3,s),(1,2,s)])
    c=1/np.sqrt(6)
    return c*(2*np.outer(w1,w1)-np.outer(w2,w2)-np.outer(w3,w3))

print("=== D5: padded W_CP2, both sign branches ===")
for n in [5,6,8]:
    W=cp2(n); B=L.weyl_basis(n)
    coef=np.array([L.ip(W,Bk) for Bk in B]); dist=np.linalg.norm(W-np.tensordot(coef,B,axes=([0],[0])))
    for sgn in [+1,-1]:
        X=sgn*W; th=L.P(X)
        lam,res,ev=L.lam_max_perp(X,n,B)
        d=L.defect(X)
        print(f" n={n} sign={sgn:+d}: dist_to_Weyl={dist:.2e} ||W||^2={L.ip(X,X):.12f} theta={th:+.12f} "
              f"crit={np.abs(L.Q(X)-th*X).max():.2e} Delta={d:.9f} "
              f"lam_max(L_W|perp)={lam:+.9f} lam_max(L_e)=lam/theta={lam/th:+.9f} lam_min(L_e)={ev[0]/th:+.9f}")
        sp=np.linalg.eigvalsh(X); print(f"        spec(W) nonzero: {np.round(sp[np.abs(sp)>1e-12],9)}  (2,-1,-1)/sqrt6={np.round(np.array([2,-1,-1])/np.sqrt(6),9)}")
