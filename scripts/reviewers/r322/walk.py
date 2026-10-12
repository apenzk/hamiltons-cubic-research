import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core

def walk_data(n, W, tol=1e-9, vindex=0):
    """Eigenbasis walk data at the lam_min eigenvector."""
    lam, U = np.linalg.eigh(W)          # ascending
    B = core.basis(n)
    Phi = np.einsum('ak,aij->kij', U, B)   # Phi[k] = eigen-bivector k  (n x n skew)
    v = Phi[vindex]
    Cm = v @ Phi - Phi @ v                 # [v, phi_a]
    C = -0.5*np.einsum('aij,bji->ab', Cm, Phi)   # C[a,b] = <[v,phi_a],phi_b>
    return lam, Phi, C

def blocks(lam, C, tol=1e-9):
    m = lam < -tol; p = lam > tol; z = ~(m | p)
    L = np.outer(lam, lam)*C**2
    out = {}
    out['mm'] = 0.5*L[np.ix_(m,m)].sum()
    out['pp'] = 0.5*L[np.ix_(p,p)].sum()
    out['mp'] = L[np.ix_(m,p)].sum()          # both orderings
    out['total'] = 0.5*L.sum()
    out['mass'] = float((C**2).sum())
    out['dimm']=int(m.sum()); out['dimp']=int(p.sum()); out['dimz']=int(z.sum())
    return out, m, p, z

def S_tensors(n, lam, Phi, tol=1e-9):
    """S_mmm = sum_{u,v,w in m} <[u,v],w>^2 ; S_mpp = sum_{u in m, v,w in p} <[v,w],u>^2."""
    N = Phi.shape[0]
    m = lam < -tol; p = lam > tol
    # full structure constants in the eigenbasis
    Cm = np.einsum('aij,bjk->abik', Phi, Phi) - np.einsum('bij,ajk->abik', Phi, Phi)
    c = -0.5*np.einsum('abij,cji->abc', Cm, Phi)
    Smmm = float((c[np.ix_(m,m,m)]**2).sum())
    Smpp = float((c[np.ix_(p,p,m)]**2).sum())
    return Smmm, Smpp, c
