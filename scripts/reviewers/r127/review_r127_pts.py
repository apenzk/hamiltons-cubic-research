import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys, itertools
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import numpy as np
import review_r127_lib as L

def sphere_pair(p, q):
    n = p+q
    c = np.sqrt(2*(p-1)*(q-1)/(p*q*(n-1)*(n-2)))
    K = np.zeros((n,n))
    a = q*c/(p-1); b = p*c/(q-1)
    K[:p,:p] = a; K[p:,p:] = b; K[:p,p:] = -c; K[p:,:p] = -c
    np.fill_diagonal(K, 0.0)
    return K

def mop_from_vertex(K):
    n = K.shape[0]; prs = L.pairs_of(n)
    return np.diag([K[i,j] for (i,j) in prs])

def cpm_tensor(m, n=None):
    d = 2*m
    if n is None: n = d
    J = np.zeros((n,n))
    for k in range(m):
        J[2*k+1, 2*k] = 1.0; J[2*k, 2*k+1] = -1.0
    Jm = J.T.copy()           # Jm[i,k] = <J e_i, e_k>
    g = np.eye(n); g[d:,d:] = 0.0   # metric restricted to the block for the tensor formula
    R = (np.einsum('ac,bd->abcd', g, g) - np.einsum('ad,bc->abcd', g, g)
         + np.einsum('ac,bd->abcd', Jm, Jm) - np.einsum('ad,bc->abcd', Jm, Jm)
         + 2*np.einsum('ab,cd->abcd', Jm, Jm))
    return R

def analyse(M, n, tag, verbose=True):
    M = M/np.linalg.norm(M)
    Qm = L.Q(M, n)
    lam = float((Qm*M).sum())
    res = np.abs(Qm - lam*M).max()
    K = L.vertex(M, n)
    ev = np.sort(np.linalg.eigvalsh(K))[::-1]
    pos = ev[ev > 1e-9]
    inside = pos[pos < lam - 1e-9]
    psd = float(np.linalg.eigvalsh(K@K - lam*K).min())
    t = float((K*K).sum())
    offdiagK = np.abs(M - np.diag(np.diag(M))).max()
    if verbose:
        print(f"{tag:28s} n={n:2d} lam={lam:.6f} crit-res={res:.1e} t={t:.6f} "
              f"offdiagM={offdiagK:.2e} r={len(pos)} inside={len(inside)} "
              f"minEig(K2-lamK)={psd:+.4f}  pos={np.round(pos,5)}")
    return dict(lam=lam, res=res, K=K, ev=ev, psd=psd, t=t, r=len(pos), inside=len(inside))

if __name__ == "__main__":
    print("=== sphere products (diagonal) ===")
    for (p,q) in [(2,4),(3,3),(2,5),(3,4),(3,5),(4,4),(2,8),(4,6),(5,5),(5,6),(6,6)]:
        n=p+q
        if n>12: continue
        K = sphere_pair(p,q)
        M = mop_from_vertex(K)
        r = analyse(M, n, f"S^{p}xS^{q}")
        pred = np.sqrt(2*(n-1)*(p-1)*(q-1)/(p*q*(n-2)))
        print(f"    closed-form lam={pred:.6f}   top-eig pred={n*pred/(n-1):.6f} got={r['ev'][0]:.6f}")
    print()
    print("=== CP^m (Weyl-projected in its own dimension) ===")
    for m in [2,3,4,5,6]:
        n = 2*m
        R = cpm_tensor(m, n)
        Wt = L.weyl_part(R, n)
        print(f"  CP^{m}: max|Ric(W)| = {L.traces(Wt,n):.2e}")
        M = L.mop_from_tensor(Wt, n)
        analyse(M, n, f"CP^{m}")
