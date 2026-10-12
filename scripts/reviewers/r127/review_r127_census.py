import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import numpy as np, itertools
from scipy.optimize import least_squares
import review_r127_lib as L

def weyl_basis(n):
    N = len(L.pairs_of(n))
    cols = []
    for i in range(N):
        for j in range(i, N):
            M = np.zeros((N,N)); M[i,j]=1.0; M[j,i]=1.0
            R = L.tensor_from_mop(M, n)
            R = R - (R + np.einsum('acdb->abcd',R) + np.einsum('adbc->abcd',R))/3.0
            W = L.weyl_part(R, n)
            cols.append(L.mop_from_tensor(W, n).ravel())
    A = np.array(cols).T
    U,S,_ = np.linalg.svd(A, full_matrices=False)
    k = int((S > 1e-8*S[0]).sum())
    B = U[:, :k]
    return B, k

def make(n):
    B, k = weyl_basis(n)
    N = len(L.pairs_of(n))
    def M_of(x): return (B@x).reshape(N,N)
    def resid(x):
        M = M_of(x)
        Qm = L.Q(M, n)
        lam = float((Qm*M).sum())/max(float((M*M).sum()),1e-30)
        r = B.T@(Qm - lam*M).ravel()
        return np.concatenate([r, [float((M*M).sum())-1.0]])
    return B, k, M_of, resid

def report(M, n, tag):
    M = M/np.linalg.norm(M)
    Qm = L.Q(M, n); lam=float((Qm*M).sum())
    res=float(np.abs(Qm-lam*M).max())
    K=L.vertex(M,n); ev=np.sort(np.linalg.eigvalsh(K))[::-1]
    pos=ev[ev>1e-9]; ins=pos[pos<lam-1e-9]
    psd=float(np.linalg.eigvalsh(K@K-lam*K).min()); t=float((K*K).sum())
    off=float(np.abs(M-np.diag(np.diag(M))).max())
    print(f"{tag} lam={lam:+.6f} res={res:.0e} t={t:.5f} lam^2={lam*lam:.5f} "
          f"lam2<=t:{'Y' if lam*lam<=t+1e-9 else 'N'} off={off:.1e} r={len(pos)} in={len(ins)} minEig={psd:+.5f}")
    return lam, t, psd, off, len(ins)

if __name__ == "__main__":
    n = int(sys.argv[1]); tries = int(sys.argv[2])
    B,k,M_of,resid = make(n)
    print(f"n={n}: dim<W> = {k} (formula {n*(n+1)*(n+2)*(n-3)//12})")
    rng = np.random.default_rng(2026)
    found = {}
    for tr in range(tries):
        x0 = rng.normal(size=k); x0/=np.linalg.norm(x0)
        sol = least_squares(resid, x0, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=4000)
        if np.abs(sol.fun).max() > 1e-9: continue
        M = M_of(sol.x); M/=np.linalg.norm(M)
        lam = float((L.Q(M,n)*M).sum())
        if lam <= 1e-6: continue
        K = L.vertex(M,n)
        key = round(lam,6)
        if key not in found: found[key]=M
    for key in sorted(found, reverse=True):
        report(found[key], n, f"  lam-class")
