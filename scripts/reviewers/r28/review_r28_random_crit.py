"""Attack 5/6 (Reviewer 28): random critical points by Newton root-finding + projected
gradient ascent (for local maxima), then a full spectral audit of T1/T3/T4."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, collections, numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import review_r28_core as R, review_r28_critpoints as CP
from scipy.optimize import root
LOG=_os.path.join(_ROOT, 'agent_logs/review_r28_trace.log')
def log(m):
    with open(LOG,'a') as f: f.write(time.strftime('%H:%M:%S ')+m+'\n')

def make(n):
    basis,_,_=R.weyl_basis(n); D=basis.shape[0]
    def qof(w):
        W=np.einsum('d,dij->ij',w,basis); return np.einsum('ij,dij->d',R.Q(n,W),basis), W
    def F(z):
        w=z[:D]; th=z[D]; q,_=qof(w); return np.concatenate([q-th*w,[w@w-1.0]])
    def J(z):
        w=z[:D]; th=z[D]; q,W=qof(w); Lm,_=R.L_matrix(n,W)
        return np.vstack([np.hstack([2*Lm-th*np.eye(D), -w.reshape(-1,1)]),
                          np.hstack([2*w,[0.0]])])
    return basis,D,qof,F,J

def ascend(n,w,qof,steps=4000):
    """projected gradient ascent of P on the unit sphere (grad P = 3 q)."""
    s=0.2
    for it in range(steps):
        q,_=qof(w); th=w@q
        g=q-th*w
        if np.linalg.norm(g)<1e-13: break
        wn=w+s*g; wn/=np.linalg.norm(wn)
        qn,_=qof(wn); thn=wn@qn
        if thn>th: w=wn; s*=1.05
        else: s*=0.5
        if s<1e-14: break
    return w

if __name__=='__main__':
    n=int(sys.argv[1]); tries=int(sys.argv[2]); seed=int(sys.argv[3]) if len(sys.argv)>3 else 2024
    basis,D,qof,F,J=make(n)
    rng=np.random.default_rng(seed)
    kappa=(2*n-1)*(n-1)/4.0; th0=R.theta0(n)
    print(f'n={n} D={D} kappa={kappa} theta0={th0:.6f}')
    seen={}
    def audit(w,tag):
        W=np.einsum('d,dij->ij',w,basis)
        r,th=CP.crit_resid(n,W)
        if r>1e-10 or abs(th)<1e-8: return
        if th<0: W=-W; th=-th
        o=CP.analyse(n,W,tag); ev=o['ev']
        key=(round(th,5),o['orb'],round(float(np.square(ev).sum()),5))
        if key in seen: return
        seen[key]=1
        orb=o['orb']; ker=int((np.abs(ev)<1e-8).sum())
        bnd=1+orb/4+(1+orb/2)**2/(D-1-orb); thb=np.sqrt(kappa/bnd)
        print(f'  [{tag}] th={th:.6f} orb={orb:3d} m(1)={o["mone"]} m(1/2)={o["mhalf"]:3d} ker={ker:4d} '
              f'lmax={ev[-1]:.6f} lmin={ev[0]:.6f} |sum|={abs(o["s1"]):.1e} th2S2={o["T3"]:.9f} '
              f'devT3={abs(o["T3"]-kappa):.1e} T4bnd={thb:.4f} ratio={thb/th0:.3f} S3={o["s3"]:.5f} th2S3={th*th*o["s3"]:.5f}')
        sys.stdout.flush()
    for t in range(tries):
        w0=rng.normal(size=D); w0/=np.linalg.norm(w0)
        q0,_=qof(w0); sol=root(F,np.concatenate([w0,[w0@q0]]),jac=J,method='hybr',tol=1e-13)
        if sol.success and np.linalg.norm(F(sol.x))<1e-10: audit(sol.x[:D],'newton')
        if t< max(12,tries//8):
            audit(ascend(n,w0,qof),'ascent')
        if t%25==0: log(f'random crit n={n}: {t}/{tries}, {len(seen)} distinct')
    log(f'random crit n={n} DONE: {len(seen)} distinct')
