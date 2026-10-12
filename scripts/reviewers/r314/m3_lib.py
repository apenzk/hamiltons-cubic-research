import sys,os; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L
from m1_gradings import ad_on_lambda2

def coord_to_so(n,c):
    A=L.so_mats(n); return np.einsum('a,aij->ij',c,A)

def g_density(n,W):
    """g_gamma = ||[ad(v_gamma), W]||_F^2 over the eigenbasis of W."""
    lam,V=np.linalg.eigh(W)
    g=np.zeros(len(lam))
    for k in range(len(lam)):
        X=coord_to_so(n,V[:,k]); K=ad_on_lambda2(n,X)
        C=K@W-W@K
        g[k]=float(np.sum(C*C))
    return lam,V,g

def Delta(n,W,tol=1e-9):
    lam,V,g=g_density(n,W)
    return float(g[lam>tol].sum()), lam, g

def ric_of_op(n,X):
    """Ric(X)_{ik} = sum_j <X (e_i^e_j), e_k^e_j>  (X any operator on Lambda^2)"""
    P=L.pairs(n); idx={p:a for a,p in enumerate(P)}
    def ent(i,j,k,l):
        s=1.0
        if i>j: i,j=j,i; s=-s
        if k>l: k,l=l,k; s=-s
        return s*X[idx[(i,j)],idx[(k,l)]]
    G=np.zeros((n,n))
    for i in range(n):
        for k in range(n):
            G[i,k]=sum(ent(i,j,k,j) for j in range(n) if j!=i and j!=k)
    return 0.5*(G+G.T)

def polish(n,W,Lmatfun=None,iters=12):
    proj,coords,fromc,B=L.weyl_proj_factory(n); dim=B.shape[0]; Bf=B.reshape(dim,-1)
    x=coords(W); x/=np.linalg.norm(x)
    for it in range(iters):
        Wc=fromc(x); Qm=L.Q(n,Wc); q=coords(Qm); th=float(x@q)
        F=q-th*x
        if np.linalg.norm(F)<1e-15: break
        M=L.LW_matrix_on_weyl(n,Wc,B)
        J=2*M-th*np.eye(dim)-3*np.outer(x,q)
        # solve on the tangent: append the normalisation row
        Jx=np.vstack([J,x[None,:]])
        Fx=np.concatenate([F,[0.0]])
        h,*_=np.linalg.lstsq(Jx,-Fx,rcond=None)
        x=x+h; x/=np.linalg.norm(x)
    Wc=fromc(x); Qm=L.Q(n,Wc); th=float(np.sum(Wc*Qm))
    return Wc,th,float(np.abs(Qm-th*Wc).max())

def lam_max(n,W,th=None,B=None):
    if B is None: B=L.weyl_basis(n)
    dim=B.shape[0]; Bf=B.reshape(dim,-1)
    if th is None: th=float(np.sum(W*L.Q(n,W)))
    M=L.LW_matrix_on_weyl(n,W,B)/th
    w=Bf@W.reshape(-1); w/=np.linalg.norm(w)
    Pp=np.eye(dim)-np.outer(w,w)
    ev=np.linalg.eigvalsh(Pp@M@Pp)
    return ev, M
