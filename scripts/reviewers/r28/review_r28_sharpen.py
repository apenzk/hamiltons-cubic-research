"""Attack 7/8 (Reviewer 28): recompute the T4 bound, and test sharpenings.

(A) local maxima of P on the unit sphere in Weyl_n (projected gradient ascent + Newton polish)
(B) c_n := max_{||y||=1} ||Q(y)||  -- the Cauchy-Schwarz ceiling for theta; is it theta_0?
(C) the T4 bound table and the kernel size that would be needed to make it bite.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import review_r28_core as R, review_r28_critpoints as CP
from scipy.optimize import root
LOG=_os.path.join(_ROOT, 'agent_logs/review_r28_trace.log')
def log(m):
    with open(LOG,'a') as f: f.write(time.strftime('%H:%M:%S ')+m+'\n')

def tools(n):
    basis,_,_=R.weyl_basis(n); D=basis.shape[0]
    def qof(w):
        W=np.einsum('d,dij->ij',w,basis); return np.einsum('ij,dij->d',R.Q(n,W),basis), W
    return basis,D,qof

def ascent_P(n,rng,tries=25):
    basis,D,qof=tools(n); best=[]
    for t in range(tries):
        w=rng.normal(size=D); w/=np.linalg.norm(w); s=0.3
        for it in range(6000):
            q,_=qof(w); th=w@q; g=q-th*w
            if np.linalg.norm(g)<1e-14: break
            wn=w+s*g; wn/=np.linalg.norm(wn); qn,_=qof(wn); thn=wn@qn
            if thn>th: w=wn; s*=1.1
            else: s*=0.5
            if s<1e-15: break
        q,_=qof(w); best.append(w@q)
    return np.array(best)

def ascent_normQ(n,rng,tries=25):
    """maximize ||Q(y)||^2 over the unit sphere.  grad of ||Q||^2 = 4 L_Y Q(Y)."""
    basis,D,qof=tools(n); best=[]; argb=None; bv=-1
    for t in range(tries):
        w=rng.normal(size=D); w/=np.linalg.norm(w); s=0.3
        for it in range(6000):
            q,W=qof(w); f=q@q
            Lm,_=R.L_matrix(n,W); g=4*(Lm@q); g=g-(g@w)*w
            if np.linalg.norm(g)<1e-13: break
            wn=w+s*g; wn/=np.linalg.norm(wn); qn,_=qof(wn)
            if qn@qn>f: w=wn; s*=1.1
            else: s*=0.5
            if s<1e-16: break
        q,_=qof(w); best.append(np.sqrt(q@q))
        if q@q>bv: bv=q@q; argb=w.copy()
    return np.array(best), argb

if __name__=='__main__':
    rng=np.random.default_rng(31)
    for n in [int(x) for x in sys.argv[1:]] or [6]:
        basis,D,qof=tools(n); th0=R.theta0(n)
        a=ascent_P(n,rng, 25)
        b,argb=ascent_normQ(n,rng, 25)
        q,Wb=qof(argb); thb=argb@q
        print(f'n={n} D={D} theta0={th0:.6f}')
        print(f'   max P over sphere (25 ascents): {a.max():.9f}   top5 {np.array2string(np.sort(a)[-5:],precision=6)}')
        print(f'   c_n = max||Q(y)||   (25 ascents): {b.max():.9f}   ratio to theta0 = {b.max()/th0:.4f}'
              f'   (at the argmax, <y,Q(y)>={thb:.6f}, ||y o y - .. || crit resid={CP.crit_resid(n,Wb)[0]:.2e})')
        sys.stdout.flush()
        log(f'sharpen n={n}: maxP={a.max():.6f}, c_n={b.max():.6f}, theta0={th0:.6f}')
