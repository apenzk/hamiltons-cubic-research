import numpy as np, core, fam, sys, time
from scipy.optimize import least_squares
n=int(sys.argv[1]); nst=int(sys.argv[2]); tlim=float(sys.argv[3])
wl=core.Weyl(n); K=wl.K; c=wl.c; d=K.shape[1]
def unpack(x):
    W=wl.from_vec(K@x); W=W/np.linalg.norm(W); return W
def th_of(W): return float(np.tensordot(W,core.Q(W,c),2))
def crit_resid(x):
    W=unpack(x); t=th_of(W); r=core.Q(W,c)-t*W
    return np.append(K.T@wl.to_vec(r), np.linalg.norm(x)-1.0)
def sat_resid(x):
    W=unpack(x); t=th_of(W); r=core.Q(W,c)-t*W
    ev=np.linalg.eigvalsh(W); slack=ev[0]+(n-2)*ev[-1]-t
    return np.concatenate([K.T@wl.to_vec(r),[np.linalg.norm(x)-1.0],[slack]])
rng=np.random.default_rng(20260901+n)
t0=time.time(); rows=[]
for mode,fn in [("crit",crit_resid),("crit+sat",sat_resid)]:
    hits=[]
    for i in range(nst):
        if time.time()-t0>tlim: break
        x0=rng.normal(size=d); x0/=np.linalg.norm(x0)
        s=least_squares(fn,x0,xtol=1e-13,ftol=1e-13,gtol=1e-13,max_nfev=300)
        W=unpack(s.x); t=th_of(W); ev=np.linalg.eigvalsh(W)
        cres=np.linalg.norm(core.Q(W,c)-t*W); slack=ev[0]+(n-2)*ev[-1]-t
        if cres<1e-9: hits.append((slack,t,cres,wl.dist(W),ev))
    if hits:
        hits.sort()
        print(f"n={n} mode={mode}: {len(hits)} genuine critical points; min slack={hits[0][0]:.6e} "
              f"(theta={hits[0][1]:+.6f}, res={hits[0][2]:.1e}, distWeyl={hits[0][3]:.1e})")
        for s_,t_,c_,dw_,ev_ in hits[:4]:
            print(f"    slack={s_:+.9f} theta={t_:+.6f} res={c_:.1e} dW={dw_:.1e} "
                  f"lmin={ev_[0]:+.5f} lmax={ev_[-1]:+.5f} nev={len(np.unique(np.round(ev_,6)))}")
    else:
        print(f"n={n} mode={mode}: no converged critical point in the budget")
