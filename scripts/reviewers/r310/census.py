import sys, os, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib310 as L
from scipy.optimize import least_squares

def V_basis(n):
    P_ = L.pairs(n); D = len(P_)
    rows = []
    for a in range(n):
        r = np.zeros(D)
        for k,(i,j) in enumerate(P_):
            if i==a or j==a: r[k]=1.0
        rows.append(r)
    A = np.array(rows)
    u,s,vt = np.linalg.svd(A)
    return vt[np.sum(s > 1e-10):]          # (D-n) x D orthonormal

def M_of(x, NS, n):
    v = NS.T @ x
    M = np.zeros((n,n))
    for k,(a,b) in enumerate(L.pairs(n)):
        M[a,b]=M[b,a]=v[k]
    return M

def resid(x, NS, n):
    nx = np.linalg.norm(x)
    M = M_of(x/nx, NS, n)
    Phi = M*M + M@M
    th = 0.5*(np.sum(M**3) + np.trace(M@M@M))
    Rm = Phi - th*M
    np.fill_diagonal(Rm, 0.0)
    P_ = L.pairs(n)
    r = np.array([Rm[a,b] for (a,b) in P_])
    return np.concatenate([NS @ r, [nx-1.0]])

def find(n, seed):
    rng = np.random.default_rng(seed)
    NS = V_basis(n)
    x0 = rng.normal(size=NS.shape[0]); x0/=np.linalg.norm(x0)
    sol = least_squares(resid, x0, args=(NS,n), xtol=1e-15, ftol=1e-15, gtol=1e-15)
    if np.max(np.abs(sol.fun)) > 1e-12: return None
    x = sol.x/np.linalg.norm(sol.x)
    M = M_of(x, NS, n)
    return M

if __name__=="__main__":
    n = int(sys.argv[1]); N = int(sys.argv[2])
    out=[]
    for s in range(N):
        M = find(n, s)
        if M is None: continue
        W = L.W_from_M(M)
        nrm = L.ip(W,W)
        if abs(nrm-1) > 1e-9: continue
        th = L.P(W)
        if th <= 1e-6: continue
        if np.abs(L.Q(W)-th*W).max() > 1e-11: continue
        dl,_ = L.diag_L_eigs(M)
        dlam = dl[-1]
        d = L.defect_diag(M, tol=1e-9)
        out.append((th, d, dlam, dlam/th, M))
    np.save(f'scripts/reviewers/r310/census_n{n}.npy',
            np.array([m for (_,_,_,_,m) in out]))
    arr = np.array([[t,d,l,r] for (t,d,l,r,_) in out])
    np.save(f'scripts/reviewers/r310/censusstats_n{n}.npy', arr)
    pos = arr[arr[:,1] > 1e-8]
    print(f'n={n} found {len(arr)} critical theta>0; Delta>0: {len(pos)}')
    if len(pos):
        print('  min diag lam_max(L_e)=lam/theta :', pos[:,3].min())
        print('  min diag lam_max(L_W)           :', pos[:,2].min())
        print('  theta range', pos[:,0].min(), pos[:,0].max())
    z = arr[arr[:,1] <= 1e-8]
    if len(z): print('  Delta=0 count',len(z),'lam/theta range',z[:,3].min(),z[:,3].max())
