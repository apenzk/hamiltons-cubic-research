"""Directed search: a diagonal critical point with theta>0, Delta>0, lam_max(calL|e-perp) <= theta/2."""
import sys; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C
from scipy.optimize import minimize
from r304_solve import make_space, M_of, solve

def lam_diag(M):
    Bs=C.basis_hollow_zero_rowsum(M.shape[0])
    V=C.orth_complement_of(Bs,M)
    A=C.op_matrix(V, lambda N: C.calL(M,N))
    return float(np.linalg.eigvalsh(A).max())

def stats(M):
    th=C.theta_of(M); d,_=C.defect_delta(M)
    return th,d,lam_diag(M),float(np.abs(C.crit_residual(M)).max())

def obj(x,Bs,dmin,thmin):
    M=M_of(x,Bs)
    if M is None: return 1e6
    th,d,lm,_=stats(M)
    r=C.crit_residual(M)
    return (1e4*float(np.sum(r*r)) + max(0.0, lm-th/2)**2
            + 10*max(0.0, dmin-d)**2 + 10*max(0.0, thmin-th)**2)

def run(n, tries, seed, dmin=0.5, thmin=0.05):
    rng=np.random.default_rng(seed); Bs=make_space(n); best=None
    for t in range(tries):
        x0=rng.normal(size=len(Bs))
        r=minimize(obj,x0,args=(Bs,dmin,thmin),method='Nelder-Mead',
                   options=dict(maxfev=20000,xatol=1e-10,fatol=1e-14))
        M=M_of(r.x,Bs); th,d,lm,res=stats(M)
        score=max(0.0,lm-th/2)
        if th>thmin/2 and d>1e-6 and res<1e-9:
            if best is None or score<best[0]: best=(score,M,th,d,lm,res)
        if t%10==0:
            print(f"  n={n} t={t} f={r.fun:.3e} theta={th:+.4f} Delta={d:.3f} lam={lm:.4f} gap={lm-th/2:+.4f} res={res:.1e}",flush=True)
    return best

if __name__=='__main__':
    n=int(sys.argv[1]); tries=int(sys.argv[2]); seed=int(sys.argv[3])
    b=run(n,tries,seed)
    if b: print(f"BEST n={n}: gap={b[0]:.6f} theta={b[2]:+.6f} Delta={b[3]:.4f} lam={b[4]:.6f} res={b[5]:.1e}")
    else: print(f"BEST n={n}: none admissible")
