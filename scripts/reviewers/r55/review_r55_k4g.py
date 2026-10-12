"""Reviewer 55, K4g: blow-ups of odd cycles C_k, via the circulant ansatz.

Circulants form a commutative algebra, so C = circ(c_0,...,c_{k-1}) closes under
the block criticality system for any cycle:
    a != b : C_ab^2 + m (C^2)_ab - 2 c_0 C_ab = t C_ab
    a  = b : m (C^2)_aa - c_0^2 = t c_0
    Weyl   : (m-1) c_0 + m sum_{j!=0} C_0j = 0
"""
import numpy as np, sys
from scipy.optimize import least_squares
sys.path.insert(0, 'scripts/lib')
from review_r55_core import theta0
from review_r55_k4 import stats

def circulant(k, cs):
    C=np.zeros((k,k))
    for a in range(k):
        for b in range(k):
            C[a,b]=cs[min((a-b)%k,(b-a)%k)]
    return C

def solve_cycle(k, m, ntry=600, seed=0):
    h=k//2
    rng=np.random.default_rng(seed); out=[]
    def res(x):
        cs=np.concatenate([[1.0], x[:h]]); t=x[h]
        C=circulant(k,cs); C2=C@C
        r=[]
        for j in range(1,h+1):
            r.append(C[0,j]**2 + m*C2[0,j] - 2*C[0,0]*C[0,j] - t*C[0,j])
        r.append(m*C2[0,0]-C[0,0]**2-t*C[0,0])
        r.append((m-1)*C[0,0]+m*(C[0].sum()-C[0,0]))
        return np.array(r)
    for _ in range(ntry):
        x0=np.concatenate([rng.normal(scale=0.5,size=h),[rng.normal(scale=2*m)]])
        s=least_squares(res,x0,method='lm',xtol=1e-15,ftol=1e-15,gtol=1e-15,max_nfev=6000)
        if np.linalg.norm(s.fun)>1e-9: continue
        cs=np.concatenate([[1.0], s.x[:h]])
        if not any(np.allclose(cs,o,atol=1e-7) for o in out): out.append(cs)
    return out

if __name__=="__main__":
    print(f"{'C_k':>6} {'m':>6} {'n':>6} {'theta/theta0':>13} {'tri':>6} {'bip':>6} {'branch (c0,c1,...)'}")
    for k in (5,7,9,11,13):
        for m in (2,3,5,10,50,500):
            sols=solve_cycle(k,m,ntry=300,seed=k)
            best=None
            for cs in sols:
                C=circulant(k,cs); sizes=[m]*k
                d=stats(C,sizes)
                if d['tri']!=0: continue
                if d['bip']: continue
                if d['isolated']!=0 or d['comps']!=1: continue
                if best is None or d['ratio']>best[0]['ratio']: best=(d,cs)
            if best is None:
                print(f"{k:>6} {m:>6} {k*m:>6}   none"); continue
            d,cs=best
            print(f"{k:>6} {m:>6} {k*m:>6} {d['ratio']:13.9f} {d['tri']:6d} {str(d['bip']):>6} {np.round(cs,5)}")
