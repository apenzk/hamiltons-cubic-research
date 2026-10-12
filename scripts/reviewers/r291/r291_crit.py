"""Find diagonal critical points that are NOT maximisers, and test C7/C8/C9 there."""
import sys, numpy as np
from scipy.optimize import minimize
sys.path.insert(0,'scripts/lib'); sys.path.insert(0,'scripts/reviewers/r291')
from r291_core import *

def unpack(n, x, B):
    v = x @ B; v = v/np.linalg.norm(v)
    return vec_to_M(n, v)

def res(n, x, B):
    M = unpack(n, x, B)
    th = float(0.5*(np.sum(M**3) + np.trace(M@M@M)))
    R = M*M + M@M - th*M - np.diag(np.sum(M*M,axis=1))
    return float(np.sum(R*R))

rng = np.random.default_rng(2911)
print("=== diagonal critical points from residual minimisation ===")
print(f"  {'n':>2s} {'theta':>10s} {'crit':>9s} {'|C7|':>9s} {'|C9|':>9s} {'cap':>10s} "
      f"{'cap-theta':>11s} {'cap2-theta':>11s} {'Delta':>9s} {'S':>6s} {'theta_0':>9s}")
found=[]
for n in (5,6,7,8):
    B = locus_basis(n); k=B.shape[0]
    th0=np.sqrt(2*(n-1)*(n-2))/n
    vals=[]
    for r in range(120):
        x0 = rng.normal(size=k)
        out = minimize(lambda x: res(n,x,B), x0, method='BFGS',
                       options={'maxiter':2000,'gtol':1e-14})
        if out.fun > 1e-20: 
            out = minimize(lambda x: res(n,x,B), out.x, method='Nelder-Mead',
                           options={'maxiter':20000,'xatol':1e-14,'fatol':1e-22})
        if out.fun > 1e-16: continue
        M = unpack(n,out.x,B)
        th = float(0.5*(np.sum(M**3)+np.trace(M@M@M)))
        if any(abs(th-t)<1e-6 for t in vals): continue
        vals.append(th)
        s=np.sum(M*M,axis=1)
        D,tot,S,g,lam = defect_diag(n,M)
        prs=pairs_of(n)
        gC7=np.array([2*(s[a]+s[b])-4*th*M[a,b] for (a,b) in prs])
        dplus=np.array([np.sum(M[a]>1e-12) for a in range(n)])
        L1=sum(abs(M[a,b]) for (a,b) in prs)
        cap=min((s[a]+s[b])/(2*M[a,b]) for (a,b) in prs if M[a,b]>1e-12)
        # strengthened cap: keep the single largest term of the g-sum
        cap2=min((s[a]+s[b]-max((M[a,c]-M[b,c])**2 for c in range(n) if c not in (a,b)))
                 /(2*M[a,b]) for (a,b) in prs if M[a,b]>1e-12)
        print(f"  {n:>2d} {th:>10.6f} {np.sqrt(out.fun):>9.1e} {np.abs(g-gC7).max():>9.1e} "
              f"{abs(th*L1-(dplus@s-D/2)):>9.1e} {cap:>10.6f} {cap-th:>+11.3e} {cap2-th:>+11.3e} "
              f"{D:>9.4f} {S:>6.1f} {th0:>9.6f}")
        found.append((n,th,cap,D,S,M))
np.save('/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/crit.npy',
        np.array([1.0]))
