import sys, os, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib310 as L
rng = np.random.default_rng(31000)
def proj_V(M):
    n=M.shape[0]; np.fill_diagonal(M,0.0); M=(M+M.T)/2
    r=M.sum(1); u=np.linalg.solve((n-2)*np.eye(n)+np.ones((n,n)), r)
    M=M-(u[:,None]+u[None,:]); np.fill_diagonal(M,0.0); return M
print("D2: diagonal locus invariance at NON-CRITICAL diagonal Weyl W, and H outside the locus-Weyl space")
for n in [5,6,7,8,9]:
    M=proj_V(rng.normal(size=(n,n))); W=L.W_from_M(M); W/=np.sqrt(L.ip(W,W)); M=L.M_from_W(W)
    th=L.P(W); crit=np.abs(L.Q(W)-th*W).max()
    for htag,N in [("H Weyl-diagonal",proj_V(rng.normal(size=(n,n)))),
                   ("H diagonal, row sums NONZERO",(lambda X:(np.fill_diagonal(X,0),X)[1])((rng.normal(size=(n,n))+rng.normal(size=(n,n)).T)/2))]:
        H=L.W_from_M(N); LH=L.L_W(W,H,n)
        off=np.linalg.norm(LH-np.diag(np.diag(LH)))
        rs=np.abs(L.M_from_W(LH).sum(1)).max()
        print(f"  n={n} theta={th:+.6f} crit_resid={crit:.2e} | {htag}: offdiag(L_W H)={off:.3e}  rowsum(L_W H)={rs:.2e}")
